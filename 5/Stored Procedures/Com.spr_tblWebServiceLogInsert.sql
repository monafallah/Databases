SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblWebServiceLogInsert] 
    @fldMatn nvarchar(MAX),
    @fldUser nvarchar(50)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblWebServiceLog] 
	INSERT INTO [Com].[tblWebServiceLog] ([fldMatn], [fldUser], [flddate])
	SELECT @fldMatn, @fldUser, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
