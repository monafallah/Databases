SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblPayamInsert] 
   
    @fldNameShakhs nvarchar(300),
    @fldMobile varchar(11),
    @fldEmail nvarchar(100),
    @fldSubject nvarchar(300),
    @fldMatn nvarchar(MAX)
AS 
	 
	
	BEGIN TRAN
declare @fldid int
set @fldMatn=dbo.fn_textNormalize(@fldMatn)
set @fldNameShakhs=dbo.fn_textNormalize(@fldNameShakhs)
	select @fldid=isnull(max(fldId),0)+1  FROM   [dbo].[tblPayam] 
	INSERT INTO [dbo].[tblPayam] ([fldId], [fldNameShakhs], [fldMobile], [fldEmail], [fldSubject], [fldMatn], [fldDate])
	SELECT @fldId, @fldNameShakhs, @fldMobile, @fldEmail, @fldSubject, @fldMatn,  getdate()
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
