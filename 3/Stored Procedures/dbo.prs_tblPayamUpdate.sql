SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblPayamUpdate] 
    @fldId int,
    @fldNameShakhs nvarchar(300),
    @fldMobile varchar(11),
    @fldEmail nvarchar(100),
    @fldSubject nvarchar(300),
    @fldMatn nvarchar(MAX)
AS 
	 
	
	BEGIN TRAN
	set @fldMatn=dbo.fn_textNormalize(@fldMatn)
	set @fldNameShakhs=dbo.fn_textNormalize(@fldNameShakhs)
	UPDATE [dbo].[tblPayam]
	SET    [fldNameShakhs] = @fldNameShakhs, [fldMobile] = @fldMobile, [fldEmail] = @fldEmail, [fldSubject] = @fldSubject, [fldMatn] = @fldMatn, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
