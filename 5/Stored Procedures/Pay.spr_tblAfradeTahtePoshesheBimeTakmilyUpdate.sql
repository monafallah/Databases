SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblAfradeTahtePoshesheBimeTakmilyUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldTedadAsli int,
    @fldTedadTakafol60Sal int,
    @fldTedadTakafol70Sal int,
	@fldTedadBedonePoshesh tinyint,
    @fldGHarardadBimeId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldAfradTahtePoshehsId varchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblAfradeTahtePoshesheBimeTakmily]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldTedadAsli] = @fldTedadAsli, [fldTedadTakafol60Sal] = @fldTedadTakafol60Sal, [fldTedadTakafol70Sal] = @fldTedadTakafol70Sal, [fldGHarardadBimeId] = @fldGHarardadBimeId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	,fldTedadBedonePoshesh=@fldTedadBedonePoshesh
	WHERE  [fldId] = @fldId
	if (@@ERROR<>0)
		ROLLBACK
	else
	begin
		delete [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] where fldBimeTakmiliId=@fldId
		if (@@ERROR<>0)
		ROLLBACK
		else
		begin
			declare @fldDetailID int 
			select @fldDetailID =ISNULL(max(fldId),0) from [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] 

			INSERT INTO [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] ([fldId], [fldAfradTahtePoshehsId], [fldBimeTakmiliId], [fldUserId], [fldDesc], [fldDate])
			SELECT @fldDetailID+ROW_NUMBER() over(order by item), Item, @fldID, @fldUserId, @fldDesc, getdate()
			from com.Split(@fldAfradTahtePoshehsId,';')
			where Item<>''
			if(@@Error<>0)
				rollback   
		end
	end
	COMMIT TRAN
GO
