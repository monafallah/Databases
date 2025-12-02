SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Com].[spr_tblMaliyatArzesheAfzoodeInsert] 
  
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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [com].[tblMaliyatArzesheAfzoode] 
	INSERT INTO [com].[tblMaliyatArzesheAfzoode] ([fldId], [fldFromDate], [fldEndDate], [fldDarsadeAvarez], [fldDarsadeMaliyat], [fldUserId], [fldDesc], [fldDate],fldDarsadAmuzeshParvaresh)
	SELECT @fldId, @fldFromDate, @fldEndDate, @fldDarsadeAvarez, @fldDarsadeMaliyat, @fldUserId, @fldDesc, getdate(),@fldDarasadAmuzeshParvaresh
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
