SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHokm_ItemInsert] 

    @fldPersonalHokmId int,
    @fldItems_EstekhdamId int,
    @fldMablagh int,
    @fldZarib decimal(6, 3),
    @fldUserId int,

    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblHokm_Item] 
	INSERT INTO [Prs].[tblHokm_Item] ([fldId], [fldPersonalHokmId], [fldItems_EstekhdamId], [fldMablagh], [fldZarib], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldPersonalHokmId, @fldItems_EstekhdamId, @fldMablagh, @fldZarib, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
