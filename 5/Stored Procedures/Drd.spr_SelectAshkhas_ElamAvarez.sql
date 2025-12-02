SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_SelectAshkhas_ElamAvarez](@fieldName NVARCHAR(50),@value NVARCHAR(50),@h INT,@AshkhasId INT)
AS
BEGIN TRAN
if (@h=0) set @h=2147483647
IF(@fieldname='')
SELECT   TOP(@h)fldId, fldType, 
  fldTarikh,fldOrganId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli-fldMablaghTakhfif),0) AS fldMablaghGHabelPardakht
,fldNameOrgan,SharhDesc,Noe,y.FishId,y.ReplyId,fldDesc
 FROM
 (SELECT fldId, fldAshakhasID, fldType, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM drd.tblCompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
             CASE WHEN EXISTS (SELECT * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId= tblSodoorFish.fldid)) THEN '1' ELSE '0' END AS FishSaderShode
			,CASE WHEN EXISTS (select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
))THEN N'1' ELSE N'0' END IsTaghsit
		   , dbo.Fn_AssembelyMiladiToShamsi(Drd.tblElamAvarez.fldDate) fldTarikh,
                     fldOrganId,
                   ISNULL( (SELECT TOP(1) tblSodoorFish.fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldid AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldid) ),0) AS FishId
                   ,ISNULL((SELECT TOP(1) tblRequestTaghsit_Takhfif.fldid FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 
                   AND  tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldId) ORDER BY tblRequestTaghsit_Takhfif.fldId DESC),0)AS ReplyId
                      ,isnull((SELECT SUM((fldMaliyatValue+(fldAsliValue*fldTedad)+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,Drd.tblElamAvarez.fldDesc
FROM     Drd.tblElamAvarez)y
WHERE y.fldAshakhasID=@AshkhasId

if (@fieldname=N'fldId')
SELECT   TOP(@h)fldId, fldType, 
  fldTarikh,fldOrganId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli-fldMablaghTakhfif),0) AS fldMablaghGHabelPardakht
,fldNameOrgan,SharhDesc,Noe,y.FishId,y.ReplyId,fldDesc
 FROM
 (SELECT fldId, fldAshakhasID, fldType, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM drd.tblCompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
             CASE WHEN EXISTS (SELECT * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId= tblSodoorFish.fldid)) THEN '1' ELSE '0' END AS FishSaderShode
			,CASE WHEN EXISTS (select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
))THEN N'1' ELSE N'0' END IsTaghsit
		   , dbo.Fn_AssembelyMiladiToShamsi(Drd.tblElamAvarez.fldDate) fldTarikh,
                     fldOrganId,
                   ISNULL( (SELECT TOP(1) tblSodoorFish.fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldid AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldid) ),0) AS FishId
                   ,ISNULL((SELECT TOP(1) tblRequestTaghsit_Takhfif.fldid FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 
                   AND  tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldId) ORDER BY tblRequestTaghsit_Takhfif.fldId DESC),0)AS ReplyId
                      ,isnull((SELECT SUM((fldMaliyatValue+(fldAsliValue*fldTedad)+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,Drd.tblElamAvarez.fldDesc
FROM     Drd.tblElamAvarez)y
WHERE y.fldId=@value AND y.fldAshakhasID=@AshkhasId


if (@fieldname=N'Noe')
SELECT   TOP(@h)fldId, fldType, 
  fldTarikh,fldOrganId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli-fldMablaghTakhfif),0) AS fldMablaghGHabelPardakht
,fldNameOrgan,SharhDesc,Noe,y.FishId,y.ReplyId,fldDesc
 FROM
 (SELECT fldId, fldAshakhasID, fldType, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM drd.tblCompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
             CASE WHEN EXISTS (SELECT * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId= tblSodoorFish.fldid)) THEN '1' ELSE '0' END AS FishSaderShode
			,CASE WHEN EXISTS (select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
))THEN N'1' ELSE N'0' END IsTaghsit
		   , dbo.Fn_AssembelyMiladiToShamsi(Drd.tblElamAvarez.fldDate) fldTarikh,
                     fldOrganId,
                   ISNULL( (SELECT TOP(1) tblSodoorFish.fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldid AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldid) ),0) AS FishId
                   ,ISNULL((SELECT TOP(1) tblRequestTaghsit_Takhfif.fldid FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 
                   AND  tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldId) ORDER BY tblRequestTaghsit_Takhfif.fldId DESC),0)AS ReplyId
                      ,isnull((SELECT SUM((fldMaliyatValue+(fldAsliValue*fldTedad)+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,Drd.tblElamAvarez.fldDesc
FROM     Drd.tblElamAvarez)y
WHERE y.Noe=@value AND y.fldAshakhasID=@AshkhasId

if (@fieldname=N'fldTarikh')
SELECT   TOP(@h)fldId, fldType, 
  fldTarikh,fldOrganId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli-fldMablaghTakhfif),0) AS fldMablaghGHabelPardakht
,fldNameOrgan,SharhDesc,Noe,y.FishId,y.ReplyId,fldDesc
 FROM
 (SELECT fldId, fldAshakhasID, fldType, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM drd.tblCompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
             CASE WHEN EXISTS (SELECT * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId= tblSodoorFish.fldid)) THEN '1' ELSE '0' END AS FishSaderShode
			,CASE WHEN EXISTS (select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
))THEN N'1' ELSE N'0' END IsTaghsit
		   , dbo.Fn_AssembelyMiladiToShamsi(Drd.tblElamAvarez.fldDate) fldTarikh,
                     fldOrganId,
                   ISNULL( (SELECT TOP(1) tblSodoorFish.fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldid AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldid) ),0) AS FishId
                   ,ISNULL((SELECT TOP(1) tblRequestTaghsit_Takhfif.fldid FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 
                   AND  tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldId) ORDER BY tblRequestTaghsit_Takhfif.fldId DESC),0)AS ReplyId
                      ,isnull((SELECT SUM((fldMaliyatValue+(fldAsliValue*fldTedad)+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,Drd.tblElamAvarez.fldDesc
FROM     Drd.tblElamAvarez)y
WHERE y.fldTarikh=@value AND y.fldAshakhasID=@AshkhasId

if (@fieldname=N'fldMablaghKoli')
SELECT   TOP(@h)fldId, fldType, 
  fldTarikh,fldOrganId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli-fldMablaghTakhfif),0) AS fldMablaghGHabelPardakht
,fldNameOrgan,SharhDesc,Noe,y.FishId,y.ReplyId,fldDesc
 FROM
 (SELECT fldId, fldAshakhasID, fldType, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM drd.tblCompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
             CASE WHEN EXISTS (SELECT * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId= tblSodoorFish.fldid)) THEN '1' ELSE '0' END AS FishSaderShode
			,CASE WHEN EXISTS (select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
))THEN N'1' ELSE N'0' END IsTaghsit
		   , dbo.Fn_AssembelyMiladiToShamsi(Drd.tblElamAvarez.fldDate) fldTarikh,
                     fldOrganId,
                   ISNULL( (SELECT TOP(1) tblSodoorFish.fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldid AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldid) ),0) AS FishId
                   ,ISNULL((SELECT TOP(1) tblRequestTaghsit_Takhfif.fldid FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 
                   AND  tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldId) ORDER BY tblRequestTaghsit_Takhfif.fldId DESC),0)AS ReplyId
                      ,isnull((SELECT SUM((fldMaliyatValue+(fldAsliValue*fldTedad)+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,Drd.tblElamAvarez.fldDesc
FROM     Drd.tblElamAvarez)y
WHERE y.fldMablaghKoli=@value AND y.fldAshakhasID=@AshkhasId


if (@fieldname=N'fldMablaghTakhfif')
SELECT   TOP(@h)fldId, fldType, 
  fldTarikh,fldOrganId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli-fldMablaghTakhfif),0) AS fldMablaghGHabelPardakht
,fldNameOrgan,SharhDesc,Noe,y.FishId,y.ReplyId,fldDesc
 FROM
 (SELECT fldId, fldAshakhasID, fldType, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM drd.tblCompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
             CASE WHEN EXISTS (SELECT * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId= tblSodoorFish.fldid)) THEN '1' ELSE '0' END AS FishSaderShode
			,CASE WHEN EXISTS (select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
))THEN N'1' ELSE N'0' END IsTaghsit
		   , dbo.Fn_AssembelyMiladiToShamsi(Drd.tblElamAvarez.fldDate) fldTarikh,
                     fldOrganId,
                   ISNULL( (SELECT TOP(1) tblSodoorFish.fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldid AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldid) ),0) AS FishId
                   ,ISNULL((SELECT TOP(1) tblRequestTaghsit_Takhfif.fldid FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 
                   AND  tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldId) ORDER BY tblRequestTaghsit_Takhfif.fldId DESC),0)AS ReplyId
                      ,isnull((SELECT SUM((fldMaliyatValue+(fldAsliValue*fldTedad)+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,Drd.tblElamAvarez.fldDesc
FROM     Drd.tblElamAvarez)y
WHERE y.fldMablaghTakhfif=@value AND y.fldAshakhasID=@AshkhasId


if (@fieldname=N'SharhDesc')
SELECT   TOP(@h)fldId, fldType, 
  fldTarikh,fldOrganId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli-fldMablaghTakhfif),0) AS fldMablaghGHabelPardakht
,fldNameOrgan,SharhDesc,Noe,y.FishId,y.ReplyId,fldDesc
 FROM
 (SELECT fldId, fldAshakhasID, fldType, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM drd.tblCompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
             CASE WHEN EXISTS (SELECT * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId= tblSodoorFish.fldid)) THEN '1' ELSE '0' END AS FishSaderShode
			,CASE WHEN EXISTS (select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
))THEN N'1' ELSE N'0' END IsTaghsit
		   , dbo.Fn_AssembelyMiladiToShamsi(Drd.tblElamAvarez.fldDate) fldTarikh,
                     fldOrganId,
                   ISNULL( (SELECT TOP(1) tblSodoorFish.fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldid AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldid) ),0) AS FishId
                   ,ISNULL((SELECT TOP(1) tblRequestTaghsit_Takhfif.fldid FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 
                   AND  tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldId) ORDER BY tblRequestTaghsit_Takhfif.fldId DESC),0)AS ReplyId
                      ,isnull((SELECT SUM((fldMaliyatValue+(fldAsliValue*fldTedad)+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,Drd.tblElamAvarez.fldDesc
FROM     Drd.tblElamAvarez)y
WHERE y.SharhDesc=@value AND y.fldAshakhasID=@AshkhasId

if (@fieldname=N'fldMablaghGHabelPardakht')
SELECT  TOP(@h)* FROM(SELECT fldId, fldType, 
  fldTarikh,fldOrganId,fldMablaghKoli,fldMablaghTakhfif,ISNULL((fldMablaghKoli-fldMablaghTakhfif),0) as fldMablaghGHabelPardakht
,fldNameOrgan,SharhDesc,Noe,y.FishId,y.ReplyId,fldDesc
 FROM
 (SELECT fldId, fldAshakhasID, fldType, CASE WHEN fldIsExternal = 0 THEN N'داخلی' WHEN fldIsExternal = 1 THEN N'متفرقه' WHEN fldtype=1 AND fldIsExternal IS null then N'خارجی'+'( '+(SELECT fldtitle FROM drd.tblCompany WHERE fldKarbarId=Drd.tblElamAvarez.fldUserId)+' )' ELSE N'' END AS Noe, 
             CASE WHEN EXISTS (SELECT * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId= tblSodoorFish.fldid)) THEN '1' ELSE '0' END AS FishSaderShode
			,CASE WHEN EXISTS (select drd.tblReplyTaghsit.fldid from drd.tblReplyTaghsit where drd.tblReplyTaghsit.fldStatusId=(
select drd.tblStatusTaghsit_Takhfif.fldid from drd.tblStatusTaghsit_Takhfif where drd.tblStatusTaghsit_Takhfif.fldRequestId=(
select top(1)drd.tblRequestTaghsit_Takhfif.fldId from drd.tblRequestTaghsit_Takhfif where drd.tblRequestTaghsit_Takhfif.fldElamAvarezId=Drd.tblElamAvarez.fldid and drd.tblRequestTaghsit_Takhfif.fldId 
not in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal 
where drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid) order by drd.tblRequestTaghsit_Takhfif.fldid desc
) and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
))THEN N'1' ELSE N'0' END IsTaghsit
		   , dbo.Fn_AssembelyMiladiToShamsi(Drd.tblElamAvarez.fldDate) fldTarikh,
                     fldOrganId,
                   ISNULL( (SELECT TOP(1) tblSodoorFish.fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=Drd.tblElamAvarez.fldid AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldid) ),0) AS FishId
                   ,ISNULL((SELECT TOP(1) tblRequestTaghsit_Takhfif.fldid FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId AND fldRequestType=1 
                   AND  tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldId) ORDER BY tblRequestTaghsit_Takhfif.fldId DESC),0)AS ReplyId
                      ,isnull((SELECT SUM((fldMaliyatValue+(fldAsliValue*fldTedad)+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblElamAvarez.fldId),0) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=Drd.tblElamAvarez.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(fldid) AS SharhDesc,Drd.tblElamAvarez.fldDesc
FROM     Drd.tblElamAvarez)y where y.fldAshakhasID=@AshkhasId)b
WHERE b.fldMablaghGHabelPardakht=@value 
COMMIT
GO
