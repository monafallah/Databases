SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametrHesabdariUpdate] 
    @fldId int,
    @fldShomareHesabCodeDaramadId int,
    @fldCodeHesab nvarchar(20) = NULL,
    @fldHesabId int = NULL,
    @fldCompanyId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Drd].[tblParametrHesabdari]
	SET    [fldShomareHesabCodeDaramadId] = @fldShomareHesabCodeDaramadId, [fldCodeHesab] = @fldCodeHesab, [fldHesabId] = @fldHesabId, [fldCompanyId] = @fldCompanyId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
