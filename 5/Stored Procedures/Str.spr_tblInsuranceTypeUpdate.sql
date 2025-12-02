SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblInsuranceTypeUpdate] 
    @fldId int,
    @fldTitle nvarchar(100),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldOrganId INT,
    @fldIp VARCHAR(16)
AS 
	BEGIN TRAN
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Str].[tblInsuranceType]
	SET    [fldId] = @fldId, [fldTitle] = @fldTitle, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),[fldOrganId]=@fldOrganId,[fldIp]=@fldIp
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
