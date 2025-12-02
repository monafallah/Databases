SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblRemittance_HeaderUpdate] 
    @fldHeaderId int,
    @fldAshkhasiId int,
    @fldStatus bit,
    @fldStartDate varchar(10),
    @fldEndDate varchar(10),
	@Detail Weigh.tblRemittance_Details readonly,
	@fldFileId int,
	@fldFile varbinary (max),
	@fldpasvand nvarchar(5),
    @fldUserId int,
    @fldOrganId int,
    @fldDescHeader nvarchar(500),
	@fldEmployId int,
	@fldChartOrganEjraeeId int,
    @fldIP varchar(15),
	@fldTitle nvarchar(100)
AS 

	BEGIN TRAN
	set @fldDescHeader=com.fn_TextNormalize(@fldDescHeader)
	declare @_DetialId int,@flag bit=0
	if (@fldFile is not null and  @fldFileId is null)
	begin
		select @fldFileId =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
		INSERT INTO [Com].[tblFile] ([fldId], [fldImage],fldPasvand, [fldUserId], [fldDesc], [fldDate])
		SELECT @fldFileId, @fldFile,@fldPasvand, @fldUserId, N'تاسیسات-حواله', GETDATE()
		if (@@ERROR<>0)
		begin
			rollback
			set @flag=1
		end
	end
	else if (@fldFile is not null and  @fldFileId is not  null)
	begin
		update [Com].[tblFile] 
		set fldImage=@fldFile,fldPasvand=@fldpasvand,fldUserId=@fldUserId,fldDate=getdate()
		where fldId=@fldFileId
		if (@@ERROR<>0)
		begin
			rollback
			set @flag=1
		end
	end

	if (@flag=0)
	begin
		UPDATE [Weigh].[tblRemittance_Header]
		SET    [fldAshkhasiId] = @fldAshkhasiId, [fldStatus] = @fldStatus, [fldStartDate] = @fldStartDate, [fldEndDate] = @fldEndDate, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDescHeader, [fldDate] = getdate(), [fldIP] = @fldIP
		,fldTitle=@fldTitle,fldEmployId=@fldEmployId,fldChartOrganEjraeeId=@fldChartOrganEjraeeId,fldFileid=@fldFileId
		WHERE  fldId=@fldHeaderId
		if(@@Error<>0)
			rollback   
		else
		begin
			Delete from [Weigh].[tblRemittance_Details]
			where fldRemittanceId=@fldHeaderId
			if(@@Error<>0)
				rollback   
			else
			begin
				select @_DetialId =ISNULL(max(fldId),0)+1 from [Weigh].[tblRemittance_Details] 
				INSERT INTO [Weigh].[tblRemittance_Details] ([fldId], [fldRemittanceId], [fldKalaId], [fldMaxTon], [fldControlLimit], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP])
				select row_number()over (order by fldKalaId)+@_DetialId,@fldHeaderId,fldKalaId,fldMaxTon,fldControlLimit,@fldUserId,@fldOrganId,fldDesc,getdate(),@fldIP from @Detail
				if(@@Error<>0)
					rollback
			end
		end
	end
	COMMIT
GO
