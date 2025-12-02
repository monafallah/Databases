SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblShomareHesabOmoomi_DetailInsert] 
  
    @fldShomareHesabId int,
    @fldTypeHesab bit,
	@fldShomareKart nvarchar(50),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldHesabTypeId int
 
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblShomareHesabOmoomi_Detail] 
	INSERT INTO [Com].[tblShomareHesabOmoomi_Detail] ([fldId], [fldShomareHesabId], [fldTypeHesab],[fldShomareKart], [fldUserId], [fldDesc], [fldDate],fldHesabTypeId)
	SELECT @fldId, @fldShomareHesabId, @fldTypeHesab,@fldShomareKart, @fldUserId, @fldDesc, getdate(),@fldHesabTypeId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
