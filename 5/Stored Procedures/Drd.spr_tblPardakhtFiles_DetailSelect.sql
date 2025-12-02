SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPardakhtFiles_DetailSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId NVARCHAR(50),
	@AzTarikh NVARCHAR(50),
	@TaTarikh NVARCHAR(50),
	@h int
AS 
	BEGIN TRAN
	--if (@h=0) set @h=2147483647
	--set  @Value=com.fn_TextNormalize(@Value)
	--DECLARE @organ TABLE (id int)
	--;WITH organ as	(
	--SELECT    fldId    
	--FROM            Com.tblOrganization
	--WHERE fldId=@OrganId
	--UNION ALL
	--SELECT t.fldId FROM Com.tblOrganization AS t
	--INNER JOIN organ ON t.fldPId=organ.fldId
	-- )
	-- INSERT INTO @organ 
	--		 ( id )
	-- SELECT organ.fldId FROM organ

	 IF(@fieldName='fldOrganId')
		SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE fldOrganId LIKE @Value
	order by fldTarikhPardakht DESC
    
		 IF(@fieldName='fldNahvePardakhtId')
		SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE fldNahvePardakhtId LIKE @Value

			 IF(@fieldName='fldShenaseGhabz_Check')
		SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE fldShenaseGhabz LIKE @Value

	 IF(@fieldName='fldShenasePardakht_Check')
		SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE fldShenasePardakht LIKE @Value
IF(@fieldName='')
BEGIN
	IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE fldOrganId=@OrganId AND fldTarikhPardakht>=@AzTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh ='' AND @TaTarikh<>'')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE fldOrganId=@OrganId AND fldTarikhPardakht<=@TaTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh <>'' AND @TaTarikh<>'')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE fldOrganId=@OrganId AND fldTarikhPardakht BETWEEN @AzTarikh AND @TaTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh ='' AND @TaTarikh='')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE fldOrganId=@OrganId
	order by fldTarikhPardakht desc
END 
	
	if (@fieldname=N'fldId')
	BEGIN
	IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE Drd.tblPardakhtFiles_Detail.fldId LIKE @Value and fldOrganId=@OrganId AND fldTarikhPardakht>=@AzTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh ='' AND @TaTarikh<>'')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE Drd.tblPardakhtFiles_Detail.fldId LIKE @Value and  fldOrganId=@OrganId AND fldTarikhPardakht<=@TaTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh <>'' AND @TaTarikh<>'')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE Drd.tblPardakhtFiles_Detail.fldId LIKE @Value and  fldOrganId=@OrganId AND fldTarikhPardakht BETWEEN @AzTarikh AND @TaTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh ='' AND @TaTarikh='')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE Drd.tblPardakhtFiles_Detail.fldId LIKE @Value and  fldOrganId=@OrganId
	order by fldTarikhPardakht desc
END
if (@fieldname=N'fldShenaseGhabz')
	BEGIN
	IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE Drd.tblPardakhtFiles_Detail.fldShenaseGhabz LIKE @Value and fldOrganId=@OrganId AND fldTarikhPardakht>=@AzTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh ='' AND @TaTarikh<>'')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE Drd.tblPardakhtFiles_Detail.fldShenaseGhabz LIKE @Value and  fldOrganId=@OrganId AND fldTarikhPardakht<=@TaTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh <>'' AND @TaTarikh<>'')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE Drd.tblPardakhtFiles_Detail.fldShenaseGhabz LIKE @Value and  fldOrganId=@OrganId AND fldTarikhPardakht BETWEEN @AzTarikh AND @TaTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh ='' AND @TaTarikh='')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE Drd.tblPardakhtFiles_Detail.fldShenaseGhabz LIKE @Value and  fldOrganId=@OrganId 
	order by fldTarikhPardakht desc
END
if (@fieldname=N'fldShenasePardakht')
	BEGIN
	IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE Drd.tblPardakhtFiles_Detail.fldShenasePardakht LIKE @Value and fldOrganId=@OrganId AND fldTarikhPardakht>=@AzTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh ='' AND @TaTarikh<>'')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE Drd.tblPardakhtFiles_Detail.fldShenasePardakht LIKE @Value and  fldOrganId=@OrganId AND fldTarikhPardakht<=@TaTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh <>'' AND @TaTarikh<>'')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE Drd.tblPardakhtFiles_Detail.fldShenasePardakht LIKE @Value and  fldOrganId=@OrganId AND fldTarikhPardakht BETWEEN @AzTarikh AND @TaTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh ='' AND @TaTarikh='')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE Drd.tblPardakhtFiles_Detail.fldShenasePardakht LIKE @Value and  fldOrganId=@OrganId
	order by fldTarikhPardakht desc
END
if (@fieldname=N'fldFishId')
	BEGIN
	IF(@AzTarikh <>'' AND @TaTarikh='')
	SELECT  TOP (@h) * FROM (	SELECT        Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId) AS t
							 WHERE t.fldFishId LIKE @Value and fldOrganId=@OrganId AND fldTarikhPardakht>=@AzTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh ='' AND @TaTarikh<>'')
	SELECT TOP (@h) * FROM (	SELECT         Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId) AS t
							 WHERE t.fldFishId LIKE @Value and fldOrganId=@OrganId AND fldTarikhPardakht<=@TaTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh <>'' AND @TaTarikh<>'')
	SELECT  TOP (@h) * FROM (	SELECT    Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId) AS t
							 WHERE t.fldFishId LIKE @Value and fldOrganId=@OrganId AND fldTarikhPardakht BETWEEN @AzTarikh AND @TaTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh ='' AND @TaTarikh='')
	SELECT  TOP (@h) * FROM (	SELECT        Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId) AS t
							 WHERE t.fldFishId LIKE @Value and  fldOrganId=@OrganId
	order by fldTarikhPardakht desc
END
if (@fieldname=N'fldTitleNahvePardakht')
	BEGIN
	IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT    TOP (@h) * FROM (	SELECT      Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId) AS t
							 WHERE t.fldTitleNahvePardakht LIKE @Value and fldOrganId=@OrganId AND fldTarikhPardakht>=@AzTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh ='' AND @TaTarikh<>'')
	SELECT  TOP (@h) * FROM (	SELECT        Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId) AS t
							 WHERE t.fldTitleNahvePardakht LIKE @Value and fldOrganId=@OrganId AND fldTarikhPardakht<=@TaTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh <>'' AND @TaTarikh<>'')
	SELECT     TOP (@h) * FROM (	SELECT     Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId) AS t
							 WHERE t.fldTitleNahvePardakht LIKE @Value and fldOrganId=@OrganId AND fldTarikhPardakht BETWEEN @AzTarikh AND @TaTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh ='' AND @TaTarikh='')
	SELECT   TOP (@h) * FROM (	SELECT       Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId) AS t
							 WHERE t.fldTitleNahvePardakht LIKE @Value and  fldOrganId=@OrganId 
	order by fldTarikhPardakht desc
END
if (@fieldname=N'fldBankName')
	BEGIN
	IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE fldBankName LIKE @Value and fldOrganId=@OrganId AND fldTarikhPardakht>=@AzTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh ='' AND @TaTarikh<>'')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE fldBankName LIKE @Value and  fldOrganId=@OrganId AND fldTarikhPardakht<=@TaTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh <>'' AND @TaTarikh<>'')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE fldBankName LIKE @Value and  fldOrganId=@OrganId AND fldTarikhPardakht BETWEEN @AzTarikh AND @TaTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh ='' AND @TaTarikh='')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE fldBankName LIKE @Value and  fldOrganId=@OrganId
	order by fldTarikhPardakht desc
END

if (@fieldname=N'fldCodeRahgiry')
	BEGIN
	IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE fldCodeRahgiry LIKE @Value and fldOrganId=@OrganId AND fldTarikhPardakht>=@AzTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh ='' AND @TaTarikh<>'')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE fldCodeRahgiry LIKE @Value and  fldOrganId=@OrganId AND fldTarikhPardakht<=@TaTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh <>'' AND @TaTarikh<>'')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE fldCodeRahgiry LIKE @Value and  fldOrganId=@OrganId AND fldTarikhPardakht BETWEEN @AzTarikh AND @TaTarikh
	order by fldTarikhPardakht desc
	IF(@AzTarikh ='' AND @TaTarikh='')
	SELECT        TOP (@h) Drd.tblPardakhtFiles_Detail.fldId, Drd.tblPardakhtFiles_Detail.fldShenaseGhabz, Drd.tblPardakhtFiles_Detail.fldShenasePardakht, Drd.tblPardakhtFiles_Detail.fldTarikhPardakht, 
							 Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId, Drd.tblPardakhtFiles_Detail.fldPardakhtFileId, Drd.tblPardakhtFiles_Detail.fldOrganId, 
							 Drd.tblPardakhtFiles_Detail.fldUserId, Drd.tblPardakhtFiles_Detail.fldDesc, Drd.tblPardakhtFiles_Detail.fldDate, Drd.tblPardakhtFile.fldBankId, Drd.tblPardakhtFile.fldFileName, Drd.tblPardakhtFile.fldDateSendFile, 
							 Com.tblBank.fldBankName, Drd.tblNahvePardakht.fldTitle AS fldTitleNahvePardakht,
							 ISNULL((SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldPardakhtFiles_DetailId=Drd.tblPardakhtFiles_Detail.fldId),0) AS fldFishId
	FROM            Drd.tblPardakhtFiles_Detail INNER JOIN
							 Drd.tblPardakhtFile ON Drd.tblPardakhtFiles_Detail.fldOrganId = Drd.tblPardakhtFile.fldId INNER JOIN
							 Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
							 Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
							 WHERE fldCodeRahgiry LIKE @Value and  fldOrganId=@OrganId
	order by fldTarikhPardakht desc
END
	COMMIT
GO
