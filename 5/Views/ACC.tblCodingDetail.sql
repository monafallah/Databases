SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ACC].[tblCodingDetail] AS
SELECT fldid,fldTitle
FROM [ACC].[tblCoding_Details]
WHERE fldHeaderCodId =5;
GO
