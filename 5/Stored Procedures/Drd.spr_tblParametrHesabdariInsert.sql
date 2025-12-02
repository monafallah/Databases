SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametrHesabdariInsert] 
    @fldShomareHesabCodeDaramadId int,
    @fldCodeHesab nvarchar(20) = NULL,
    @fldHesabId int = NULL,
    @fldCompanyId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblParametrHesabdari] 
	INSERT INTO [Drd].[tblParametrHesabdari] ([fldId], [fldShomareHesabCodeDaramadId], [fldCodeHesab], [fldHesabId], [fldCompanyId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldShomareHesabCodeDaramadId, @fldCodeHesab, @fldHesabId, @fldCompanyId, @fldUserId, @fldDesc, getdate()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
