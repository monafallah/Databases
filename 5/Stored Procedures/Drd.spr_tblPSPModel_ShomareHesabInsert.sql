SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPSPModel_ShomareHesabInsert] 

    @fldPSPModelId int,
    @fldShHesabId int,
    @fldOrder tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblPSPModel_ShomareHesab] 
	INSERT INTO [Drd].[tblPSPModel_ShomareHesab] ([fldId], [fldPSPModelId], [fldShHesabId], [fldOrder], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldPSPModelId, @fldShHesabId, @fldOrder, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
