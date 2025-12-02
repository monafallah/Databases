SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblAssignmentInsert] 
    @fldID int output,
    @fldLetterID bigint,
	@fldMessageId int,
    @fldAnswerDate nvarchar(20),
    @fldSourceAssId	bigint,
    @fldUserID int,
    @fldDesc nvarchar(100),
	@fldOrganId int,
	@fldIP nvarchar(16)
AS 
	select @fldId =ISNULL(max(fldId),0)+1 from [Auto].[tblAssignment]
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare  @tarikh nvarchar(20)
	set @tarikh=dbo.Fn_AssembelyMiladiToShamsi(getdaTE())+' '+ cast(cast(getdaTE() as time (0))as varchar(8))
	BEGIN TRAN
	
	INSERT INTO [Auto].[tblAssignment] ([fldID], [fldLetterID],fldMessageId, [fldAssignmentDate], [fldAnswerDate], [fldSourceAssId], [fldDate], [fldUserID], [fldDesc],fldOrganId ,fldIp)
	
	SELECT @fldID, @fldLetterID,@fldMessageId, @tarikh, @fldAnswerDate, @fldSourceAssId, GETDATE(), @fldUserID, @fldDesc,@fldOrganId,@fldIp
         
	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
