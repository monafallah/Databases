SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_SelectNameKarbarRpt](@userId INT,@OrganId int)
AS 
SELECT fldname+' '+e.fldFamily AS fldNameKarbar,organ.fldLogo,organ.fldnameOrgan ,Tarikh_Zaman.fldTarikh,Tarikh_Zaman.fldZaman
FROM com.tblUser u
 INNER JOIN com.tblEmployee e ON e.fldid=fldEmployId
 CROSS APPLY (
				SELECT Com.fn_stringDecode(o.fldName)fldnameOrgan,f.fldImage fldLogo FROM com.tblOrganization o
				INNER JOIN com.tblFile f ON f.fldid=fldFileId
				WHERE o.fldId=@OrganId
				)organ
 CROSS APPLY(
				SELECT fldTarikh,CAST(CAST(GETDATE() AS TIME(0)) AS VARCHAR(8))fldZaman FROM Com.tblDateDim
				WHERE fldDate=CAST(GETDATE() AS DATE)
				)Tarikh_Zaman
WHERE u.fldId=@userId
GO
