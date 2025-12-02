SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPardakhtFishSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT TOP (@h) fldId, fldFishId, fldDatePardakht, fldNahvePardakhtId, fldTarikh, fldUserId, fldDesc, fldDate, fldPardakhtFiles_DetailId
	,fldDateVariz,fldTarikhVariz
FROM     Drd.tblPardakhtFish 
	WHERE  fldId = @Value

	if (@fieldname=N'fldFishId')
	SELECT TOP (@h) fldId, fldFishId, fldDatePardakht, fldNahvePardakhtId, fldTarikh, fldUserId, fldDesc, fldDate, fldPardakhtFiles_DetailId
	,fldDateVariz,fldTarikhVariz
FROM     Drd.tblPardakhtFish 
	WHERE  fldFishId = @Value

	if (@fieldname=N'fldNahvePardakhtId')
	SELECT TOP (@h) fldId, fldFishId, fldDatePardakht, fldNahvePardakhtId, fldTarikh, fldUserId, fldDesc, fldDate, fldPardakhtFiles_DetailId
	,fldDateVariz,fldTarikhVariz
FROM     Drd.tblPardakhtFish 
	WHERE  fldNahvePardakhtId = @Value

	if (@fieldname=N'fldDesc')
	SELECT TOP (@h) fldId, fldFishId, fldDatePardakht, fldNahvePardakhtId, fldTarikh, fldUserId, fldDesc, fldDate, fldPardakhtFiles_DetailId
	,fldDateVariz,fldTarikhVariz
FROM     Drd.tblPardakhtFish 
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT TOP (@h) fldId, fldFishId, fldDatePardakht, fldNahvePardakhtId, fldTarikh, fldUserId, fldDesc, fldDate, fldPardakhtFiles_DetailId
	,fldDateVariz,fldTarikhVariz
FROM     Drd.tblPardakhtFish 

	COMMIT
GO
