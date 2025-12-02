SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblVamInsert] 
 
    @fldPersonalId int,
    @fldTarikhDaryaft nvarchar(10),
    @fldTypeVam tinyint,
    @fldMablaghVam int,
    @fldStartDate nvarchar(10),
    @fldCount smallint,
    @fldMablagh int,
    @fldMandeVam int,
    @fldStatus bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblVam] 
	INSERT INTO [Pay].[tblVam] ([fldId], [fldPersonalId], [fldTarikhDaryaft], [fldTypeVam], [fldMablaghVam], [fldStartDate], [fldCount], [fldMablagh], [fldMandeVam], [fldStatus], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldPersonalId, @fldTarikhDaryaft, @fldTypeVam, @fldMablaghVam, @fldStartDate, @fldCount, @fldMablagh, @fldMandeVam, @fldStatus, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
