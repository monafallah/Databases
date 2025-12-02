SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblSavabegheSanavateKHedmatInsert] 
  
    @fldPersonalId int,
    @fldNoeSabeghe bit,
    @fldAzTarikh NVARCHAR(10),
    @fldTaTarikh NVARCHAR(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblSavabegheSanavateKHedmat] 
	INSERT INTO [Prs].[tblSavabegheSanavateKHedmat] ([fldId], [fldPersonalId], [fldNoeSabeghe], [fldAzTarikh], [fldTaTarikh], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldPersonalId, @fldNoeSabeghe, @fldAzTarikh, @fldTaTarikh, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
