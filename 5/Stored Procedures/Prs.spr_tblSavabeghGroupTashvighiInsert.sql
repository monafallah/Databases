SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblSavabeghGroupTashvighiInsert] 

    @fldPersonalId int,
    @fldAnvaGroupId tinyint,
    @fldTedadGroup tinyint,
    @fldTarikh char(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblSavabeghGroupTashvighi] 
	INSERT INTO [Prs].[tblSavabeghGroupTashvighi] ([fldId], [fldPersonalId], [fldAnvaGroupId], [fldTedadGroup], [fldTarikh], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldPersonalId, @fldAnvaGroupId, @fldTedadGroup, @fldTarikh, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
