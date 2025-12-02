SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblAfradeTahtePoshesheBimeTakmily_DetailsInsert] 

    @fldAfradTahtePoshehsId int,
    @fldBimeTakmiliId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 

	
	BEGIN TRAN
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] 

	INSERT INTO [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] ([fldId], [fldAfradTahtePoshehsId], [fldBimeTakmiliId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldAfradTahtePoshehsId, @fldBimeTakmiliId, @fldUserId, @fldDesc, getdate()
	if(@@Error<>0)
        rollback       
	COMMIT
GO
