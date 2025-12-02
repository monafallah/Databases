SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_AccSigners](@fldModule_OrganId INT,@Tarikh NVARCHAR(10),@ReportId INT)
AS 
DECLARE @MasuolinId INT
SELECT TOP(1) @MasuolinId=fldId FROM Com.tblMasuolin WHERE fldTarikhEjra<=@Tarikh AND fldModule_OrganId=@fldModule_OrganId ORDER BY fldTarikhEjra desc

DECLARE @t TABLE (Post NVARCHAR(100),SignerName NVARCHAR(150),orderId INT)
INSERT INTO @t
        ( Post, SignerName, orderId )

SELECT (SELECT     tblOrganizationalPosts.fldTitle
FROM         com.tblMasuolin_Detail INNER JOIN
                       com.tblOrganizationalPosts ON tblMasuolin_Detail.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                       com.tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId                     
                      WHERE tblMasuolin_Detail.fldid IN (SELECT fldMasuolin_DetailId FROM Com.tblZirListHa WHERE fldReportId=@ReportId) AND fldOrderId=1 AND fldMasuolinId=@MasuolinId
                    ) ,(SELECT     tblEmployee.fldName+' '+ tblEmployee.fldFamily
FROM          com.tblMasuolin_Detail INNER JOIN
                       com.tblEmployee ON tblMasuolin_Detail.fldEmployId = tblEmployee.fldId
                      WHERE tblMasuolin_Detail.fldid IN (SELECT fldMasuolin_DetailId FROM Com.tblZirListHa WHERE fldReportId=@ReportId) AND fldOrderId=1 AND fldMasuolinId=@MasuolinId
                    ),1
 
INSERT INTO @t
        ( Post, SignerName, orderId )

SELECT (SELECT     tblOrganizationalPosts.fldTitle
FROM          com.tblMasuolin_Detail INNER JOIN
                       com.tblOrganizationalPosts ON tblMasuolin_Detail.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                       com.tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId                     
                      WHERE tblMasuolin_Detail.fldid IN (SELECT fldMasuolin_DetailId FROM Com.tblZirListHa WHERE fldReportId=@ReportId) AND fldOrderId=2 AND fldMasuolinId=@MasuolinId
                    ) ,(SELECT     tblEmployee.fldName+' '+ tblEmployee.fldFamily
FROM         com. tblMasuolin_Detail INNER JOIN
                       com.tblEmployee ON tblMasuolin_Detail.fldEmployId = tblEmployee.fldId
                      WHERE tblMasuolin_Detail.fldid IN (SELECT fldMasuolin_DetailId FROM Com.tblZirListHa WHERE fldReportId=@ReportId) AND fldOrderId=2 AND fldMasuolinId=@MasuolinId
                    ),2

INSERT INTO @t
        ( Post, SignerName, orderId )

SELECT (SELECT     tblOrganizationalPosts.fldTitle
FROM          com.tblMasuolin_Detail INNER JOIN
                     com. tblOrganizationalPosts ON tblMasuolin_Detail.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                      com.tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId                     
                      WHERE tblMasuolin_Detail.fldid IN (SELECT fldMasuolin_DetailId FROM Com.tblZirListHa WHERE fldReportId=@ReportId) AND fldOrderId=3 AND fldMasuolinId=@MasuolinId
                    ) ,(SELECT     tblEmployee.fldName+' '+ tblEmployee.fldFamily
FROM         com.tblMasuolin_Detail INNER JOIN
                      com.tblEmployee ON tblMasuolin_Detail.fldEmployId = tblEmployee.fldId
                      WHERE tblMasuolin_Detail.fldid IN (SELECT fldMasuolin_DetailId FROM Com.tblZirListHa WHERE fldReportId=@ReportId) AND fldOrderId=3 AND fldMasuolinId=@MasuolinId
                    ),3

INSERT INTO @t
        ( Post, SignerName, orderId )

SELECT (SELECT     tblOrganizationalPosts.fldTitle
FROM         com.tblMasuolin_Detail INNER JOIN
                     com. tblOrganizationalPosts ON tblMasuolin_Detail.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                     com. tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId                     
                      WHERE tblMasuolin_Detail.fldid IN (SELECT fldMasuolin_DetailId FROM Com.tblZirListHa WHERE fldReportId=@ReportId) AND fldOrderId=4 AND fldMasuolinId=@MasuolinId
                    ) ,(SELECT     tblEmployee.fldName+' '+ tblEmployee.fldFamily
FROM         com.tblMasuolin_Detail INNER JOIN
                     com. tblEmployee ON tblMasuolin_Detail.fldEmployId = tblEmployee.fldId
                      WHERE tblMasuolin_Detail.fldid IN (SELECT fldMasuolin_DetailId FROM Com.tblZirListHa WHERE fldReportId=@ReportId) AND fldOrderId=4 AND fldMasuolinId=@MasuolinId
                    ),4

INSERT INTO @t
        ( Post, SignerName, orderId )

SELECT (SELECT     tblOrganizationalPosts.fldTitle
FROM         com.tblMasuolin_Detail INNER JOIN
                    com.  tblOrganizationalPosts ON tblMasuolin_Detail.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                      com.tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId                     
                      WHERE tblMasuolin_Detail.fldid IN (SELECT fldMasuolin_DetailId FROM Com.tblZirListHa WHERE fldReportId=@ReportId) AND fldOrderId=5 AND fldMasuolinId=@MasuolinId
                    ) ,(SELECT     tblEmployee.fldName+' '+ tblEmployee.fldFamily
FROM         com.tblMasuolin_Detail INNER JOIN
                     com. tblEmployee ON tblMasuolin_Detail.fldEmployId = tblEmployee.fldId
                      WHERE tblMasuolin_Detail.fldid IN (SELECT fldMasuolin_DetailId FROM Com.tblZirListHa WHERE fldReportId=@ReportId) AND fldOrderId=5 AND fldMasuolinId=@MasuolinId
                    ),5

DELETE FROM @t WHERE Post IS NULL AND SignerName IS NULL

SELECT * FROM @t
ORDER BY orderId desc
GO
