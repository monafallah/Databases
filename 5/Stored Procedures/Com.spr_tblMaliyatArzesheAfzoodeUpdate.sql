SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblMaliyatArzesheAfzoodeUpdate] 
    @fldId int,
    @fldFromDate nvarchar(10),
    @fldEndDate nvarchar(10),
    @fldDarsadeAvarez decimal(5, 2),
    @fldDarsadeMaliyat decimal(5, 2),
	@fldDarasadAmuzeshParvaresh decimal(5,2),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
    
AS 
	BEGIN TRAN
	set @fldFromDate=com.fn_TextNormalize(@fldFromDate)
	set @fldEndDate=com.fn_TextNormalize(@fldEndDate)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [com].[tblMaliyatArzesheAfzoode]
	SET    [fldFromDate] = @fldFromDate, [fldEndDate] = @fldEndDate, [fldDarsadeAvarez] = @fldDarsadeAvarez, [fldDarsadeMaliyat] = @fldDarsadeMaliyat, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	,fldDarsadAmuzeshParvaresh=@fldDarasadAmuzeshParvaresh
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
