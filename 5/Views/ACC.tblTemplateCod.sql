SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ACC].[tblTemplateCod] AS
SELECT fldid,fldName,fldItemId
FROM [ACC].[tblTemplateCoding]
WHERE fldTempNameId = 3;
GO
