SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHokmReportUpdate] 
    @fldId int,
    @fldName nvarchar(50),
    @fldFileId int,
     @fldFile VARBINARY(max),
    @fldPasvand NVARCHAR(5),
    @fldAnvaEstekhdamId int,

    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldPasvand=Com.fn_TextNormalize(@fldPasvand)
	SET @fldName=Com.fn_TextNormalize(@fldName)
	DECLARE @flag BIT=0
	IF(@fldFile IS null)
	BEGIN
	UPDATE [Prs].[tblHokmReport]
	SET    [fldId] = @fldId, [fldName] = @fldName, [fldFileId] = @fldFileId, [fldAnvaEstekhdamId] = @fldAnvaEstekhdamId,  [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	END
	ELSE
	BEGIN
	UPDATE [Prs].[tblHokmReport]
	SET    [fldId] = @fldId, [fldName] = @fldName, [fldFileId] = @fldFileId, [fldAnvaEstekhdamId] = @fldAnvaEstekhdamId,[fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=0
	END
	IF(@flag=0)
	begin
	UPDATE Com.tblFile
	SET fldImage=@fldFile,fldPasvand=@fldPasvand,fldDesc=@fldDesc,fldDate=GETDATE()
	WHERE fldid=@fldFileId
	END
	end
	COMMIT TRAN
GO
