SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblShomareNameHaInsert] 
  
    @fldMokatebatId int = NULL,
    @fldReplyTaghsitId int = NULL,
    @fldShomare INT out,
    @fldStartNumber int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
   
AS 
	
	BEGIN TRAN
	DECLARE @fldID INT ,@fldYear SMALLINT 
	IF (@fldMokatebatId IS NOT null)
	BEGIN
		SELECT @fldYear=fldYear FROM drd.tblMokatebat WHERE fldid=@fldMokatebatId
		select @fldShomare=ISNULL(max(fldShomare),@fldStartNumber-1)+1 from [tblShomareNameHa] where fldYear=@fldYear AND @fldMokatebatId IS NOT NULL
	end
	ELSE IF (@fldReplyTaghsitId IS NOT NULL)
	BEGIN
		SELECT @fldYear=fldYear FROM Drd.tblReplyTaghsit WHERE fldId=@fldReplyTaghsitId
		select @fldShomare=ISNULL(max(fldShomare),@fldStartNumber-1)+1 from [tblShomareNameHa] where fldYear=@fldYear AND @fldReplyTaghsitId IS NOT NULL
	end
	set  @fldDesc=com.fn_TextNormalize(@fldDesc)
	
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblShomareNameHa] 
	INSERT INTO [Drd].[tblShomareNameHa] ([fldId], [fldMokatebatId], [fldReplyTaghsitId], [fldYear], [fldShomare], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldMokatebatId, @fldReplyTaghsitId, @fldYear, @fldShomare, @fldUserId, @fldDesc, getDate()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
