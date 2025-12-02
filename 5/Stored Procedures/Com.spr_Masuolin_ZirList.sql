SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC  [Com].[spr_Masuolin_ZirList]
 @headerId INT
AS 
BEGIN TRAN
DECLARE @ModuleId INT,@Module_OrganId  int
declare @temp TABLE(id INT,Orderid int)

SELECT @Module_OrganId=fldModule_OrganId FROM Com.tblMasuolin WHERE fldId=@headerId
select @ModuleId=fldModuleId from com.tblModule_Organ where fldId=@Module_OrganId
INSERT @temp
SELECT fldId,fldOrderId FROM Com.tblMasuolin_Detail WHERE fldMasuolinId=@headerId

SELECT     fldid,fldTitle,fldMasirReport,
CAST((SELECT COUNT(*) FROM Com.tblZirListHa WHERE fldMasuolin_DetailId
 IN(SELECT id FROM @temp AS p WHERE Orderid=1)AND fldReportId=tblReports.fldId) AS BIT)AS C1,
CAST((SELECT COUNT(*) FROM Com.tblZirListHa WHERE fldMasuolin_DetailId
 IN(SELECT id FROM @temp AS p WHERE Orderid=2)AND fldReportId=tblReports.fldId) AS BIT)AS C2,
 CAST((SELECT COUNT(*) FROM Com.tblZirListHa WHERE fldMasuolin_DetailId
 IN(SELECT id FROM @temp AS p WHERE Orderid=3)AND fldReportId=tblReports.fldId) AS BIT)as C3,
 CAST((SELECT COUNT(*) FROM Com.tblZirListHa WHERE fldMasuolin_DetailId
 IN(SELECT id FROM @temp AS p WHERE Orderid=4)AND fldReportId=tblReports.fldId) AS BIT)AS C4,
 CAST((SELECT COUNT(*) FROM Com.tblZirListHa WHERE fldMasuolin_DetailId
 IN(SELECT id FROM @temp AS p WHERE Orderid=5)AND fldReportId=tblReports.fldId) AS BIT)AS C5
FROM         com.tblReports
WHERE fldModuleId=@ModuleId
commit
GO
