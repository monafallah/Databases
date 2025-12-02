SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblReplyTaghsitInsert] 

    @fldMablaghNaghdi bigint,
    @fldTedadAghsat tinyint,
    @fldShomareMojavez nvarchar(50),
    @fldTarikh nvarchar(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldStatusId int,
	@fldTedadMahAghsat tinyint,
	@fldJarimeTakhir bigint
    
AS 
	
	BEGIN TRAN
	set @fldShomareMojavez=com.fn_TextNormalize(@fldShomareMojavez)
	set @fldTarikh=com.fn_TextNormalize(@fldTarikh)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int --,@CodeTakhir int,@fldShomareHesabId INT,@fldElamAvarezId INT,@CodeDaramadElamId INT,@flag INT
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblReplyTaghsit] 
	INSERT INTO [Drd].[tblReplyTaghsit] ([fldId],  [fldMablaghNaghdi], [fldTedadAghsat], [fldShomareMojavez], [fldTarikh], [fldUserId], [fldDesc], [fldDate],fldStatusId,fldTedadMahAghsat,fldJarimeTakhir)
	SELECT @fldId, @fldMablaghNaghdi, @fldTedadAghsat, @fldShomareMojavez, @fldTarikh, @fldUserId, @fldDesc, GETDATE(),@fldStatusId,@fldTedadMahAghsat,@fldJarimeTakhir
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
