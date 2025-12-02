SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblElamAvarezSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value1 nvarchar(50),
	--@FiscalYearId int,
	@h int
AS 
	BEGIN TRAN
	--DECLARE @organ TABLE (id int)
	--;WITH organ as	(
	--SELECT    fldId    
	--FROM            Com.tblOrganization
	--WHERE fldId=@Value1
	--UNION ALL
	--SELECT t.fldId FROM Com.tblOrganization AS t
	--INNER JOIN organ ON t.fldPId=organ.fldId
	-- )
	-- INSERT INTO @organ 
	--		 ( id )
	-- SELECT organ.fldId FROM organ

	declare @t int,@organid int--,@Year varchar(4)
	if (@h=0) set @h=2147483647
	--set @t=@h 
	--set @organid=@Value1
    --set  @Value=com.fn_TextNormalize(@Value)
	--select @Year=fldYear from acc.tblFiscalYear where fldId=@FiscalYearId

	 if (@fieldname=N'')
	 begin
SELECT TOP (@h) fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate ,Noe,fldNameShakhs,fldShenaseMeli
  ,fldNoeShakhs,fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldOrganId,fldReplyTaghsitId,fldMablaghKoli+fldMablaghTakhfif as fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli/*-fldMablaghTakhfif*/),0) AS fldMablaghGHabelPardakht
,fldStatusFish,fldStatusTakhfif,fldStatusTaghsit,fldStatusKoli,fldNameOrgan,
CASE WHEN fldStatusFish=N'0' then N'فیشی صادر نشده'  WHEN fldStatusFish=N'1' then N'کلیه فیش های صادرشده'  WHEN fldStatusFish=N'2' then N'فیش صادر شده'  WHEN fldStatusFish=N'3' then N'ابطال فیش' WHEN fldStatusFish=N'4' then N'ابطال کلیه فیش ها' end as fldStatusFishName,
CASE WHEN fldStatusTakhfif=N'0' then N'درخواست تخفیف صادر نشده'  WHEN fldStatusTakhfif=N'1' THEN N'موافقت شده' WHEN fldStatusTakhfif=N'2' THEN N'عدم موافقت' WHEN fldStatusTakhfif=N'3' THEN N'ابطال شده' WHEN fldStatusTakhfif=N'4' THEN N'درخواست تخفیف' end as fldStatusTakhfifName ,
CASE WHEN fldStatusTaghsit=N'0' then N'درخواست تقسیط صادرنشده' WHEN fldStatusTaghsit=N'1' then N'موافقت شده' WHEN fldStatusTaghsit=N'2' then N'عدم موافقت' WHEN fldStatusTaghsit=N'3' then N'ابطال شده' WHEN fldStatusTaghsit=N'4' then N'درخواست تقسیط' end as  fldStatusTaghsitName,
CASE WHEN fldStatusKoli='1' THEN N'تسویه نقدی'  WHEN fldStatusKoli='2' THEN N'تسویه تقسیط' ELSE N'تسویه نشده' END AS fldStatusKoliName 
 ,SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,fldmobile
 FROM(SELECT fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM drd.tblCompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS fldShenaseMeli, 
            CASE WHEN (SELECT COUNT(*) FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId HAVING COUNT(fldid)>0)=(SELECT COUNT(fldFishId) FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)HAVING COUNT(fldFishId)>0) THEN N'4'
			WHEN (SELECT TOP(1) fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId ORDER BY fldId desc )  IN (SELECT fldFishId FROM Drd.tblEbtal ) THEN N'3'
			WHEN (SELECT COUNT(*) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(id) FROM ( SELECT MAX(fldId) AS id FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) GROUP BY fldCodeElamAvarezId)t) THEN N'1'
			WHEN EXISTS(SELECT * FROM Drd.tblSodoorFish_Detail WHERE fldCodeElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'2'
			ELSE N'0'END AS fldStatusFish
			,CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'4' 
			ELSE N'0' end AS fldStatusTaghsit,
		     CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'4' ELSE N'0' END
			 AS fldStatusTakhfif,
			/*CASE WHEN ((SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			)OR ((SELECT (SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue)) /(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT SUM(fldMablaghAvarezGerdShode) FROM Drd.tblSodoorFish WHERE fldid IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId)AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId)) ) THEN N'1'
			WHEN (SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			THEN N'2'ELSE '0'END */'0'AS fldStatusKoli,
                     (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN '0' WHEN fldHoghoghiId IS NOT NULL THEN '1' END AS Expr1
                       FROM      Com.tblAshkhas
                       WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNoeShakhs, dbo.Fn_AssembelyMiladiToShamsi(fldDate) fldTarikh,
                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldFather_Sabt, fldOrganId
                      ,isnull((select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
)),0) fldReplyTaghsitId
                      ,isnull((SELECT isnull(SUM(fldTakhfifMaliyatValue+fldSumAsli+fldTakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue),SUM(fldMaliyatValue+fldSumAsli+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,isnull(fldMobile,'')fldMobile
FROM     Drd.tblElamAvarez
outer apply (select d.fldMobile from com.tblAshkhas a
inner join com.tblEmployee_Detail d on d.fldEmployeeId=a.fldHaghighiId
where a.fldid=Drd.tblElamAvarez.fldAshakhasID )m_shaks
--where fldTarikh like @Year+'%'
)t
       where   t.fldOrganId=@Value1
		ORDER BY fldid desc 

		end

	else if (@fieldname=N'fldId_Only')
	begin
SELECT TOP (@h) fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate ,Noe,fldNameShakhs,fldShenaseMeli
  ,fldNoeShakhs,  fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldOrganId,fldReplyTaghsitId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli/*-fldMablaghTakhfif*/),0) AS fldMablaghGHabelPardakht
,fldStatusFish,fldStatusTakhfif,fldStatusTaghsit,fldStatusKoli,fldNameOrgan,
CASE WHEN fldStatusFish=N'0' then N'فیشی صادر نشده'  WHEN fldStatusFish=N'1' then N'کلیه فیش های صادرشده'  WHEN fldStatusFish=N'2' then N'فیش صادر شده'  WHEN fldStatusFish=N'3' then N'ابطال فیش' WHEN fldStatusFish=N'4' then N'ابطال کلیه فیش ها' end as fldStatusFishName,
CASE WHEN fldStatusTakhfif=N'0' then N'درخواست تخفیف صادر نشده'  WHEN fldStatusTakhfif=N'1' THEN N'موافقت شده' WHEN fldStatusTakhfif=N'2' THEN N'عدم موافقت' WHEN fldStatusTakhfif=N'3' THEN N'ابطال شده' WHEN fldStatusTakhfif=N'4' THEN N'درخواست تخفیف' end as fldStatusTakhfifName ,
CASE WHEN fldStatusTaghsit=N'0' then N'درخواست تقسیط صادرنشده' WHEN fldStatusTaghsit=N'1' then N'موافقت شده' WHEN fldStatusTaghsit=N'2' then N'عدم موافقت' WHEN fldStatusTaghsit=N'3' then N'ابطال شده' WHEN fldStatusTaghsit=N'4' then N'درخواست تقسیط' end as  fldStatusTaghsitName,
CASE WHEN fldStatusKoli='1' THEN N'تسویه نقدی'  WHEN fldStatusKoli='2' THEN N'تسویه تقسیط' ELSE N'تسویه نشده' END AS fldStatusKoliName 
 ,SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,fldmobile
 FROM(SELECT fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate,  CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM tblcompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS fldShenaseMeli, 
            CASE WHEN (SELECT COUNT(*) FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId HAVING COUNT(fldid)>0)=(SELECT COUNT(fldFishId) FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)HAVING COUNT(fldFishId)>0) THEN N'4'
			WHEN (SELECT TOP(1) fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId ORDER BY fldId desc )  IN (SELECT fldFishId FROM Drd.tblEbtal ) THEN N'3'
			WHEN (SELECT COUNT(*) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(id) FROM ( SELECT MAX(fldId) AS id FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) GROUP BY fldCodeElamAvarezId)t) THEN N'1'
			WHEN EXISTS(SELECT * FROM Drd.tblSodoorFish_Detail WHERE fldCodeElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'2'
			ELSE N'0'END AS fldStatusFish
			,CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'4' 
			ELSE N'0' end AS fldStatusTaghsit,
		     CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'4' ELSE N'0' END
			 AS fldStatusTakhfif,
			CASE WHEN ((SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			)OR ((SELECT (SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue)) /(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT SUM(fldMablaghAvarezGerdShode) FROM Drd.tblSodoorFish WHERE fldid IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId)AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId)) ) THEN N'1'
			WHEN (SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			THEN N'2'ELSE '0'END AS fldStatusKoli,
                     (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN '0' WHEN fldHoghoghiId IS NOT NULL THEN '1' END AS Expr1
                       FROM      Com.tblAshkhas
                       WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNoeShakhs, dbo.Fn_AssembelyMiladiToShamsi(flddate)fldTarikh ,
                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldFather_Sabt, fldOrganId
                       ,isnull((select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
)),0) fldReplyTaghsitId
                      ,isnull((SELECT isnull(SUM(fldTakhfifMaliyatValue+fldSumAsli+fldTakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue),SUM(fldMaliyatValue+fldSumAsli+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,isnull(fldMobile,'')fldMobile
FROM     Drd.tblElamAvarez
outer apply (select d.fldMobile from com.tblAshkhas a
inner join com.tblEmployee_Detail d on d.fldEmployeeId=a.fldHaghighiId
where a.fldid=Drd.tblElamAvarez.fldAshakhasID )m_shaks
 where tblElamAvarez.fldId = @Value
)t
	WHERE  t.fldOrganId=@Value1
	ORDER BY fldid DESC
	
		
	end

	else if (@fieldname=N'fldId')
	begin
SELECT TOP (@h) fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate ,Noe,fldNameShakhs,fldShenaseMeli
  ,fldNoeShakhs,  fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldOrganId,fldReplyTaghsitId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli/*-fldMablaghTakhfif*/),0) AS fldMablaghGHabelPardakht
,fldStatusFish,fldStatusTakhfif,fldStatusTaghsit,fldStatusKoli,fldNameOrgan,
CASE WHEN fldStatusFish=N'0' then N'فیشی صادر نشده'  WHEN fldStatusFish=N'1' then N'کلیه فیش های صادرشده'  WHEN fldStatusFish=N'2' then N'فیش صادر شده'  WHEN fldStatusFish=N'3' then N'ابطال فیش' WHEN fldStatusFish=N'4' then N'ابطال کلیه فیش ها' end as fldStatusFishName,
CASE WHEN fldStatusTakhfif=N'0' then N'درخواست تخفیف صادر نشده'  WHEN fldStatusTakhfif=N'1' THEN N'موافقت شده' WHEN fldStatusTakhfif=N'2' THEN N'عدم موافقت' WHEN fldStatusTakhfif=N'3' THEN N'ابطال شده' WHEN fldStatusTakhfif=N'4' THEN N'درخواست تخفیف' end as fldStatusTakhfifName ,
CASE WHEN fldStatusTaghsit=N'0' then N'درخواست تقسیط صادرنشده' WHEN fldStatusTaghsit=N'1' then N'موافقت شده' WHEN fldStatusTaghsit=N'2' then N'عدم موافقت' WHEN fldStatusTaghsit=N'3' then N'ابطال شده' WHEN fldStatusTaghsit=N'4' then N'درخواست تقسیط' end as  fldStatusTaghsitName,
CASE WHEN fldStatusKoli='1' THEN N'تسویه نقدی'  WHEN fldStatusKoli='2' THEN N'تسویه تقسیط' ELSE N'تسویه نشده' END AS fldStatusKoliName 
 ,SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,fldmobile
 FROM(SELECT fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate,  CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM tblcompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS fldShenaseMeli, 
            CASE WHEN (SELECT COUNT(*) FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId HAVING COUNT(fldid)>0)=(SELECT COUNT(fldFishId) FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)HAVING COUNT(fldFishId)>0) THEN N'4'
			WHEN (SELECT TOP(1) fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId ORDER BY fldId desc )  IN (SELECT fldFishId FROM Drd.tblEbtal ) THEN N'3'
			WHEN (SELECT COUNT(*) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(id) FROM ( SELECT MAX(fldId) AS id FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) GROUP BY fldCodeElamAvarezId)t) THEN N'1'
			WHEN EXISTS(SELECT * FROM Drd.tblSodoorFish_Detail WHERE fldCodeElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'2'
			ELSE N'0'END AS fldStatusFish
			,CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'4' 
			ELSE N'0' end AS fldStatusTaghsit,
		     CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'4' ELSE N'0' END
			 AS fldStatusTakhfif,
			CASE WHEN ((SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint) +cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			)OR ((SELECT (SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue)) /(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT SUM(fldMablaghAvarezGerdShode) FROM Drd.tblSodoorFish WHERE fldid IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId)AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId)) ) THEN N'1'
			WHEN (SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			THEN N'2'ELSE '0'END AS fldStatusKoli,
                     (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN '0' WHEN fldHoghoghiId IS NOT NULL THEN '1' END AS Expr1
                       FROM      Com.tblAshkhas
                       WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNoeShakhs, dbo.Fn_AssembelyMiladiToShamsi(flddate)fldTarikh ,
                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldFather_Sabt, fldOrganId
                       ,isnull((select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
)),0) fldReplyTaghsitId
                      ,isnull((SELECT isnull(SUM(fldTakhfifMaliyatValue+fldSumAsli+fldTakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue),SUM(fldMaliyatValue+fldSumAsli+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,isnull(fldMobile,'')fldMobile
FROM     Drd.tblElamAvarez
outer apply (
			select d.fldMobile from com.tblAshkhas a
			inner join com.tblEmployee_Detail d on d.fldEmployeeId=a.fldHaghighiId
			where a.fldid=Drd.tblElamAvarez.fldAshakhasID 
			)m_shaks
 where tblElamAvarez.fldId = @Value --and fldTarikh like @Year+'%'
)t
	WHERE  t.fldOrganId=@Value1
	ORDER BY fldid DESC
	
		
	end

	else if (@fieldname=N'fldMablaghKoli')
	begin
SELECT TOP (@h) fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate ,Noe,fldNameShakhs,fldShenaseMeli
  ,fldNoeShakhs,fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldOrganId,fldReplyTaghsitId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli/*-fldMablaghTakhfif*/),0) AS fldMablaghGHabelPardakht
,fldStatusFish,fldStatusTakhfif,fldStatusTaghsit,fldStatusKoli,fldNameOrgan,
CASE WHEN fldStatusFish=N'0' then N'فیشی صادر نشده'  WHEN fldStatusFish=N'1' then N'کلیه فیش های صادرشده'  WHEN fldStatusFish=N'2' then N'فیش صادر شده'  WHEN fldStatusFish=N'3' then N'ابطال فیش' WHEN fldStatusFish=N'4' then N'ابطال کلیه فیش ها' end as fldStatusFishName,
CASE WHEN fldStatusTakhfif=N'0' then N'درخواست تخفیف صادر نشده'  WHEN fldStatusTakhfif=N'1' THEN N'موافقت شده' WHEN fldStatusTakhfif=N'2' THEN N'عدم موافقت' WHEN fldStatusTakhfif=N'3' THEN N'ابطال شده' WHEN fldStatusTakhfif=N'4' THEN N'درخواست تخفیف' end as fldStatusTakhfifName ,
CASE WHEN fldStatusTaghsit=N'0' then N'درخواست تقسیط صادرنشده' WHEN fldStatusTaghsit=N'1' then N'موافقت شده' WHEN fldStatusTaghsit=N'2' then N'عدم موافقت' WHEN fldStatusTaghsit=N'3' then N'ابطال شده' WHEN fldStatusTaghsit=N'4' then N'درخواست تقسیط' end as  fldStatusTaghsitName,
CASE WHEN fldStatusKoli='1' THEN N'تسویه نقدی'  WHEN fldStatusKoli='2' THEN N'تسویه تقسیط' ELSE N'تسویه نشده' END AS fldStatusKoliName 
 ,SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,fldmobile
 FROM(SELECT fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM tblcompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe,  
                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS fldShenaseMeli, 
            CASE WHEN (SELECT COUNT(*) FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId HAVING COUNT(fldid)>0)=(SELECT COUNT(fldFishId) FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)HAVING COUNT(fldFishId)>0) THEN N'4'
			WHEN (SELECT TOP(1) fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId ORDER BY fldId desc )  IN (SELECT fldFishId FROM Drd.tblEbtal ) THEN N'3'
			WHEN (SELECT COUNT(*) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(id) FROM ( SELECT MAX(fldId) AS id FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) GROUP BY fldCodeElamAvarezId)t) THEN N'1'
			WHEN EXISTS(SELECT * FROM Drd.tblSodoorFish_Detail WHERE fldCodeElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'2'
			ELSE N'0'END AS fldStatusFish
			,CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'4' 
			ELSE N'0' end AS fldStatusTaghsit,
		     CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'4' ELSE N'0' END
			 AS fldStatusTakhfif,
			CASE WHEN ((SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			)OR ((SELECT (SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue)) /(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT SUM(fldMablaghAvarezGerdShode) FROM Drd.tblSodoorFish WHERE fldid IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId)AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId)) ) THEN N'1'
			WHEN (SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			THEN N'2'ELSE '0'END AS fldStatusKoli,
                     (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN '0' WHEN fldHoghoghiId IS NOT NULL THEN '1' END AS Expr1
                       FROM      Com.tblAshkhas
                       WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNoeShakhs,dbo.Fn_AssembelyMiladiToShamsi(flddate)fldTarikh ,
                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldFather_Sabt, fldOrganId
                      ,isnull((select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
)),0) fldReplyTaghsitId
                      ,isnull((SELECT isnull(SUM(fldTakhfifMaliyatValue+fldSumAsli+fldTakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue),SUM(fldMaliyatValue+fldSumAsli+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,isnull(fldMobile,'')fldMobile
FROM     Drd.tblElamAvarez
outer apply (
			select d.fldMobile from com.tblAshkhas a
			inner join com.tblEmployee_Detail d on d.fldEmployeeId=a.fldHaghighiId
			where a.fldid=Drd.tblElamAvarez.fldAshakhasID 
			)m_shaks

 --where fldTarikh like @Year+'%'
 )t
	WHERE  fldMablaghKoli like @Value and t.fldOrganId=@Value1
	ORDER BY fldid DESC
	
	end
	else if (@fieldname=N'SharhDesc')
	begin
SELECT TOP (@h) fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate ,Noe,fldNameShakhs,fldShenaseMeli
  ,fldNoeShakhs,fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldOrganId,fldReplyTaghsitId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli/*-fldMablaghTakhfif*/),0) AS fldMablaghGHabelPardakht
,fldStatusFish,fldStatusTakhfif,fldStatusTaghsit,fldStatusKoli,fldNameOrgan,
CASE WHEN fldStatusFish=N'0' then N'فیشی صادر نشده'  WHEN fldStatusFish=N'1' then N'کلیه فیش های صادرشده'  WHEN fldStatusFish=N'2' then N'فیش صادر شده'  WHEN fldStatusFish=N'3' then N'ابطال فیش' WHEN fldStatusFish=N'4' then N'ابطال کلیه فیش ها' end as fldStatusFishName,
CASE WHEN fldStatusTakhfif=N'0' then N'درخواست تخفیف صادر نشده'  WHEN fldStatusTakhfif=N'1' THEN N'موافقت شده' WHEN fldStatusTakhfif=N'2' THEN N'عدم موافقت' WHEN fldStatusTakhfif=N'3' THEN N'ابطال شده' WHEN fldStatusTakhfif=N'4' THEN N'درخواست تخفیف' end as fldStatusTakhfifName ,
CASE WHEN fldStatusTaghsit=N'0' then N'درخواست تقسیط صادرنشده' WHEN fldStatusTaghsit=N'1' then N'موافقت شده' WHEN fldStatusTaghsit=N'2' then N'عدم موافقت' WHEN fldStatusTaghsit=N'3' then N'ابطال شده' WHEN fldStatusTaghsit=N'4' then N'درخواست تقسیط' end as  fldStatusTaghsitName,
CASE WHEN fldStatusKoli='1' THEN N'تسویه نقدی'  WHEN fldStatusKoli='2' THEN N'تسویه تقسیط' ELSE N'تسویه نشده' END AS fldStatusKoliName 
 ,SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,fldmobile
 FROM(SELECT fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM tblcompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe,  
                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS fldShenaseMeli, 
            CASE WHEN (SELECT COUNT(*) FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId HAVING COUNT(fldid)>0)=(SELECT COUNT(fldFishId) FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)HAVING COUNT(fldFishId)>0) THEN N'4'
			WHEN (SELECT TOP(1) fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId ORDER BY fldId desc )  IN (SELECT fldFishId FROM Drd.tblEbtal ) THEN N'3'
			WHEN (SELECT COUNT(*) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(id) FROM ( SELECT MAX(fldId) AS id FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) GROUP BY fldCodeElamAvarezId)t) THEN N'1'
			WHEN EXISTS(SELECT * FROM Drd.tblSodoorFish_Detail WHERE fldCodeElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'2'
			ELSE N'0'END AS fldStatusFish
			,CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'4' 
			ELSE N'0' end AS fldStatusTaghsit,
		     CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'4' ELSE N'0' END
			 AS fldStatusTakhfif,
			CASE WHEN ((SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			)OR ((SELECT (SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue)) /(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT SUM(fldMablaghAvarezGerdShode) FROM Drd.tblSodoorFish WHERE fldid IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId)AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId)) ) THEN N'1'
			WHEN (SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			THEN N'2'ELSE '0'END AS fldStatusKoli,
                     (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN '0' WHEN fldHoghoghiId IS NOT NULL THEN '1' END AS Expr1
                       FROM      Com.tblAshkhas
                       WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNoeShakhs, dbo.Fn_AssembelyMiladiToShamsi(flddate)fldTarikh ,
                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldFather_Sabt, fldOrganId
                     ,isnull((select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
)),0) fldReplyTaghsitId
                      ,isnull((SELECT isnull(SUM(fldTakhfifMaliyatValue+fldSumAsli+fldTakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue),SUM(fldMaliyatValue+fldSumAsli+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,isnull(fldMobile,'')fldMobile
FROM     Drd.tblElamAvarez
outer apply (
			select d.fldMobile from com.tblAshkhas a
			inner join com.tblEmployee_Detail d on d.fldEmployeeId=a.fldHaghighiId
			where a.fldid=Drd.tblElamAvarez.fldAshakhasID 
			)m_shaks
			 where drd.fn_SharheCode_ElamAvarez(fldid)like @Value --and fldTarikh like @Year+'%'
)t
	WHERE  t.fldOrganId=@Value1
	ORDER BY fldid DESC
	end
		else if (@fieldname=N'fldMablaghTakhfif')
		begin
SELECT TOP (@h) fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate ,Noe,fldNameShakhs,fldShenaseMeli
  ,fldNoeShakhs,fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldOrganId,fldReplyTaghsitId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli/*-fldMablaghTakhfif*/),0) AS fldMablaghGHabelPardakht
,fldStatusFish,fldStatusTakhfif,fldStatusTaghsit,fldStatusKoli,fldNameOrgan,
CASE WHEN fldStatusFish=N'0' then N'فیشی صادر نشده'  WHEN fldStatusFish=N'1' then N'کلیه فیش های صادرشده'  WHEN fldStatusFish=N'2' then N'فیش صادر شده'  WHEN fldStatusFish=N'3' then N'ابطال فیش' WHEN fldStatusFish=N'4' then N'ابطال کلیه فیش ها' end as fldStatusFishName,
CASE WHEN fldStatusTakhfif=N'0' then N'درخواست تخفیف صادر نشده'  WHEN fldStatusTakhfif=N'1' THEN N'موافقت شده' WHEN fldStatusTakhfif=N'2' THEN N'عدم موافقت' WHEN fldStatusTakhfif=N'3' THEN N'ابطال شده' WHEN fldStatusTakhfif=N'4' THEN N'درخواست تخفیف' end as fldStatusTakhfifName ,
CASE WHEN fldStatusTaghsit=N'0' then N'درخواست تقسیط صادرنشده' WHEN fldStatusTaghsit=N'1' then N'موافقت شده' WHEN fldStatusTaghsit=N'2' then N'عدم موافقت' WHEN fldStatusTaghsit=N'3' then N'ابطال شده' WHEN fldStatusTaghsit=N'4' then N'درخواست تقسیط' end as  fldStatusTaghsitName,
CASE WHEN fldStatusKoli='1' THEN N'تسویه نقدی'  WHEN fldStatusKoli='2' THEN N'تسویه تقسیط' ELSE N'تسویه نشده' END AS fldStatusKoliName 
 ,SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,fldmobile
 FROM(SELECT fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM tblcompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS fldShenaseMeli, 
            CASE WHEN (SELECT COUNT(*) FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId HAVING COUNT(fldid)>0)=(SELECT COUNT(fldFishId) FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)HAVING COUNT(fldFishId)>0) THEN N'4'
			WHEN (SELECT TOP(1) fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId ORDER BY fldId desc )  IN (SELECT fldFishId FROM Drd.tblEbtal ) THEN N'3'
			WHEN (SELECT COUNT(*) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(id) FROM ( SELECT MAX(fldId) AS id FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) GROUP BY fldCodeElamAvarezId)t) THEN N'1'
			WHEN EXISTS(SELECT * FROM Drd.tblSodoorFish_Detail WHERE fldCodeElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'2'
			ELSE N'0'END AS fldStatusFish
			,CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'4' 
			ELSE N'0' end AS fldStatusTaghsit,
		     CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'4' ELSE N'0' END
			 AS fldStatusTakhfif,
			CASE WHEN ((SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			)OR ((SELECT (SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue)) /(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT SUM(fldMablaghAvarezGerdShode) FROM Drd.tblSodoorFish WHERE fldid IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId)AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId)) ) THEN N'1'
			WHEN (SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			THEN N'2'ELSE '0'END AS fldStatusKoli,
                     (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN '0' WHEN fldHoghoghiId IS NOT NULL THEN '1' END AS Expr1
                       FROM      Com.tblAshkhas
                       WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNoeShakhs,dbo.Fn_AssembelyMiladiToShamsi(flddate)fldTarikh,
                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldFather_Sabt, fldOrganId
                      ,isnull((select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
)),0) fldReplyTaghsitId
                      ,isnull((SELECT isnull(SUM(fldTakhfifMaliyatValue+fldSumAsli+fldTakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue),SUM(fldMaliyatValue+fldSumAsli+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,isnull(fldMobile,'')fldMobile
FROM     Drd.tblElamAvarez
outer apply (
			select d.fldMobile from com.tblAshkhas a
			inner join com.tblEmployee_Detail d on d.fldEmployeeId=a.fldHaghighiId
			where a.fldid=Drd.tblElamAvarez.fldAshakhasID 
			)m_shaks
 --where fldTarikh like @Year+'%'
 )t
	WHERE  fldMablaghTakhfif like @Value and t.fldOrganId=@Value1
	ORDER BY fldid DESC
	end
	else if (@fieldname=N'fldMablaghGHabelPardakht')
	begin
SELECT TOP (@h) * FROM (SELECT TOP (@h) fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate ,Noe,fldNameShakhs,fldShenaseMeli
  ,fldNoeShakhs,fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldOrganId,fldReplyTaghsitId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli/*-fldMablaghTakhfif*/),0) AS fldMablaghGHabelPardakht
,fldStatusFish,fldStatusTakhfif,fldStatusTaghsit,fldStatusKoli,fldNameOrgan,
CASE WHEN fldStatusFish=N'0' then N'فیشی صادر نشده'  WHEN fldStatusFish=N'1' then N'کلیه فیش های صادرشده'  WHEN fldStatusFish=N'2' then N'فیش صادر شده'  WHEN fldStatusFish=N'3' then N'ابطال فیش' WHEN fldStatusFish=N'4' then N'ابطال کلیه فیش ها' end as fldStatusFishName,
CASE WHEN fldStatusTakhfif=N'0' then N'درخواست تخفیف صادر نشده'  WHEN fldStatusTakhfif=N'1' THEN N'موافقت شده' WHEN fldStatusTakhfif=N'2' THEN N'عدم موافقت' WHEN fldStatusTakhfif=N'3' THEN N'ابطال شده' WHEN fldStatusTakhfif=N'4' THEN N'درخواست تخفیف' end as fldStatusTakhfifName ,
CASE WHEN fldStatusTaghsit=N'0' then N'درخواست تقسیط صادرنشده' WHEN fldStatusTaghsit=N'1' then N'موافقت شده' WHEN fldStatusTaghsit=N'2' then N'عدم موافقت' WHEN fldStatusTaghsit=N'3' then N'ابطال شده' WHEN fldStatusTaghsit=N'4' then N'درخواست تقسیط' end as  fldStatusTaghsitName,
CASE WHEN fldStatusKoli='1' THEN N'تسویه نقدی'  WHEN fldStatusKoli='2' THEN N'تسویه تقسیط' ELSE N'تسویه نشده' END AS fldStatusKoliName 
 ,SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,fldmobile
 FROM(SELECT fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate,  CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM tblcompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS fldShenaseMeli, 
            CASE WHEN (SELECT COUNT(*) FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId HAVING COUNT(fldid)>0)=(SELECT COUNT(fldFishId) FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)HAVING COUNT(fldFishId)>0) THEN N'4'
			WHEN (SELECT TOP(1) fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId ORDER BY fldId desc )  IN (SELECT fldFishId FROM Drd.tblEbtal ) THEN N'3'
			WHEN (SELECT COUNT(*) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(id) FROM ( SELECT MAX(fldId) AS id FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) GROUP BY fldCodeElamAvarezId)t) THEN N'1'
			WHEN EXISTS(SELECT * FROM Drd.tblSodoorFish_Detail WHERE fldCodeElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'2'
			ELSE N'0'END AS fldStatusFish
			,CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'4' 
			ELSE N'0' end AS fldStatusTaghsit,
		     CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'4' ELSE N'0' END
			 AS fldStatusTakhfif,
			CASE WHEN ((SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			)OR ((SELECT (SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue)) /(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT SUM(fldMablaghAvarezGerdShode) FROM Drd.tblSodoorFish WHERE fldid IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId)AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId)) ) THEN N'1'
			WHEN (SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			THEN N'2'ELSE '0'END AS fldStatusKoli,
                     (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN '0' WHEN fldHoghoghiId IS NOT NULL THEN '1' END AS Expr1
                       FROM      Com.tblAshkhas
                       WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNoeShakhs,dbo.Fn_AssembelyMiladiToShamsi(flddate)fldTarikh,
                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldFather_Sabt, fldOrganId
                      ,isnull((select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
)),0) fldReplyTaghsitId
                      ,isnull((SELECT isnull(SUM(fldTakhfifMaliyatValue+fldSumAsli+fldTakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue),SUM(fldMaliyatValue+fldSumAsli+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,isnull(fldMobile,'')fldMobile
FROM     Drd.tblElamAvarez
outer apply (
			select d.fldMobile from com.tblAshkhas a
			inner join com.tblEmployee_Detail d on d.fldEmployeeId=a.fldHaghighiId
			where a.fldid=Drd.tblElamAvarez.fldAshakhasID 
			)m_shaks
 --where fldTarikh like @Year+'%'
 )t
	)r
	WHERE fldMablaghGHabelPardakht like @value and r.fldOrganId=@Value1
	ORDER BY fldid DESC
	
	end
	else if (@fieldname=N'fldNameShakhs')
	begin
SELECT TOP (@h) fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate ,Noe,fldNameShakhs,fldShenaseMeli
  ,fldNoeShakhs,fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldOrganId,fldReplyTaghsitId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli/*-fldMablaghTakhfif*/),0) AS fldMablaghGHabelPardakht
,fldStatusFish,fldStatusTakhfif,fldStatusTaghsit,fldStatusKoli,fldNameOrgan,
CASE WHEN fldStatusFish=N'0' then N'فیشی صادر نشده'  WHEN fldStatusFish=N'1' then N'کلیه فیش های صادرشده'  WHEN fldStatusFish=N'2' then N'فیش صادر شده'  WHEN fldStatusFish=N'3' then N'ابطال فیش' WHEN fldStatusFish=N'4' then N'ابطال کلیه فیش ها' end as fldStatusFishName,
CASE WHEN fldStatusTakhfif=N'0' then N'درخواست تخفیف صادر نشده'  WHEN fldStatusTakhfif=N'1' THEN N'موافقت شده' WHEN fldStatusTakhfif=N'2' THEN N'عدم موافقت' WHEN fldStatusTakhfif=N'3' THEN N'ابطال شده' WHEN fldStatusTakhfif=N'4' THEN N'درخواست تخفیف' end as fldStatusTakhfifName ,
CASE WHEN fldStatusTaghsit=N'0' then N'درخواست تقسیط صادرنشده' WHEN fldStatusTaghsit=N'1' then N'موافقت شده' WHEN fldStatusTaghsit=N'2' then N'عدم موافقت' WHEN fldStatusTaghsit=N'3' then N'ابطال شده' WHEN fldStatusTaghsit=N'4' then N'درخواست تقسیط' end as  fldStatusTaghsitName,
CASE WHEN fldStatusKoli='1' THEN N'تسویه نقدی'  WHEN fldStatusKoli='2' THEN N'تسویه تقسیط' ELSE N'تسویه نشده' END AS fldStatusKoliName 
 ,SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,fldmobile
 FROM(SELECT fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate,  CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM tblcompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe,  
                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS fldShenaseMeli, 
            CASE WHEN (SELECT COUNT(*) FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId HAVING COUNT(fldid)>0)=(SELECT COUNT(fldFishId) FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)HAVING COUNT(fldFishId)>0) THEN N'4'
			WHEN (SELECT TOP(1) fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId ORDER BY fldId desc )  IN (SELECT fldFishId FROM Drd.tblEbtal ) THEN N'3'
			WHEN (SELECT COUNT(*) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(id) FROM ( SELECT MAX(fldId) AS id FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) GROUP BY fldCodeElamAvarezId)t) THEN N'1'
			WHEN EXISTS(SELECT * FROM Drd.tblSodoorFish_Detail WHERE fldCodeElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'2'
			ELSE N'0'END AS fldStatusFish
			,CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'4' 
			ELSE N'0' end AS fldStatusTaghsit,
		     CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'4' ELSE N'0' END
			 AS fldStatusTakhfif,
			CASE WHEN ((SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			)OR ((SELECT (SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue)) /(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT SUM(fldMablaghAvarezGerdShode) FROM Drd.tblSodoorFish WHERE fldid IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId)AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId)) ) THEN N'1'
			WHEN (SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			THEN N'2'ELSE '0'END AS fldStatusKoli,
                     (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN '0' WHEN fldHoghoghiId IS NOT NULL THEN '1' END AS Expr1
                       FROM      Com.tblAshkhas
                       WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNoeShakhs,dbo.Fn_AssembelyMiladiToShamsi(flddate)fldTarikh,
                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldFather_Sabt, fldOrganId
                      ,isnull((select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
)),0) fldReplyTaghsitId
                      ,isnull((SELECT isnull(SUM(fldTakhfifMaliyatValue+fldSumAsli+fldTakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue),SUM(fldMaliyatValue+fldSumAsli+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,isnull(fldMobile,'')fldMobile
FROM     Drd.tblElamAvarez
outer apply (
			select d.fldMobile from com.tblAshkhas a
			inner join com.tblEmployee_Detail d on d.fldEmployeeId=a.fldHaghighiId
			where a.fldid=Drd.tblElamAvarez.fldAshakhasID 
			)m_shaks
			 where Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) like @Value --and fldTarikh like @Year+'%'
)t
	WHERE  t.fldOrganId=@Value1
	ORDER BY fldid DESC
	end
	else IF (@fieldname=N'fldShenaseMeli')
	begin
SELECT TOP (@h) fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate ,Noe,fldNameShakhs,fldShenaseMeli
  ,fldNoeShakhs,fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldOrganId,fldReplyTaghsitId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli/*-fldMablaghTakhfif*/),0) AS fldMablaghGHabelPardakht
,fldStatusFish,fldStatusTakhfif,fldStatusTaghsit,fldStatusKoli,fldNameOrgan,
CASE WHEN fldStatusFish=N'0' then N'فیشی صادر نشده'  WHEN fldStatusFish=N'1' then N'کلیه فیش های صادرشده'  WHEN fldStatusFish=N'2' then N'فیش صادر شده'  WHEN fldStatusFish=N'3' then N'ابطال فیش' WHEN fldStatusFish=N'4' then N'ابطال کلیه فیش ها' end as fldStatusFishName,
CASE WHEN fldStatusTakhfif=N'0' then N'درخواست تخفیف صادر نشده'  WHEN fldStatusTakhfif=N'1' THEN N'موافقت شده' WHEN fldStatusTakhfif=N'2' THEN N'عدم موافقت' WHEN fldStatusTakhfif=N'3' THEN N'ابطال شده' WHEN fldStatusTakhfif=N'4' THEN N'درخواست تخفیف' end as fldStatusTakhfifName ,
CASE WHEN fldStatusTaghsit=N'0' then N'درخواست تقسیط صادرنشده' WHEN fldStatusTaghsit=N'1' then N'موافقت شده' WHEN fldStatusTaghsit=N'2' then N'عدم موافقت' WHEN fldStatusTaghsit=N'3' then N'ابطال شده' WHEN fldStatusTaghsit=N'4' then N'درخواست تقسیط' end as  fldStatusTaghsitName,
CASE WHEN fldStatusKoli='1' THEN N'تسویه نقدی'  WHEN fldStatusKoli='2' THEN N'تسویه تقسیط' ELSE N'تسویه نشده' END AS fldStatusKoliName 
 ,SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,fldmobile
 FROM(SELECT fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate,  CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM tblcompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe,  
                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS fldShenaseMeli, 
            CASE WHEN (SELECT COUNT(*) FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId HAVING COUNT(fldid)>0)=(SELECT COUNT(fldFishId) FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)HAVING COUNT(fldFishId)>0) THEN N'4'
			WHEN (SELECT TOP(1) fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId ORDER BY fldId desc )  IN (SELECT fldFishId FROM Drd.tblEbtal ) THEN N'3'
			WHEN (SELECT COUNT(*) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(id) FROM ( SELECT MAX(fldId) AS id FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) GROUP BY fldCodeElamAvarezId)t) THEN N'1'
			WHEN EXISTS(SELECT * FROM Drd.tblSodoorFish_Detail WHERE fldCodeElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'2'
			ELSE N'0'END AS fldStatusFish
			,CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'4' 
			ELSE N'0' end AS fldStatusTaghsit,
		     CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'4' ELSE N'0' END
			 AS fldStatusTakhfif,
			CASE WHEN ((SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			)OR ((SELECT (SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue)) /(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT SUM(fldMablaghAvarezGerdShode) FROM Drd.tblSodoorFish WHERE fldid IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId)AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId)) ) THEN N'1'
			WHEN (SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			THEN N'2'ELSE '0'END AS fldStatusKoli,
                     (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN '0' WHEN fldHoghoghiId IS NOT NULL THEN '1' END AS Expr1
                       FROM      Com.tblAshkhas
                       WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNoeShakhs,dbo.Fn_AssembelyMiladiToShamsi(flddate)fldTarikh,
                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldFather_Sabt, fldOrganId
                      ,isnull((select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
)),0) fldReplyTaghsitId
                      ,isnull((SELECT isnull(SUM(fldTakhfifMaliyatValue+fldSumAsli+fldTakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue),SUM(fldMaliyatValue+fldSumAsli+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,isnull(fldMobile,'')fldMobile
FROM     Drd.tblElamAvarez
outer apply (
			select d.fldMobile from com.tblAshkhas a
			inner join com.tblEmployee_Detail d on d.fldEmployeeId=a.fldHaghighiId
			where a.fldid=Drd.tblElamAvarez.fldAshakhasID 
			)m_shaks
			 where Com.fn_ShenaseMelliAshkhas(fldAshakhasID) like @Value --and fldTarikh like @Year+'%'
)t
	WHERE   t.fldOrganId=@Value1
	ORDER BY fldid DESC
	end
--	IF (@fieldname=N'fldStatus')
--	SELECT TOP (@h) fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate ,Noe,fldNameShakhs,fldShenaseMeli
--  ,fldNoeShakhs,fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldOrganId,fldReplyTaghsitId,fldMablaghKoli,fldMablaghTakhfif,(fldMablaghKoli-fldMablaghTakhfif) AS fldMablaghGHabelPardakht
--,fldStatusFish,fldStatusTakhfif,fldStatusTaghsit

-- FROM(SELECT fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' else '' END AS Noe, 
--                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS fldShenaseMeli, 
--            CASE WHEN (SELECT COUNT(*) FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(fldFishId) FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'4'
--			WHEN EXISTS (SELECT * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId)) THEN N'3'
--			WHEN (SELECT COUNT(*) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(id) FROM ( SELECT MAX(fldId) AS id FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) GROUP BY fldCodeElamAvarezId)t) THEN N'1'
--			WHEN EXISTS(SELECT * FROM Drd.tblSodoorFish_Detail WHERE fldCodeElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'2'
--			ELSE N'0'END AS fldStatusFish
--			,CASE WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'3'
--			WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)AND fldTypeRequest=2 AND fldTypeMojavez=1) THEN N'1'
--			WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)AND fldTypeRequest=2 AND fldTypeMojavez=2) THEN N'2'
--			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'4'
--			ELSE N'0' END AS fldStatusTakhfif
--			,CASE 
--			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'3'
--			WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)AND fldTypeRequest=1 AND fldTypeMojavez=1) THEN N'1'
--			WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)AND fldTypeRequest=1 AND fldTypeMojavez=2) THEN N'2'
--			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'4'
--			ELSE N'0' END AS fldStatusTaghsit,
--                     (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN '0' WHEN fldHoghoghiId IS NOT NULL THEN '1' END AS Expr1
--                       FROM      Com.tblAshkhas
--                       WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNoeShakhs, fldTarikh,
--                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
--                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldFather_Sabt, fldOrganId
--                      ,ISNULL(CASE WHEN fldId IN (SELECT TOP(1) fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldid and fldId IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=tblRequestTaghsit_Takhfif.fldid AND fldTypeMojavez=1 AND fldTypeRequest=1 ) AND tblRequestTaghsit_Takhfif.fldId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldId) ORDER BY fldId desc)
--                      THEN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT fldId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT TOP(1) fldid FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldid and fldId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldId) ORDER BY fldId desc ) AND fldTypeMojavez=1 AND fldTypeRequest=1)) ELSE 0 END,0) fldReplyTaghsitId
--                      ,isnull((SELECT SUM((fldMaliyatValue+(fldAvarezValue*fldTedad)+fldAsliValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
--						ISNULL((SELECT fldMablagh FROM Drd.tblReplyTakhfif WHERE fldStatusId IN (SELECT fldId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) )),0) AS fldMablaghTakhfif
--FROM     Drd.tblElamAvarez)t
--	WHERE  fldStatus like @Value
--	ORDER BY fldid DESC
	
	else IF (@fieldname=N'Noe')
	begin
SELECT TOP (@h) fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate ,Noe,fldNameShakhs,fldShenaseMeli
  ,fldNoeShakhs,fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldOrganId,fldReplyTaghsitId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli/*-fldMablaghTakhfif*/),0) AS fldMablaghGHabelPardakht
,fldStatusFish,fldStatusTakhfif,fldStatusTaghsit,fldStatusKoli,fldNameOrgan,
CASE WHEN fldStatusFish=N'0' then N'فیشی صادر نشده'  WHEN fldStatusFish=N'1' then N'کلیه فیش های صادرشده'  WHEN fldStatusFish=N'2' then N'فیش صادر شده'  WHEN fldStatusFish=N'3' then N'ابطال فیش' WHEN fldStatusFish=N'4' then N'ابطال کلیه فیش ها' end as fldStatusFishName,
CASE WHEN fldStatusTakhfif=N'0' then N'درخواست تخفیف صادر نشده'  WHEN fldStatusTakhfif=N'1' THEN N'موافقت شده' WHEN fldStatusTakhfif=N'2' THEN N'عدم موافقت' WHEN fldStatusTakhfif=N'3' THEN N'ابطال شده' WHEN fldStatusTakhfif=N'4' THEN N'درخواست تخفیف' end as fldStatusTakhfifName ,
CASE WHEN fldStatusTaghsit=N'0' then N'درخواست تقسیط صادرنشده' WHEN fldStatusTaghsit=N'1' then N'موافقت شده' WHEN fldStatusTaghsit=N'2' then N'عدم موافقت' WHEN fldStatusTaghsit=N'3' then N'ابطال شده' WHEN fldStatusTaghsit=N'4' then N'درخواست تقسیط' end as  fldStatusTaghsitName,
CASE WHEN fldStatusKoli='1' THEN N'تسویه نقدی'  WHEN fldStatusKoli='2' THEN N'تسویه تقسیط' ELSE N'تسویه نشده' END AS fldStatusKoliName 
 ,SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,fldmobile
 FROM(SELECT fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate,  CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM tblcompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS fldShenaseMeli, 
            CASE WHEN (SELECT COUNT(*) FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId HAVING COUNT(fldid)>0)=(SELECT COUNT(fldFishId) FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)HAVING COUNT(fldFishId)>0) THEN N'4'
			WHEN (SELECT TOP(1) fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId ORDER BY fldId desc )  IN (SELECT fldFishId FROM Drd.tblEbtal ) THEN N'3'
			WHEN (SELECT COUNT(*) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(id) FROM ( SELECT MAX(fldId) AS id FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) GROUP BY fldCodeElamAvarezId)t) THEN N'1'
			WHEN EXISTS(SELECT * FROM Drd.tblSodoorFish_Detail WHERE fldCodeElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'2'
			ELSE N'0'END AS fldStatusFish
			,CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'4' 
			ELSE N'0' end AS fldStatusTaghsit,
		     CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'4' ELSE N'0' END
			 AS fldStatusTakhfif,
			CASE WHEN ((SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			)OR ((SELECT (SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue)) /(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT SUM(fldMablaghAvarezGerdShode) FROM Drd.tblSodoorFish WHERE fldid IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId)AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId)) ) THEN N'1'
			WHEN (SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			THEN N'2'ELSE '0'END AS fldStatusKoli,
                     (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN '0' WHEN fldHoghoghiId IS NOT NULL THEN '1' END AS Expr1
                       FROM      Com.tblAshkhas
                       WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNoeShakhs,dbo.Fn_AssembelyMiladiToShamsi(flddate)fldTarikh,
                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldFather_Sabt, fldOrganId
                      ,isnull((select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
)),0) fldReplyTaghsitId
                      ,isnull((SELECT isnull(SUM(fldTakhfifMaliyatValue+fldSumAsli+fldTakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue),SUM(fldMaliyatValue+fldSumAsli+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,isnull(fldMobile,'')fldMobile
FROM     Drd.tblElamAvarez
outer apply (
			select d.fldMobile from com.tblAshkhas a
			inner join com.tblEmployee_Detail d on d.fldEmployeeId=a.fldHaghighiId
			where a.fldid=Drd.tblElamAvarez.fldAshakhasID 
			)m_shaks
 --where fldTarikh like @Year+'%'
 )t
	WHERE  Noe like @Value and t.fldOrganId=@Value1
	ORDER BY fldid DESC
	end
	else IF (@fieldname=N'fldNoeShakhs')
	begin
SELECT TOP (@h) fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate ,Noe,fldNameShakhs,fldShenaseMeli
  ,fldNoeShakhs,fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldOrganId,fldReplyTaghsitId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli/*-fldMablaghTakhfif*/),0) AS fldMablaghGHabelPardakht
,fldStatusFish,fldStatusTakhfif,fldStatusTaghsit,fldStatusKoli,fldNameOrgan,
CASE WHEN fldStatusFish=N'0' then N'فیشی صادر نشده'  WHEN fldStatusFish=N'1' then N'کلیه فیش های صادرشده'  WHEN fldStatusFish=N'2' then N'فیش صادر شده'  WHEN fldStatusFish=N'3' then N'ابطال فیش' WHEN fldStatusFish=N'4' then N'ابطال کلیه فیش ها' end as fldStatusFishName,
CASE WHEN fldStatusTakhfif=N'0' then N'درخواست تخفیف صادر نشده'  WHEN fldStatusTakhfif=N'1' THEN N'موافقت شده' WHEN fldStatusTakhfif=N'2' THEN N'عدم موافقت' WHEN fldStatusTakhfif=N'3' THEN N'ابطال شده' WHEN fldStatusTakhfif=N'4' THEN N'درخواست تخفیف' end as fldStatusTakhfifName ,
CASE WHEN fldStatusTaghsit=N'0' then N'درخواست تقسیط صادرنشده' WHEN fldStatusTaghsit=N'1' then N'موافقت شده' WHEN fldStatusTaghsit=N'2' then N'عدم موافقت' WHEN fldStatusTaghsit=N'3' then N'ابطال شده' WHEN fldStatusTaghsit=N'4' then N'درخواست تقسیط' end as  fldStatusTaghsitName,
CASE WHEN fldStatusKoli='1' THEN N'تسویه نقدی'  WHEN fldStatusKoli='2' THEN N'تسویه تقسیط' ELSE N'تسویه نشده' END AS fldStatusKoliName 
 ,SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,fldmobile
 FROM(SELECT fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate,  CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM tblcompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS fldShenaseMeli, 
            CASE WHEN (SELECT COUNT(*) FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId HAVING COUNT(fldid)>0)=(SELECT COUNT(fldFishId) FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)HAVING COUNT(fldFishId)>0) THEN N'4'
			WHEN (SELECT TOP(1) fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId ORDER BY fldId desc )  IN (SELECT fldFishId FROM Drd.tblEbtal ) THEN N'3'
			WHEN (SELECT COUNT(*) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(id) FROM ( SELECT MAX(fldId) AS id FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) GROUP BY fldCodeElamAvarezId)t) THEN N'1'
			WHEN EXISTS(SELECT * FROM Drd.tblSodoorFish_Detail WHERE fldCodeElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'2'
			ELSE N'0'END AS fldStatusFish
			,CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'4' 
			ELSE N'0' end AS fldStatusTaghsit,
		     CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'4' ELSE N'0' END
			 AS fldStatusTakhfif,
			CASE WHEN ((SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			)OR ((SELECT (SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue)) /(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT SUM(fldMablaghAvarezGerdShode) FROM Drd.tblSodoorFish WHERE fldid IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId)AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId)) ) THEN N'1'
			WHEN (SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			THEN N'2'ELSE '0'END AS fldStatusKoli,
                     (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN '0' WHEN fldHoghoghiId IS NOT NULL THEN '1' END AS Expr1
                       FROM      Com.tblAshkhas
                       WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNoeShakhs,dbo.Fn_AssembelyMiladiToShamsi(flddate)fldTarikh,
                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldFather_Sabt, fldOrganId
                      , isnull((select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
)),0) fldReplyTaghsitId
                      ,isnull((SELECT isnull(SUM(fldTakhfifMaliyatValue+fldSumAsli+fldTakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue),SUM(fldMaliyatValue+fldSumAsli+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,isnull(fldMobile,'')fldMobile
FROM     Drd.tblElamAvarez
outer apply (
			select d.fldMobile from com.tblAshkhas a
			inner join com.tblEmployee_Detail d on d.fldEmployeeId=a.fldHaghighiId
			where a.fldid=Drd.tblElamAvarez.fldAshakhasID 
			)m_shaks
 --where fldTarikh like @Year+'%'
 )t
	WHERE  fldNoeShakhs like @Value and t.fldOrganId=@Value1
	ORDER BY fldid DESC
	end
	else IF (@fieldname=N'fldTarikh')
	begin
	declare @date date
	set @date=com.ShamsiToMiladi(replace(@Value,'%',''))
SELECT TOP (@h) fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate ,Noe,fldNameShakhs,fldShenaseMeli
  ,fldNoeShakhs,fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldOrganId,fldReplyTaghsitId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli/*-fldMablaghTakhfif*/),0) AS fldMablaghGHabelPardakht
,fldStatusFish,fldStatusTakhfif,fldStatusTaghsit,fldStatusKoli,fldNameOrgan,
CASE WHEN fldStatusFish=N'0' then N'فیشی صادر نشده'  WHEN fldStatusFish=N'1' then N'کلیه فیش های صادرشده'  WHEN fldStatusFish=N'2' then N'فیش صادر شده'  WHEN fldStatusFish=N'3' then N'ابطال فیش' WHEN fldStatusFish=N'4' then N'ابطال کلیه فیش ها' end as fldStatusFishName,
CASE WHEN fldStatusTakhfif=N'0' then N'درخواست تخفیف صادر نشده'  WHEN fldStatusTakhfif=N'1' THEN N'موافقت شده' WHEN fldStatusTakhfif=N'2' THEN N'عدم موافقت' WHEN fldStatusTakhfif=N'3' THEN N'ابطال شده' WHEN fldStatusTakhfif=N'4' THEN N'درخواست تخفیف' end as fldStatusTakhfifName ,
CASE WHEN fldStatusTaghsit=N'0' then N'درخواست تقسیط صادرنشده' WHEN fldStatusTaghsit=N'1' then N'موافقت شده' WHEN fldStatusTaghsit=N'2' then N'عدم موافقت' WHEN fldStatusTaghsit=N'3' then N'ابطال شده' WHEN fldStatusTaghsit=N'4' then N'درخواست تقسیط' end as  fldStatusTaghsitName,
CASE WHEN fldStatusKoli='1' THEN N'تسویه نقدی'  WHEN fldStatusKoli='2' THEN N'تسویه تقسیط' ELSE N'تسویه نشده' END AS fldStatusKoliName 
 ,SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,fldmobile
 FROM(SELECT fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate,  CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM tblcompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS fldShenaseMeli, 
            CASE WHEN (SELECT COUNT(*) FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId HAVING COUNT(fldid)>0)=(SELECT COUNT(fldFishId) FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)HAVING COUNT(fldFishId)>0) THEN N'4'
			WHEN (SELECT TOP(1) fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId ORDER BY fldId desc )  IN (SELECT fldFishId FROM Drd.tblEbtal ) THEN N'3'
			WHEN (SELECT COUNT(*) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(id) FROM ( SELECT MAX(fldId) AS id FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) GROUP BY fldCodeElamAvarezId)t) THEN N'1'
			WHEN EXISTS(SELECT * FROM Drd.tblSodoorFish_Detail WHERE fldCodeElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'2'
			ELSE N'0'END AS fldStatusFish
			,CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'4' 
			ELSE N'0' end AS fldStatusTaghsit,
		     CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'4' ELSE N'0' END
			 AS fldStatusTakhfif,
			CASE WHEN ((SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			)OR ((SELECT (SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue)) /(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT SUM(fldMablaghAvarezGerdShode) FROM Drd.tblSodoorFish WHERE fldid IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId)AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId)) ) THEN N'1'
			WHEN (SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			THEN N'2'ELSE '0'END AS fldStatusKoli,
                     (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN '0' WHEN fldHoghoghiId IS NOT NULL THEN '1' END AS Expr1
                       FROM      Com.tblAshkhas
                       WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNoeShakhs,dbo.Fn_AssembelyMiladiToShamsi(flddate)fldTarikh,
                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldFather_Sabt, fldOrganId
                      ,isnull((select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
)),0) fldReplyTaghsitId
                      ,isnull((SELECT isnull(SUM(fldTakhfifMaliyatValue+fldSumAsli+fldTakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue),SUM(fldMaliyatValue+fldSumAsli+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,isnull(fldMobile,'')fldMobile
FROM     Drd.tblElamAvarez
outer apply (
			select d.fldMobile from com.tblAshkhas a
			inner join com.tblEmployee_Detail d on d.fldEmployeeId=a.fldHaghighiId
			where a.fldid=Drd.tblElamAvarez.fldAshakhasID 
			)m_shaks
			 WHERE cast(Drd.tblElamAvarez.flddate as date) = @date --and fldTarikh like @Year+'%'
)t
	WHERE t.fldOrganId=@Value1
	ORDER BY fldid DESC

	end

		else if (@fieldname=N'fldAshakhasID')
		begin
SELECT TOP (@h) fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate ,Noe,fldNameShakhs,fldShenaseMeli
  ,fldNoeShakhs,fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldOrganId,fldReplyTaghsitId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli/*-fldMablaghTakhfif*/),0) AS fldMablaghGHabelPardakht
,fldStatusFish,fldStatusTakhfif,fldStatusTaghsit,fldStatusKoli,fldNameOrgan,
CASE WHEN fldStatusFish=N'0' then N'فیشی صادر نشده'  WHEN fldStatusFish=N'1' then N'کلیه فیش های صادرشده'  WHEN fldStatusFish=N'2' then N'فیش صادر شده'  WHEN fldStatusFish=N'3' then N'ابطال فیش' WHEN fldStatusFish=N'4' then N'ابطال کلیه فیش ها' end as fldStatusFishName,
CASE WHEN fldStatusTakhfif=N'0' then N'درخواست تخفیف صادر نشده'  WHEN fldStatusTakhfif=N'1' THEN N'موافقت شده' WHEN fldStatusTakhfif=N'2' THEN N'عدم موافقت' WHEN fldStatusTakhfif=N'3' THEN N'ابطال شده' WHEN fldStatusTakhfif=N'4' THEN N'درخواست تخفیف' end as fldStatusTakhfifName ,
CASE WHEN fldStatusTaghsit=N'0' then N'درخواست تقسیط صادرنشده' WHEN fldStatusTaghsit=N'1' then N'موافقت شده' WHEN fldStatusTaghsit=N'2' then N'عدم موافقت' WHEN fldStatusTaghsit=N'3' then N'ابطال شده' WHEN fldStatusTaghsit=N'4' then N'درخواست تقسیط' end as  fldStatusTaghsitName,
CASE WHEN fldStatusKoli='1' THEN N'تسویه نقدی'  WHEN fldStatusKoli='2' THEN N'تسویه تقسیط' ELSE N'تسویه نشده' END AS fldStatusKoliName 
 ,SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,fldmobile
 FROM(SELECT fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate,  CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM tblcompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe,  
                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS fldShenaseMeli, 
            CASE WHEN (SELECT COUNT(*) FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId HAVING COUNT(fldid)>0)=(SELECT COUNT(fldFishId) FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)HAVING COUNT(fldFishId)>0) THEN N'4'
			WHEN (SELECT TOP(1) fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId ORDER BY fldId desc )  IN (SELECT fldFishId FROM Drd.tblEbtal ) THEN N'3'
			WHEN (SELECT COUNT(*) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(id) FROM ( SELECT MAX(fldId) AS id FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) GROUP BY fldCodeElamAvarezId)t) THEN N'1'
			WHEN EXISTS(SELECT * FROM Drd.tblSodoorFish_Detail WHERE fldCodeElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'2'
			ELSE N'0'END AS fldStatusFish
			,CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'4' 
			ELSE N'0' end AS fldStatusTaghsit,
		     CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'4' ELSE N'0' END
			 AS fldStatusTakhfif,
			CASE WHEN ((SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			)OR ((SELECT (SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue)) /(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT SUM(fldMablaghAvarezGerdShode) FROM Drd.tblSodoorFish WHERE fldid IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId)AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId)) ) THEN N'1'
			WHEN (SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			THEN N'2'ELSE '0'END AS fldStatusKoli,
                     (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN '0' WHEN fldHoghoghiId IS NOT NULL THEN '1' END AS Expr1
                       FROM      Com.tblAshkhas
                       WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNoeShakhs,dbo.Fn_AssembelyMiladiToShamsi(flddate)fldTarikh,
                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldFather_Sabt, fldOrganId
                      ,isnull((select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
)),0) fldReplyTaghsitId
                      ,isnull((SELECT isnull(SUM(fldTakhfifMaliyatValue+fldSumAsli+fldTakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue),SUM(fldMaliyatValue+fldSumAsli+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,isnull(fldMobile,'')fldMobile
FROM     Drd.tblElamAvarez
outer apply (
			select d.fldMobile from com.tblAshkhas a
			inner join com.tblEmployee_Detail d on d.fldEmployeeId=a.fldHaghighiId
			where a.fldid=Drd.tblElamAvarez.fldAshakhasID 
			)m_shaks
--where   fldTarikh like @Year+'%'
)t
WHERE  fldAshakhasID = @Value and t.fldOrganId=@Value1

end
		else if (@fieldname=N'CheckAshakhasID')
		begin
SELECT TOP (@h) fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate ,Noe,fldNameShakhs,fldShenaseMeli
  ,fldNoeShakhs,fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldOrganId,fldReplyTaghsitId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli/*-fldMablaghTakhfif*/),0) AS fldMablaghGHabelPardakht
,fldStatusFish,fldStatusTakhfif,fldStatusTaghsit,fldStatusKoli,fldNameOrgan,
CASE WHEN fldStatusFish=N'0' then N'فیشی صادر نشده'  WHEN fldStatusFish=N'1' then N'کلیه فیش های صادرشده'  WHEN fldStatusFish=N'2' then N'فیش صادر شده'  WHEN fldStatusFish=N'3' then N'ابطال فیش' WHEN fldStatusFish=N'4' then N'ابطال کلیه فیش ها' end as fldStatusFishName,
CASE WHEN fldStatusTakhfif=N'0' then N'درخواست تخفیف صادر نشده'  WHEN fldStatusTakhfif=N'1' THEN N'موافقت شده' WHEN fldStatusTakhfif=N'2' THEN N'عدم موافقت' WHEN fldStatusTakhfif=N'3' THEN N'ابطال شده' WHEN fldStatusTakhfif=N'4' THEN N'درخواست تخفیف' end as fldStatusTakhfifName ,
CASE WHEN fldStatusTaghsit=N'0' then N'درخواست تقسیط صادرنشده' WHEN fldStatusTaghsit=N'1' then N'موافقت شده' WHEN fldStatusTaghsit=N'2' then N'عدم موافقت' WHEN fldStatusTaghsit=N'3' then N'ابطال شده' WHEN fldStatusTaghsit=N'4' then N'درخواست تقسیط' end as  fldStatusTaghsitName,
CASE WHEN fldStatusKoli='1' THEN N'تسویه نقدی'  WHEN fldStatusKoli='2' THEN N'تسویه تقسیط' ELSE N'تسویه نشده' END AS fldStatusKoliName 
 ,SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,fldmobile
 FROM(SELECT fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate,  CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM tblcompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe,  
                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS fldShenaseMeli, 
            CASE WHEN (SELECT COUNT(*) FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId HAVING COUNT(fldid)>0)=(SELECT COUNT(fldFishId) FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)HAVING COUNT(fldFishId)>0) THEN N'4'
			WHEN (SELECT TOP(1) fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId ORDER BY fldId desc )  IN (SELECT fldFishId FROM Drd.tblEbtal ) THEN N'3'
			WHEN (SELECT COUNT(*) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(id) FROM ( SELECT MAX(fldId) AS id FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) GROUP BY fldCodeElamAvarezId)t) THEN N'1'
			WHEN EXISTS(SELECT * FROM Drd.tblSodoorFish_Detail WHERE fldCodeElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'2'
			ELSE N'0'END AS fldStatusFish
			,CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'4' 
			ELSE N'0' end AS fldStatusTaghsit,
		     CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'4' ELSE N'0' END
			 AS fldStatusTakhfif,
			CASE WHEN ((SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			)OR ((SELECT (SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue)) /(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT SUM(fldMablaghAvarezGerdShode) FROM Drd.tblSodoorFish WHERE fldid IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId)AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId)) ) THEN N'1'
			WHEN (SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			THEN N'2'ELSE '0'END AS fldStatusKoli,
                     (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN '0' WHEN fldHoghoghiId IS NOT NULL THEN '1' END AS Expr1
                       FROM      Com.tblAshkhas
                       WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNoeShakhs,dbo.Fn_AssembelyMiladiToShamsi(flddate)fldTarikh,
                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldFather_Sabt, fldOrganId
                      ,isnull((select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
)),0) fldReplyTaghsitId
                      ,isnull((SELECT isnull(SUM(fldTakhfifMaliyatValue+fldSumAsli+fldTakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue),SUM(fldMaliyatValue+fldSumAsli+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,isnull(fldMobile,'')fldMobile
FROM     Drd.tblElamAvarez
outer apply (
			select d.fldMobile from com.tblAshkhas a
			inner join com.tblEmployee_Detail d on d.fldEmployeeId=a.fldHaghighiId
			where a.fldid=Drd.tblElamAvarez.fldAshakhasID 
			)m_shaks
)t
WHERE  fldAshakhasID = @Value 

end
	else 	if (@fieldname=N'fldDesc')
	begin
SELECT TOP (@h) fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate ,Noe,fldNameShakhs,fldShenaseMeli
  ,fldNoeShakhs,fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldOrganId,fldReplyTaghsitId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli/*-fldMablaghTakhfif*/),0) AS fldMablaghGHabelPardakht
,fldStatusFish,fldStatusTakhfif,fldStatusTaghsit,fldStatusKoli,fldNameOrgan,
CASE WHEN fldStatusFish=N'0' then N'فیشی صادر نشده'  WHEN fldStatusFish=N'1' then N'کلیه فیش های صادرشده'  WHEN fldStatusFish=N'2' then N'فیش صادر شده'  WHEN fldStatusFish=N'3' then N'ابطال فیش' WHEN fldStatusFish=N'4' then N'ابطال کلیه فیش ها' end as fldStatusFishName,
CASE WHEN fldStatusTakhfif=N'0' then N'درخواست تخفیف صادر نشده'  WHEN fldStatusTakhfif=N'1' THEN N'موافقت شده' WHEN fldStatusTakhfif=N'2' THEN N'عدم موافقت' WHEN fldStatusTakhfif=N'3' THEN N'ابطال شده' WHEN fldStatusTakhfif=N'4' THEN N'درخواست تخفیف' end as fldStatusTakhfifName ,
CASE WHEN fldStatusTaghsit=N'0' then N'درخواست تقسیط صادرنشده' WHEN fldStatusTaghsit=N'1' then N'موافقت شده' WHEN fldStatusTaghsit=N'2' then N'عدم موافقت' WHEN fldStatusTaghsit=N'3' then N'ابطال شده' WHEN fldStatusTaghsit=N'4' then N'درخواست تقسیط' end as  fldStatusTaghsitName,
CASE WHEN fldStatusKoli='1' THEN N'تسویه نقدی'  WHEN fldStatusKoli='2' THEN N'تسویه تقسیط' ELSE N'تسویه نشده' END AS fldStatusKoliName 
 ,SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,fldmobile
 FROM(SELECT fldId, fldAshakhasID, fldType, fldUserId, fldDesc, fldDate, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM tblcompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, Com.fn_ShenaseMelliAshkhas(fldAshakhasID) AS fldShenaseMeli, 
            CASE WHEN (SELECT COUNT(*) FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId HAVING COUNT(fldid)>0)=(SELECT COUNT(fldFishId) FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)HAVING COUNT(fldFishId)>0) THEN N'4'
			WHEN (SELECT TOP(1) fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId ORDER BY fldId desc )  IN (SELECT fldFishId FROM Drd.tblEbtal ) THEN N'3'
			WHEN (SELECT COUNT(*) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)=(SELECT COUNT(id) FROM ( SELECT MAX(fldId) AS id FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId) GROUP BY fldCodeElamAvarezId)t) THEN N'1'
			WHEN EXISTS(SELECT * FROM Drd.tblSodoorFish_Detail WHERE fldCodeElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)) THEN N'2'
			ELSE N'0'END AS fldStatusFish
			,CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1) THEN N'4' 
			ELSE N'0' end AS fldStatusTaghsit,
		     CASE WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'1'
			WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN N'2'
			WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN N'3'
			WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=2) THEN N'4' ELSE N'0' END
			 AS fldStatusTakhfif,
			CASE WHEN ((SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus=2 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)))))
			)OR ((SELECT (SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue)) /(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE tblTanzimateDaramad.fldOrganId=Drd.tblElamAvarez.fldOrganId) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT SUM(fldMablaghAvarezGerdShode) FROM Drd.tblSodoorFish WHERE fldid IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId)AND fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId)) ) THEN N'1'
			WHEN (SELECT  sum(cast(cast(fldAsliValue as bigint)*cast(fldtedad as bigint)+cast(fldMaliyatValue as bigint)+cast(fldAvarezValue as bigint)+cast(fldAmuzeshParvareshValue as bigint)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId)
			=(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblCheck WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblSafte WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablaghSanad as bigint)),0) FROM Drd.tblBarat WHERE fldStatus<>5 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			+(SELECT isnull(SUM(cast(fldMablagh as bigint)),0) FROM Drd.tblNaghdi_Talab WHERE fldType=0 AND fldReplyTaghsitId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId IN (SELECT  fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId))))
			THEN N'2'ELSE '0'END AS fldStatusKoli,
                     (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN '0' WHEN fldHoghoghiId IS NOT NULL THEN '1' END AS Expr1
                       FROM      Com.tblAshkhas
                       WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNoeShakhs,dbo.Fn_AssembelyMiladiToShamsi(flddate) fldTarikh,
                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldFather_Sabt, fldOrganId
                      ,isnull((select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
)),0) fldReplyTaghsitId
                      ,isnull((SELECT isnull(SUM(fldTakhfifMaliyatValue+fldSumAsli+fldTakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue),SUM(fldMaliyatValue+fldSumAsli+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda,isnull(fldMobile,'')fldMobile
FROM     Drd.tblElamAvarez
outer apply (
			select d.fldMobile from com.tblAshkhas a
			inner join com.tblEmployee_Detail d on d.fldEmployeeId=a.fldHaghighiId
			where a.fldid=Drd.tblElamAvarez.fldAshakhasID 
			)m_shaks
--where   fldTarikh like @Year+'%'
)t
	WHERE  t.fldDesc like @Value and t.fldOrganId=@Value1
	
	end

	
	COMMIT
GO
