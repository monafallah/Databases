SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblShomareHesabOmoomi_DetailUpdate] 
    @fldId int,
    @fldShomareHesabId int,
    @fldTypeHesab bit,
	@fldShomareKart nvarchar(50),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
   
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Com].[tblShomareHesabOmoomi_Detail]
	SET    [fldShomareHesabId] = @fldShomareHesabId, [fldTypeHesab] = @fldTypeHesab,[fldShomareKart]=@fldShomareKart, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
