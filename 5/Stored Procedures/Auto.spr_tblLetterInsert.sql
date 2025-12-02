SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterInsert] 
	@fldID bigint out,
    @fldYear	int,
	@fldOrderId	bigint output,
    @fldSubject nvarchar(300),
    @fldLetterNumber nvarchar(50),
    @fldLetterDate nvarchar(10),
    @fldKeywords nvarchar(300),
    @fldLetterStatusID int,
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
	select @fldId =ISNULL(max(fldId),0)+1 from [Auto].[tblLetter]
	select @fldOrderId =ISNULL(max(fldOrderId),0)+1 from [Auto].[tblLetter] where fldYear=@fldYear
	set @fldSubject=com.fn_TextNormalize(@fldSubject)
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	--set @fldMatnLetter=com.fn_TextNormalize(@fldMatnLetter)
	BEGIN TRAN
	declare @tarikh nvarchar(20)=dbo.Fn_AssembelyMiladiToShamsi (getdate())+' '+cast(cast(getdate() as time (0))as varchar(8))
	INSERT INTO [Auto].[tblLetter] ([fldID], [fldYear], [fldOrderId], [fldSubject], [fldLetterNumber], [fldLetterDate], [fldCreatedDate], [fldKeywords], [fldLetterStatusID], [fldComisionID], [fldImmediacyID], [fldSecurityTypeID], [fldLetterTypeID],fldSignType, [fldDate], [fldUserID], [fldDesc],fldOrganId,fldIP,fldMatnLetter,fldLetterTemplateId,fldFont)
	
	SELECT @fldID, @fldYear, @fldOrderId, @fldSubject, @fldLetterNumber, @fldLetterDate, @tarikh, @fldKeywords, @fldLetterStatusID, @fldComisionID, @fldImmediacyID, @fldSecurityTypeID, @fldLetterTypeID,@fldSignType, GETDATE(), @fldUserID, @fldDesc,@fldOrganId,@fldIP,@fldMatnLetter,@fldLetterTemplateId,@fldFont
         
	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
