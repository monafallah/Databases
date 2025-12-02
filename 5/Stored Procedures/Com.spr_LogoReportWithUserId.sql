SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_LogoReportWithUserId](@organId INT)
AS
SELECT     tblFile.fldId, tblFile.fldImage,[Com].[fn_stringDecode](tblOrganization.fldName)AS fldName, tblCity.fldName AS fldCityName, tblState.fldName AS fldStateName
FROM         tblFile INNER JOIN
                      tblOrganization ON tblFile.fldId = tblOrganization.fldFileId INNER JOIN
                   
                      tblCity ON tblOrganization.fldCityId = tblCity.fldId INNER JOIN
                      tblState ON tblCity.fldStateId = tblState.fldId
                      WHERE tblOrganization.fldid=@organId
GO
