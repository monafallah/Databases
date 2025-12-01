SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblAddressSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT     top(@h)  tblAddress.fldId,tblAddress.fldLatitude,tblAddress.fldLongitude, Cnt.tblAddress.fldShahrId, Cnt.tblAddress.fldContactId, tblShahr.fldCountyId, tblCounty.fldStateId
FROM        Cnt.tblAddress INNER JOIN
                  tblShahr ON Cnt.tblAddress.fldShahrId = tblShahr.fldId INNER JOIN
                  tblCounty ON tblShahr.fldCountyId = tblCounty.fldId
	WHERE  tblAddress.fldId=@Value

	if (@FieldName='fldContactId')
SELECT     top(@h)  tblAddress.fldId,tblAddress.fldLatitude,tblAddress.fldLongitude, Cnt.tblAddress.fldShahrId, Cnt.tblAddress.fldContactId, tblShahr.fldCountyId, tblCounty.fldStateId
FROM        Cnt.tblAddress INNER JOIN
                  tblShahr ON Cnt.tblAddress.fldShahrId = tblShahr.fldId INNER JOIN
                  tblCounty ON tblShahr.fldCountyId = tblCounty.fldId
	WHERE  fldContactId=@Value

	if (@FieldName='')
	SELECT     top(@h)  tblAddress.fldId,tblAddress.fldLatitude,tblAddress.fldLongitude, Cnt.tblAddress.fldShahrId, Cnt.tblAddress.fldContactId, tblShahr.fldCountyId, tblCounty.fldStateId
FROM        Cnt.tblAddress INNER JOIN
                  tblShahr ON Cnt.tblAddress.fldShahrId = tblShahr.fldId INNER JOIN
                  tblCounty ON tblShahr.fldCountyId = tblCounty.fldId

	
	COMMIT
GO
