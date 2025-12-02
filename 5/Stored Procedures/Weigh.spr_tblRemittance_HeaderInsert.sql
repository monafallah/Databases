SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblRemittance_HeaderInsert] 

    @fldAshkhasiId int,
    @fldStatus bit,
    @fldStartDate varchar(10),
    @fldEndDate varchar(10),
	@Detail Weigh.tblRemittance_Details readonly,
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
	declare @fldID int ,@_DetialId int,@fldFileId int,@flag bit=0
	select @fldID =ISNULL(max(fldId),0)+1 from [Weigh].[tblRemittance_Header] 
	if (@fldFile is not null)
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
	if (@flag=0)
	begin
		INSERT INTO [Weigh].[tblRemittance_Header] ([fldId], [fldAshkhasiId], [fldStatus], [fldStartDate], [fldEndDate], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP],fldTitle,fldEmployId,fldChartOrganEjraeeId,fldFileid)
		SELECT @fldId, @fldAshkhasiId, @fldStatus, @fldStartDate, @fldEndDate, @fldUserId, @fldOrganId, @fldDescHeader, getdate(), @fldIP,@fldTitle,@fldEmployId,@fldChartOrganEjraeeId,@fldFileId
		if(@@Error<>0)
			rollback    
		else
		begin
			select @_DetialId =ISNULL(max(fldId),0)+1 from [Weigh].[tblRemittance_Details] 
			INSERT INTO [Weigh].[tblRemittance_Details] ([fldId], [fldRemittanceId], [fldKalaId], [fldMaxTon], [fldControlLimit], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP])
			select row_number()over (order by fldKalaId)+@_DetialId,@fldid,fldKalaId,fldMaxTon,fldControlLimit,@fldUserId,@fldOrganId,isnull(fldDesc,''),getdate(),@fldIP from @Detail
			if(@@Error<>0)
				rollback
		end
	end	   
	COMMIT
GO
