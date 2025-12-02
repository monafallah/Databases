SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblAfradeTahtePoshesheBimeTakmily_DetailsUpdate] 
    @fldId int,
    @fldAfradTahtePoshehsId int,
    @fldBimeTakmiliId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 

	BEGIN TRAN

	UPDATE [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details]
	SET    [fldAfradTahtePoshehsId] = @fldAfradTahtePoshehsId, [fldBimeTakmiliId] = @fldBimeTakmiliId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
