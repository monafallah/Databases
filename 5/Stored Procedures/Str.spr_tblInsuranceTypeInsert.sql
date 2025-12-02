SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblInsuranceTypeInsert] 
 
    @fldTitle nvarchar(100),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldOrganId INT,
    @fldIp VARCHAR(16)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Str].[tblInsuranceType] 
	INSERT INTO [Str].[tblInsuranceType] ([fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate],[fldOrganId],[fldIp])
	SELECT @fldId, @fldTitle, @fldUserId, @fldDesc, GETDATE(),@fldOrganId,@fldIp
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
