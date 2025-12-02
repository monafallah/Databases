SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_GetNameOrganForFormul]
AS
BEGIN
SELECT     tblOrganization.fldId,[Com].[fn_stringDecode](tblOrganization.fldName) AS fldName
FROM         tblModule_Organ INNER JOIN
                      tblOrganization ON tblModule_Organ.fldOrganId = tblOrganization.fldId
WHERE fldModuleId IN (1,2)
GROUP BY tblOrganization.fldId,fldName
end
GO
