SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblRooneveshtInsert] 

    @fldShomareHesabCodeDaramadId int,
    @fldTitle nvarchar(400),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	set @fldTitle=com.fn_TextNormalize(@fldTitle)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblRoonevesht] 
	INSERT INTO [Drd].[tblRoonevesht] ([fldId], [fldShomareHesabCodeDaramadId], [fldTitle], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldShomareHesabCodeDaramadId, @fldTitle, @fldUserId,getDate(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
