SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterUpdate] 
    @fldID bigint,
    
    @fldSubject nvarchar(300),
    @fldLetterNumber nvarchar(50),
    @fldLetterDate nvarchar(10),
    @fldKeywords nvarchar(300),
 
    @fldComisionID int,
    @fldImmediacyID int,
    @fldSecurityTypeID int,
    @fldLetterTypeID int,
    @fldSignType tinyint,
	@fldMatnLetter nvarchar(max),
	@fldLetterTemplateId int,
	@fldFont nvarchar(30),
    @fldUserID int,
    @fldDesc nvarchar(100),
	@fldOrganId int,
	@fldIP nvarchar(16)
AS 
	BEGIN TRAN
	set @fldSubject=com.fn_TextNormalize(@fldSubject)
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	 --set @fldMatnLetter=com.fn_TextNormalize(@fldMatnLetter)
	UPDATE [Auto].[tblLetter]
	SET    [fldSubject] = @fldSubject,fldLetterNumber=@fldLetterNumber,fldLetterDate=@fldLetterDate, [fldKeywords] = @fldKeywords, [fldComisionID] = @fldComisionID, [fldImmediacyID] = @fldImmediacyID, [fldSecurityTypeID] = @fldSecurityTypeID, [fldLetterTypeID] = @fldLetterTypeID,fldSignType=@fldSignType,  [fldDesc] = @fldDesc,fldDate=GETDATE()
	,fldOrganId=@fldOrganId,fldIP=@fldIp,fldMatnLetter=@fldMatnLetter,fldLetterTemplateId=@fldLetterTemplateId,fldFont=@fldFont
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN
GO
