SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_SelectFlagKarKard_Mohasebe](@Sal SMALLINT,@mah TINYINT,@organId INT)
as
DECLARE @r NVARCHAR(6)
--,@Sal SMALLINT=1404,@mah TINYINT=7,@organId INT=1

/*SET @r=CASE WHEN LEN (@mah)=1 THEN CAST(@Sal AS NVARCHAR(4))+'0'+CAST(@mah AS NVARCHAR(2)) ELSE CAST(@Sal AS NVARCHAR(4))+CAST(@mah AS NVARCHAR(2)) END 
IF EXISTS(SELECT     *
FROM         Pay.tblKarKardeMahane WHERE CASE WHEN LEN(fldMah)=1 then cast(CAST(fldYear AS NVARCHAR(4))+('0'+CAST(fldMah AS NVARCHAR(2)))AS bigint) ELSE  cast(CAST(fldYear AS NVARCHAR(4))+(CAST(fldMah AS NVARCHAR(2)))AS bigint) END<@r AND fldFlag=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId) 
AND EXISTS(SELECT     *
FROM         Pay.tblMohasebat WHERE CASE WHEN LEN(fldMonth)=1 then cast(CAST(fldYear AS NVARCHAR(4))+('0'+CAST(fldMonth AS NVARCHAR(2)))AS bigint) ELSE  cast(CAST(fldYear AS NVARCHAR(4))+(CAST(fldMonth AS NVARCHAR(2)))AS bigint) END<@r AND fldFlag=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId) 

SELECT  CAST(  1 AS bit)fldFlag,fldMah,fldYear
FROM         Pay.tblKarKardeMahane WHERE CASE WHEN LEN(fldMah)=1 then cast(CAST(fldYear AS NVARCHAR(4))+('0'+CAST(fldMah AS NVARCHAR(2)))AS bigint) ELSE  cast(CAST(fldYear AS NVARCHAR(4))+(CAST(fldMah AS NVARCHAR(2)))AS bigint) END<@r AND fldFlag=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

ELSE
SELECT  CAST(  0 AS bit)fldFlag,cast(0 as tinyint) fldMah,cast(0 as smallint) fldYear
--FROM         Pay.tblKarKardeMahane WHERE CASE WHEN LEN(fldMah)=1 then cast(CAST(fldYear AS NVARCHAR(4))+('0'+CAST(fldMah AS NVARCHAR(2)))AS bigint) ELSE  cast(CAST(fldYear AS NVARCHAR(4))+(CAST(fldMah AS NVARCHAR(2)))AS bigint) END<=@r AND fldFlag=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
*/
DECLARE @r1 int=0

SET @r1=@Sal*100+@mah
IF EXISTS(SELECT     *
FROM         Pay.tblKarKardeMahane WHERE fldYear*100+@mah <@r1 AND fldFlag=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId) 
AND EXISTS(SELECT     *
FROM         Pay.tblMohasebat WHERE   fldYear*100+@mah  <@r1 AND fldFlag=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId) 

SELECT  CAST(  1 AS bit)fldFlag,fldMah,fldYear
FROM         Pay.tblKarKardeMahane WHERE   fldYear*100+@mah <@r1 AND fldFlag=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

ELSE
SELECT  CAST(  0 AS bit)fldFlag,cast(0 as tinyint) fldMah,cast(0 as smallint) fldYear
GO
