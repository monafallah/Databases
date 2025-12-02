SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblSettingSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@organId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
		SET @Value=Com.fn_TextNormalize(@value)
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Pay.tblSetting.fldId, Pay.tblSetting.fldH_BankFixId, Pay.tblSetting.fldH_NameShobe, Pay.tblSetting.fldH_CodeOrgan, Pay.tblSetting.fldH_CodeShobe, 
                      Pay.tblSetting.fldShowBankLogo, Pay.tblSetting.fldOrganId, Pay.tblSetting.fldCodeEghtesadi, Pay.tblSetting.fldPrs_PersonalId, Pay.tblSetting.fldCodeParvande, 
                      Pay.tblSetting.fldCodeOrganPasAndaz, Pay.tblSetting.fldSh_HesabCheckId, Pay.tblSetting.fldB_BankFixId, Pay.tblSetting.fldB_NameShobe, 
                      Pay.tblSetting.fldB_ShomareHesabId, Pay.tblSetting.fldB_CodeShenasaee, Pay.tblSetting.fldUserId, Pay.tblSetting.fldDesc, Pay.tblSetting.fldDate, 
                      Com.tblBank.fldBankName AS NameBankHoghoogh, tblBank_1.fldBankName, tblEmployee.fldName, tblEmployee.fldFamily, 
                      tblOrganizationalPosts.fldTitle AS fldPostOrganName, Pay.tblSetting.fldCodeDastgah, tblEmployee.fldCodemeli, tblFile.fldImage,
                      tblShomareHesabeOmoomi.fldShomareHesab AS fldB_ShomareHesab ,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldSh_HesabCheck
					  ,b.fldBankName as fldP_BankFixName , s.fldName as fldP_NameShobe,s.fldId as fldP_ShobeFixId ,Pay.tblSetting.fldP_BankFixId
					  ,tblSetting.fldStatusMahalKedmatId,sm.fldTitle as  fldStatusMahalKedmatName
FROM         Com.tblOrganization AS tblOrganization INNER JOIN
                      Pay.tblSetting INNER JOIN
                      Com.tblBank ON Pay.tblSetting.fldH_BankFixId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON Pay.tblSetting.fldB_BankFixId = tblBank_1.fldId ON tblOrganization.fldId = Pay.tblSetting.fldOrganId INNER JOIN
                      Com.tblFile AS tblFile ON Com.tblBank.fldFileId = tblFile.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblSetting.fldB_ShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Pay.tblSetting.fldSh_HesabCheckId = tblShomareHesabeOmoomi_1.fldId LEFT OUTER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Prs.Prs_tblPersonalInfo ON tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId INNER JOIN
                      Com.tblOrganizationalPostsEjraee AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = tblOrganizationalPosts.fldId ON 
                      Pay.tblSetting.fldPrs_PersonalId = Prs.Prs_tblPersonalInfo.fldId left join
					  Com.tblBank as b ON Pay.tblSetting.fldP_BankFixId = b.fldId left join
					  com.tblSHobe as s on s.fldid=tblSetting.fldP_ShobeId inner join
					  pay.tblStatusMahalKhedmat as sm on sm.fldId=tblSetting.fldStatusMahalKedmatId
	WHERE  Pay.tblSetting.fldId = @Value
	
	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Pay.tblSetting.fldId, Pay.tblSetting.fldH_BankFixId, Pay.tblSetting.fldH_NameShobe, Pay.tblSetting.fldH_CodeOrgan, Pay.tblSetting.fldH_CodeShobe, 
                      Pay.tblSetting.fldShowBankLogo, Pay.tblSetting.fldOrganId, Pay.tblSetting.fldCodeEghtesadi, Pay.tblSetting.fldPrs_PersonalId, Pay.tblSetting.fldCodeParvande, 
                      Pay.tblSetting.fldCodeOrganPasAndaz, Pay.tblSetting.fldSh_HesabCheckId, Pay.tblSetting.fldB_BankFixId, Pay.tblSetting.fldB_NameShobe, 
                      Pay.tblSetting.fldB_ShomareHesabId, Pay.tblSetting.fldB_CodeShenasaee, Pay.tblSetting.fldUserId, Pay.tblSetting.fldDesc, Pay.tblSetting.fldDate, 
                      Com.tblBank.fldBankName AS NameBankHoghoogh, tblBank_1.fldBankName, tblEmployee.fldName, tblEmployee.fldFamily, 
                      tblOrganizationalPosts.fldTitle AS fldPostOrganName, Pay.tblSetting.fldCodeDastgah, tblEmployee.fldCodemeli, tblFile.fldImage,
                      tblShomareHesabeOmoomi.fldShomareHesab AS fldB_ShomareHesab ,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldSh_HesabCheck
					  ,b.fldBankName as fldP_BankFixName , s.fldName as fldP_NameShobe,s.fldId as fldP_ShobeFixId ,Pay.tblSetting.fldP_BankFixId
					  ,tblSetting.fldStatusMahalKedmatId,sm.fldTitle as  fldStatusMahalKedmatName
FROM         Com.tblOrganization AS tblOrganization INNER JOIN
                      Pay.tblSetting INNER JOIN
                      Com.tblBank ON Pay.tblSetting.fldH_BankFixId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON Pay.tblSetting.fldB_BankFixId = tblBank_1.fldId ON tblOrganization.fldId = Pay.tblSetting.fldOrganId INNER JOIN
                      Com.tblFile AS tblFile ON Com.tblBank.fldFileId = tblFile.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblSetting.fldB_ShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Pay.tblSetting.fldSh_HesabCheckId = tblShomareHesabeOmoomi_1.fldId LEFT OUTER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Prs.Prs_tblPersonalInfo ON tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId INNER JOIN
                      Com.tblOrganizationalPostsEjraee AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = tblOrganizationalPosts.fldId ON 
                      Pay.tblSetting.fldPrs_PersonalId = Prs.Prs_tblPersonalInfo.fldId left join
					  Com.tblBank as b ON Pay.tblSetting.fldP_BankFixId = b.fldId left join
					  com.tblSHobe as s on s.fldid=tblSetting.fldP_ShobeId inner join
					  pay.tblStatusMahalKhedmat as sm on sm.fldId=tblSetting.fldStatusMahalKedmatId
	WHERE  Pay.tblSetting.fldDesc LIKE @Value
	

		if (@fieldname=N'fldOrganId')
SELECT     TOP (@h) Pay.tblSetting.fldId, Pay.tblSetting.fldH_BankFixId, Pay.tblSetting.fldH_NameShobe, Pay.tblSetting.fldH_CodeOrgan, Pay.tblSetting.fldH_CodeShobe, 
                      Pay.tblSetting.fldShowBankLogo, Pay.tblSetting.fldOrganId, Pay.tblSetting.fldCodeEghtesadi, Pay.tblSetting.fldPrs_PersonalId, Pay.tblSetting.fldCodeParvande, 
                      Pay.tblSetting.fldCodeOrganPasAndaz, Pay.tblSetting.fldSh_HesabCheckId, Pay.tblSetting.fldB_BankFixId, Pay.tblSetting.fldB_NameShobe, 
                      Pay.tblSetting.fldB_ShomareHesabId, Pay.tblSetting.fldB_CodeShenasaee, Pay.tblSetting.fldUserId, Pay.tblSetting.fldDesc, Pay.tblSetting.fldDate, 
                      Com.tblBank.fldBankName AS NameBankHoghoogh, tblBank_1.fldBankName, tblEmployee.fldName, tblEmployee.fldFamily, 
                      tblOrganizationalPosts.fldTitle AS fldPostOrganName, Pay.tblSetting.fldCodeDastgah, tblEmployee.fldCodemeli, tblFile.fldImage,
                      tblShomareHesabeOmoomi.fldShomareHesab AS fldB_ShomareHesab ,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldSh_HesabCheck
					  ,b.fldBankName as fldP_BankFixName , s.fldName as fldP_NameShobe,s.fldId as fldP_ShobeFixId ,Pay.tblSetting.fldP_BankFixId
					  ,tblSetting.fldStatusMahalKedmatId,sm.fldTitle as  fldStatusMahalKedmatName
FROM         Com.tblOrganization AS tblOrganization INNER JOIN
                      Pay.tblSetting INNER JOIN
                      Com.tblBank ON Pay.tblSetting.fldH_BankFixId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON Pay.tblSetting.fldB_BankFixId = tblBank_1.fldId ON tblOrganization.fldId = Pay.tblSetting.fldOrganId INNER JOIN
                      Com.tblFile AS tblFile ON Com.tblBank.fldFileId = tblFile.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblSetting.fldB_ShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Pay.tblSetting.fldSh_HesabCheckId = tblShomareHesabeOmoomi_1.fldId LEFT OUTER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Prs.Prs_tblPersonalInfo ON tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId INNER JOIN
                      Com.tblOrganizationalPostsEjraee AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = tblOrganizationalPosts.fldId ON 
                      Pay.tblSetting.fldPrs_PersonalId = Prs.Prs_tblPersonalInfo.fldId left join
					  Com.tblBank as b ON Pay.tblSetting.fldP_BankFixId = b.fldId left join
					  com.tblSHobe as s on s.fldid=tblSetting.fldP_ShobeId inner join
					  pay.tblStatusMahalKhedmat as sm on sm.fldId=tblSetting.fldStatusMahalKedmatId
                      	WHERE  Pay.tblSetting.fldOrganId=@Value
	
			if (@fieldname=N'fldH_BankFixId')
SELECT     TOP (@h) Pay.tblSetting.fldId, Pay.tblSetting.fldH_BankFixId, Pay.tblSetting.fldH_NameShobe, Pay.tblSetting.fldH_CodeOrgan, Pay.tblSetting.fldH_CodeShobe, 
                      Pay.tblSetting.fldShowBankLogo, Pay.tblSetting.fldOrganId, Pay.tblSetting.fldCodeEghtesadi, Pay.tblSetting.fldPrs_PersonalId, Pay.tblSetting.fldCodeParvande, 
                      Pay.tblSetting.fldCodeOrganPasAndaz, Pay.tblSetting.fldSh_HesabCheckId, Pay.tblSetting.fldB_BankFixId, Pay.tblSetting.fldB_NameShobe, 
                      Pay.tblSetting.fldB_ShomareHesabId, Pay.tblSetting.fldB_CodeShenasaee, Pay.tblSetting.fldUserId, Pay.tblSetting.fldDesc, Pay.tblSetting.fldDate, 
                      Com.tblBank.fldBankName AS NameBankHoghoogh, tblBank_1.fldBankName, tblEmployee.fldName, tblEmployee.fldFamily, 
                      tblOrganizationalPosts.fldTitle AS fldPostOrganName, Pay.tblSetting.fldCodeDastgah, tblEmployee.fldCodemeli, tblFile.fldImage,
                      tblShomareHesabeOmoomi.fldShomareHesab AS fldB_ShomareHesab ,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldSh_HesabCheck
					  ,b.fldBankName as fldP_BankFixName , s.fldName as fldP_NameShobe,s.fldId as fldP_ShobeFixId ,Pay.tblSetting.fldP_BankFixId
					  ,tblSetting.fldStatusMahalKedmatId,sm.fldTitle as  fldStatusMahalKedmatName
FROM         Com.tblOrganization AS tblOrganization INNER JOIN
                      Pay.tblSetting INNER JOIN
                      Com.tblBank ON Pay.tblSetting.fldH_BankFixId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON Pay.tblSetting.fldB_BankFixId = tblBank_1.fldId ON tblOrganization.fldId = Pay.tblSetting.fldOrganId INNER JOIN
                      Com.tblFile AS tblFile ON Com.tblBank.fldFileId = tblFile.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblSetting.fldB_ShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Pay.tblSetting.fldSh_HesabCheckId = tblShomareHesabeOmoomi_1.fldId LEFT OUTER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Prs.Prs_tblPersonalInfo ON tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId INNER JOIN
                      Com.tblOrganizationalPostsEjraee AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = tblOrganizationalPosts.fldId ON 
                      Pay.tblSetting.fldPrs_PersonalId = Prs.Prs_tblPersonalInfo.fldId left join
					  Com.tblBank as b ON Pay.tblSetting.fldP_BankFixId = b.fldId left join
					  com.tblSHobe as s on s.fldid=tblSetting.fldP_ShobeId inner join
					  pay.tblStatusMahalKhedmat as sm on sm.fldId=tblSetting.fldStatusMahalKedmatId
	WHERE  Pay.tblSetting.fldH_BankFixId=@Value AND fldOrganId=@organId
	
	
			if (@fieldname=N'fldB_BankFixId')
SELECT     TOP (@h) Pay.tblSetting.fldId, Pay.tblSetting.fldH_BankFixId, Pay.tblSetting.fldH_NameShobe, Pay.tblSetting.fldH_CodeOrgan, Pay.tblSetting.fldH_CodeShobe, 
                      Pay.tblSetting.fldShowBankLogo, Pay.tblSetting.fldOrganId, Pay.tblSetting.fldCodeEghtesadi, Pay.tblSetting.fldPrs_PersonalId, Pay.tblSetting.fldCodeParvande, 
                      Pay.tblSetting.fldCodeOrganPasAndaz, Pay.tblSetting.fldSh_HesabCheckId, Pay.tblSetting.fldB_BankFixId, Pay.tblSetting.fldB_NameShobe, 
                      Pay.tblSetting.fldB_ShomareHesabId, Pay.tblSetting.fldB_CodeShenasaee, Pay.tblSetting.fldUserId, Pay.tblSetting.fldDesc, Pay.tblSetting.fldDate, 
                      Com.tblBank.fldBankName AS NameBankHoghoogh, tblBank_1.fldBankName, tblEmployee.fldName, tblEmployee.fldFamily, 
                      tblOrganizationalPosts.fldTitle AS fldPostOrganName, Pay.tblSetting.fldCodeDastgah, tblEmployee.fldCodemeli, tblFile.fldImage,
                      tblShomareHesabeOmoomi.fldShomareHesab AS fldB_ShomareHesab ,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldSh_HesabCheck
					  ,b.fldBankName as fldP_BankFixName , s.fldName as fldP_NameShobe,s.fldId as fldP_ShobeFixId ,Pay.tblSetting.fldP_BankFixId
					  ,tblSetting.fldStatusMahalKedmatId,sm.fldTitle as  fldStatusMahalKedmatName
FROM         Com.tblOrganization AS tblOrganization INNER JOIN
                      Pay.tblSetting INNER JOIN
                      Com.tblBank ON Pay.tblSetting.fldH_BankFixId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON Pay.tblSetting.fldB_BankFixId = tblBank_1.fldId ON tblOrganization.fldId = Pay.tblSetting.fldOrganId INNER JOIN
                      Com.tblFile AS tblFile ON Com.tblBank.fldFileId = tblFile.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblSetting.fldB_ShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Pay.tblSetting.fldSh_HesabCheckId = tblShomareHesabeOmoomi_1.fldId LEFT OUTER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Prs.Prs_tblPersonalInfo ON tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId INNER JOIN
                      Com.tblOrganizationalPostsEjraee AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = tblOrganizationalPosts.fldId ON 
                      Pay.tblSetting.fldPrs_PersonalId = Prs.Prs_tblPersonalInfo.fldId left join
					  Com.tblBank as b ON Pay.tblSetting.fldP_BankFixId = b.fldId left join
					  com.tblSHobe as s on s.fldid=tblSetting.fldP_ShobeId inner join
					  pay.tblStatusMahalKhedmat as sm on sm.fldId=tblSetting.fldStatusMahalKedmatId
	WHERE  Pay.tblSetting.fldB_BankFixId=@Value AND fldOrganId=@organId
	
				if (@fieldname=N'fldSh_HesabCheckId')
SELECT     TOP (@h) Pay.tblSetting.fldId, Pay.tblSetting.fldH_BankFixId, Pay.tblSetting.fldH_NameShobe, Pay.tblSetting.fldH_CodeOrgan, Pay.tblSetting.fldH_CodeShobe, 
                      Pay.tblSetting.fldShowBankLogo, Pay.tblSetting.fldOrganId, Pay.tblSetting.fldCodeEghtesadi, Pay.tblSetting.fldPrs_PersonalId, Pay.tblSetting.fldCodeParvande, 
                      Pay.tblSetting.fldCodeOrganPasAndaz, Pay.tblSetting.fldSh_HesabCheckId, Pay.tblSetting.fldB_BankFixId, Pay.tblSetting.fldB_NameShobe, 
                      Pay.tblSetting.fldB_ShomareHesabId, Pay.tblSetting.fldB_CodeShenasaee, Pay.tblSetting.fldUserId, Pay.tblSetting.fldDesc, Pay.tblSetting.fldDate, 
                      Com.tblBank.fldBankName AS NameBankHoghoogh, tblBank_1.fldBankName, tblEmployee.fldName, tblEmployee.fldFamily, 
                      tblOrganizationalPosts.fldTitle AS fldPostOrganName, Pay.tblSetting.fldCodeDastgah, tblEmployee.fldCodemeli, tblFile.fldImage,
                      tblShomareHesabeOmoomi.fldShomareHesab AS fldB_ShomareHesab ,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldSh_HesabCheck
					  ,b.fldBankName as fldP_BankFixName , s.fldName as fldP_NameShobe,s.fldId as fldP_ShobeFixId ,Pay.tblSetting.fldP_BankFixId
					  ,tblSetting.fldStatusMahalKedmatId,sm.fldTitle as  fldStatusMahalKedmatName
FROM         Com.tblOrganization AS tblOrganization INNER JOIN
                      Pay.tblSetting INNER JOIN
                      Com.tblBank ON Pay.tblSetting.fldH_BankFixId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON Pay.tblSetting.fldB_BankFixId = tblBank_1.fldId ON tblOrganization.fldId = Pay.tblSetting.fldOrganId INNER JOIN
                      Com.tblFile AS tblFile ON Com.tblBank.fldFileId = tblFile.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblSetting.fldB_ShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Pay.tblSetting.fldSh_HesabCheckId = tblShomareHesabeOmoomi_1.fldId LEFT OUTER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Prs.Prs_tblPersonalInfo ON tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId INNER JOIN
                      Com.tblOrganizationalPostsEjraee AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = tblOrganizationalPosts.fldId ON 
                      Pay.tblSetting.fldPrs_PersonalId = Prs.Prs_tblPersonalInfo.fldId left join
					  Com.tblBank as b ON Pay.tblSetting.fldP_BankFixId = b.fldId left join
					  com.tblSHobe as s on s.fldid=tblSetting.fldP_ShobeId inner join
					  pay.tblStatusMahalKhedmat as sm on sm.fldId=tblSetting.fldStatusMahalKedmatId
	WHERE  Pay.tblSetting.fldSh_HesabCheckId=@Value AND fldOrganId=@organId
	
	

		if (@fieldname=N'fldB_ShomareHesabId')
SELECT     TOP (@h) Pay.tblSetting.fldId, Pay.tblSetting.fldH_BankFixId, Pay.tblSetting.fldH_NameShobe, Pay.tblSetting.fldH_CodeOrgan, Pay.tblSetting.fldH_CodeShobe, 
                      Pay.tblSetting.fldShowBankLogo, Pay.tblSetting.fldOrganId, Pay.tblSetting.fldCodeEghtesadi, Pay.tblSetting.fldPrs_PersonalId, Pay.tblSetting.fldCodeParvande, 
                      Pay.tblSetting.fldCodeOrganPasAndaz, Pay.tblSetting.fldSh_HesabCheckId, Pay.tblSetting.fldB_BankFixId, Pay.tblSetting.fldB_NameShobe, 
                      Pay.tblSetting.fldB_ShomareHesabId, Pay.tblSetting.fldB_CodeShenasaee, Pay.tblSetting.fldUserId, Pay.tblSetting.fldDesc, Pay.tblSetting.fldDate, 
                      Com.tblBank.fldBankName AS NameBankHoghoogh, tblBank_1.fldBankName, tblEmployee.fldName, tblEmployee.fldFamily, 
                      tblOrganizationalPosts.fldTitle AS fldPostOrganName, Pay.tblSetting.fldCodeDastgah, tblEmployee.fldCodemeli, tblFile.fldImage,
                      tblShomareHesabeOmoomi.fldShomareHesab AS fldB_ShomareHesab ,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldSh_HesabCheck
					  ,b.fldBankName as fldP_BankFixName , s.fldName as fldP_NameShobe,s.fldId as fldP_ShobeFixId ,Pay.tblSetting.fldP_BankFixId
					  ,tblSetting.fldStatusMahalKedmatId,sm.fldTitle as  fldStatusMahalKedmatName
FROM         Com.tblOrganization AS tblOrganization INNER JOIN
                      Pay.tblSetting INNER JOIN
                      Com.tblBank ON Pay.tblSetting.fldH_BankFixId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON Pay.tblSetting.fldB_BankFixId = tblBank_1.fldId ON tblOrganization.fldId = Pay.tblSetting.fldOrganId INNER JOIN
                      Com.tblFile AS tblFile ON Com.tblBank.fldFileId = tblFile.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblSetting.fldB_ShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Pay.tblSetting.fldSh_HesabCheckId = tblShomareHesabeOmoomi_1.fldId LEFT OUTER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Prs.Prs_tblPersonalInfo ON tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId INNER JOIN
                      Com.tblOrganizationalPostsEjraee AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = tblOrganizationalPosts.fldId ON 
                      Pay.tblSetting.fldPrs_PersonalId = Prs.Prs_tblPersonalInfo.fldId left join
					  Com.tblBank as b ON Pay.tblSetting.fldP_BankFixId = b.fldId left join
					  com.tblSHobe as s on s.fldid=tblSetting.fldP_ShobeId inner join
					  pay.tblStatusMahalKhedmat as sm on sm.fldId=tblSetting.fldStatusMahalKedmatId
	WHERE  fldB_ShomareHesabId = @Value AND fldOrganId=@organId



	if (@fieldname=N'')
SELECT     TOP (@h) Pay.tblSetting.fldId, Pay.tblSetting.fldH_BankFixId, Pay.tblSetting.fldH_NameShobe, Pay.tblSetting.fldH_CodeOrgan, Pay.tblSetting.fldH_CodeShobe, 
                      Pay.tblSetting.fldShowBankLogo, Pay.tblSetting.fldOrganId, Pay.tblSetting.fldCodeEghtesadi, Pay.tblSetting.fldPrs_PersonalId, Pay.tblSetting.fldCodeParvande, 
                      Pay.tblSetting.fldCodeOrganPasAndaz, Pay.tblSetting.fldSh_HesabCheckId, Pay.tblSetting.fldB_BankFixId, Pay.tblSetting.fldB_NameShobe, 
                      Pay.tblSetting.fldB_ShomareHesabId, Pay.tblSetting.fldB_CodeShenasaee, Pay.tblSetting.fldUserId, Pay.tblSetting.fldDesc, Pay.tblSetting.fldDate, 
                      Com.tblBank.fldBankName AS NameBankHoghoogh, tblBank_1.fldBankName, tblEmployee.fldName, tblEmployee.fldFamily, 
                      tblOrganizationalPosts.fldTitle AS fldPostOrganName, Pay.tblSetting.fldCodeDastgah, tblEmployee.fldCodemeli, tblFile.fldImage,
                      tblShomareHesabeOmoomi.fldShomareHesab AS fldB_ShomareHesab ,tblShomareHesabeOmoomi_1.fldShomareHesab AS fldSh_HesabCheck
					  ,b.fldBankName as fldP_BankFixName , s.fldName as fldP_NameShobe,s.fldId as fldP_ShobeFixId ,Pay.tblSetting.fldP_BankFixId
					  ,tblSetting.fldStatusMahalKedmatId,sm.fldTitle as  fldStatusMahalKedmatName
FROM         Com.tblOrganization AS tblOrganization INNER JOIN
                      Pay.tblSetting INNER JOIN
                      Com.tblBank ON Pay.tblSetting.fldH_BankFixId = Com.tblBank.fldId INNER JOIN
                      Com.tblBank AS tblBank_1 ON Pay.tblSetting.fldB_BankFixId = tblBank_1.fldId ON tblOrganization.fldId = Pay.tblSetting.fldOrganId INNER JOIN
                      Com.tblFile AS tblFile ON Com.tblBank.fldFileId = tblFile.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblSetting.fldB_ShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Pay.tblSetting.fldSh_HesabCheckId = tblShomareHesabeOmoomi_1.fldId LEFT OUTER JOIN
                      Com.tblEmployee AS tblEmployee INNER JOIN
                      Prs.Prs_tblPersonalInfo ON tblEmployee.fldId = Prs.Prs_tblPersonalInfo.fldEmployeeId INNER JOIN
                      Com.tblOrganizationalPostsEjraee AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = tblOrganizationalPosts.fldId ON 
                      Pay.tblSetting.fldPrs_PersonalId = Prs.Prs_tblPersonalInfo.fldId left join
					  Com.tblBank as b ON Pay.tblSetting.fldP_BankFixId = b.fldId left join
					  com.tblSHobe as s on s.fldid=tblSetting.fldP_ShobeId inner join
					  pay.tblStatusMahalKhedmat as sm on sm.fldId=tblSetting.fldStatusMahalKedmatId
                     
                    
	COMMIT
GO
