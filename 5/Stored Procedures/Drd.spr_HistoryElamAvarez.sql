SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_HistoryElamAvarez](@ElamAvarezId INT)
as
DECLARE @temp TABLE (id INT,Tarikh NVARCHAR(10),fldTime NVARCHAR(8),fldTitle NVARCHAR(50))
INSERT INTO @temp
        ( id, Tarikh, fldTime, fldTitle )
SELECT fldId,dbo.Fn_AssembelyMiladiToShamsi(fldDate),CAST(CAST(fldDate AS TIME(0)) AS NVARCHAR(8)),N'ثبت شده' FROM Drd.tblElamAvarez WHERE fldId=@ElamAvarezId
INSERT INTO @temp
        ( id, Tarikh, fldTime, fldTitle )
SELECT fldId,dbo.Fn_AssembelyMiladiToShamsi(fldDate),CAST(CAST(fldDate AS TIME(0)) AS NVARCHAR(8)),N'صدور فیش' FROM Drd.tblSodoorFish WHERE fldElamAvarezId=@ElamAvarezId
INSERT INTO @temp
        ( id, Tarikh, fldTime, fldTitle )
SELECT fldId,dbo.Fn_AssembelyMiladiToShamsi(fldDate),CAST(CAST(fldDate AS TIME(0)) AS NVARCHAR(8)),N'ابطال فیش' FROM Drd.tblEbtal WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=@ElamAvarezId)
INSERT INTO @temp
        ( id, Tarikh, fldTime, fldTitle )
SELECT fldId,dbo.Fn_AssembelyMiladiToShamsi(fldDate),CAST(CAST(fldDate AS TIME(0)) AS NVARCHAR(8)),N'درخواست تخفیف و تقسیط' FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=@ElamAvarezId
INSERT INTO @temp
        ( id, Tarikh, fldTime, fldTitle )
SELECT fldId,dbo.Fn_AssembelyMiladiToShamsi(fldDate),CAST(CAST(fldDate AS TIME(0)) AS NVARCHAR(8)),N'ابطال درخواست تخفیف' FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=@ElamAvarezId AND fldRequestType=1)
INSERT INTO @temp
        ( id, Tarikh, fldTime, fldTitle )
SELECT fldId,dbo.Fn_AssembelyMiladiToShamsi(fldDate),CAST(CAST(fldDate AS TIME(0)) AS NVARCHAR(8)),N'ابطال درخواست تقسیط' FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=@ElamAvarezId AND fldRequestType=2)
/*INSERT INTO @temp
        ( id, Tarikh, fldTime, fldTitle )
SELECT fldId,dbo.Fn_AssembelyMiladiToShamsi(fldDate),CAST(CAST(fldDate AS TIME(0)) AS NVARCHAR(8)),N'پاسخ موافقت به درخواست تقسیط' FROM Drd.tblReplyTaghsit WHERE fldRequestId IN(SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=@ElamAvarezId) AND fldTypeMojavez=1
INSERT INTO @temp
        ( id, Tarikh, fldTime, fldTitle )
SELECT fldId,dbo.Fn_AssembelyMiladiToShamsi(fldDate),CAST(CAST(fldDate AS TIME(0)) AS NVARCHAR(8)),N'پاسخ عدم موافقت به درخواست تقسیط' FROM Drd.tblReplyTaghsit WHERE fldRequestId IN(SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=@ElamAvarezId) AND fldTypeMojavez=2*/
/*INSERT INTO @temp
        ( id, Tarikh, fldTime, fldTitle )
SELECT fldId,dbo.Fn_AssembelyMiladiToShamsi(fldDate),CAST(CAST(fldDate AS TIME(0)) AS NVARCHAR(8)),N'پاسخ موافقت به درخواست تخفیف' FROM Drd.tblReplyTakhfif WHERE fldRequestId IN(SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=@ElamAvarezId) AND fldTypeMojavez=1
INSERT INTO @temp
        ( id, Tarikh, fldTime, fldTitle )
SELECT fldId,dbo.Fn_AssembelyMiladiToShamsi(fldDate),CAST(CAST(fldDate AS TIME(0)) AS NVARCHAR(8)),N'پاسخ عدم موافقت به درخواست تخفیف' FROM Drd.tblReplyTakhfif WHERE fldRequestId IN(SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=@ElamAvarezId) AND fldTypeMojavez=2
*/
SELECT * FROM @temp ORDER BY Tarikh,fldTime 
GO
