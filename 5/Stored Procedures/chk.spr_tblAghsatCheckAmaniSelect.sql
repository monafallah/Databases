SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [chk].[spr_tblAghsatCheckAmaniSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganId int,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
SELECT        TOP (@h) chk.tblAghsatCheckAmani.fldId, chk.tblAghsatCheckAmani.fldMablagh, chk.tblAghsatCheckAmani.fldNobat, fldTarikh ,fldOrganId ,
					ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),1)as fldvaziat,
                      ISNULL( ( SELECT        TOP (1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده'  WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده' 
								 when 5 then  N'عودت داده شده' end
								 FROM            chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
                         chk.tblAghsatCheckAmani.fldIdCheckHayeVarede, chk.tblAghsatCheckAmani.fldUserId, chk.tblAghsatCheckAmani.fldDesc, chk.tblAghsatCheckAmani.fldDate,
                         ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'') fldTarikhVaziat
FROM            chk.tblAghsatCheckAmani 
	WHERE   chk.tblAghsatCheckAmani.fldId = @Value and fldOrganId =@fldOrganId
	
	if (@fieldname=N'fldIdCheckHayeVarede')
SELECT        TOP (@h) chk.tblAghsatCheckAmani.fldId, chk.tblAghsatCheckAmani.fldMablagh, chk.tblAghsatCheckAmani.fldNobat, fldTarikh ,fldOrganId ,
					ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),1)as fldvaziat,
                      ISNULL( ( SELECT        TOP (1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده'  WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده' 
								 when 5 then  N'عودت داده شده' end
								 FROM            chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
                         chk.tblAghsatCheckAmani.fldIdCheckHayeVarede, chk.tblAghsatCheckAmani.fldUserId, chk.tblAghsatCheckAmani.fldDesc, chk.tblAghsatCheckAmani.fldDate,
                         ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'') fldTarikhVaziat
FROM            chk.tblAghsatCheckAmani 
	WHERE  fldIdCheckHayeVarede = @Value and fldOrganId =@fldOrganId
	
	if (@fieldname=N'fldChekHayeVaredeId_CheckDelete')
SELECT        TOP (@h) chk.tblAghsatCheckAmani.fldId, chk.tblAghsatCheckAmani.fldMablagh, chk.tblAghsatCheckAmani.fldNobat, fldTarikh ,fldOrganId ,
					ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),1)as fldvaziat,
                      ISNULL( ( SELECT        TOP (1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده'  WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده' 
								 when 5 then  N'عودت داده شده' end
								 FROM            chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
                         chk.tblAghsatCheckAmani.fldIdCheckHayeVarede, chk.tblAghsatCheckAmani.fldUserId, chk.tblAghsatCheckAmani.fldDesc, chk.tblAghsatCheckAmani.fldDate,
                         ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'') fldTarikhVaziat
FROM            chk.tblAghsatCheckAmani  
	WHERE  fldIdCheckHayeVarede = @Value 

		if (@fieldname=N'fldTarikhVaziat')
select  TOP (@h)* from(SELECT        chk.tblAghsatCheckAmani.fldId, chk.tblAghsatCheckAmani.fldMablagh, chk.tblAghsatCheckAmani.fldNobat, fldTarikh ,fldOrganId ,
					ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),1)as fldvaziat,
                      ISNULL( ( SELECT        TOP (1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده'  WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده' 
								 when 5 then  N'عودت داده شده' end
								 FROM            chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
                         chk.tblAghsatCheckAmani.fldIdCheckHayeVarede, chk.tblAghsatCheckAmani.fldUserId, chk.tblAghsatCheckAmani.fldDesc, chk.tblAghsatCheckAmani.fldDate,
                         ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'') fldTarikhVaziat
FROM            chk.tblAghsatCheckAmani )temp
	WHERE  fldTarikhVaziat = @Value and fldOrganId =@fldOrganId

	if (@fieldname=N'fldDesc')
SELECT        TOP (@h) chk.tblAghsatCheckAmani.fldId, chk.tblAghsatCheckAmani.fldMablagh, chk.tblAghsatCheckAmani.fldNobat, fldTarikh,fldOrganId ,
					ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),1)as fldvaziat,
                      ISNULL( ( SELECT TOP(1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'وصول شده' WHEN 2 THEN N'برگشت خورده' WHEN 3 THEN N'عودت داده شده' WHEN 4 THEN N'در انتظار وصول' END FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
                         chk.tblAghsatCheckAmani.fldIdCheckHayeVarede, chk.tblAghsatCheckAmani.fldUserId, chk.tblAghsatCheckAmani.fldDesc, chk.tblAghsatCheckAmani.fldDate,
                         ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'') fldTarikhVaziat
FROM            chk.tblAghsatCheckAmani 
	WHERE chk.tblAghsatCheckAmani.fldDesc like  @Value and fldOrganId =@fldOrganId
	
	if (@fieldname=N'fldMablagh')
SELECT        TOP (@h) chk.tblAghsatCheckAmani.fldId, chk.tblAghsatCheckAmani.fldMablagh, chk.tblAghsatCheckAmani.fldNobat, fldTarikh ,fldOrganId ,
					ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),1)as fldvaziat,
                      ISNULL( ( SELECT        TOP (1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده'  WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده' 
								 when 5 then  N'عودت داده شده' end
								 FROM            chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
                         chk.tblAghsatCheckAmani.fldIdCheckHayeVarede, chk.tblAghsatCheckAmani.fldUserId, chk.tblAghsatCheckAmani.fldDesc, chk.tblAghsatCheckAmani.fldDate,
                         ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'') fldTarikhVaziat
FROM            chk.tblAghsatCheckAmani  
	WHERE fldMablagh like  @Value and fldOrganId =@fldOrganId
	
	if (@fieldname=N'fldTarikh')
SELECT        TOP (@h) chk.tblAghsatCheckAmani.fldId, chk.tblAghsatCheckAmani.fldMablagh, chk.tblAghsatCheckAmani.fldNobat, fldTarikh ,fldOrganId ,
					ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),1)as fldvaziat,
                      ISNULL( ( SELECT        TOP (1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده'  WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده' 
								 when 5 then  N'عودت داده شده' end
								 FROM            chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
                         chk.tblAghsatCheckAmani.fldIdCheckHayeVarede, chk.tblAghsatCheckAmani.fldUserId, chk.tblAghsatCheckAmani.fldDesc, chk.tblAghsatCheckAmani.fldDate,
                         ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'') fldTarikhVaziat
FROM            chk.tblAghsatCheckAmani 
	WHERE  chk.tblAghsatCheckAmani.fldTarikh  like  @Value and fldOrganId =@fldOrganId
	

	
	if (@fieldname=N'fldNobat')
SELECT        TOP (@h) chk.tblAghsatCheckAmani.fldId, chk.tblAghsatCheckAmani.fldMablagh, chk.tblAghsatCheckAmani.fldNobat, fldTarikh ,fldOrganId ,
					ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),1)as fldvaziat,
                      ISNULL( ( SELECT        TOP (1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده'  WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده' 
								 when 5 then  N'عودت داده شده' end
								 FROM            chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
                         chk.tblAghsatCheckAmani.fldIdCheckHayeVarede, chk.tblAghsatCheckAmani.fldUserId, chk.tblAghsatCheckAmani.fldDesc, chk.tblAghsatCheckAmani.fldDate,
                         ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'') fldTarikhVaziat
FROM            chk.tblAghsatCheckAmani 
	WHERE fldNobat like  @Value and fldOrganId =@fldOrganId

	if (@fieldname=N'')
SELECT        TOP (@h) chk.tblAghsatCheckAmani.fldId, chk.tblAghsatCheckAmani.fldMablagh, chk.tblAghsatCheckAmani.fldNobat, fldTarikh ,fldOrganId ,
					ISNULL( ( SELECT TOP(1) fldvaziat FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),1)as fldvaziat,
                      ISNULL( ( SELECT        TOP (1) CASE chk.tblCheckStatus.fldvaziat WHEN 1 THEN N'در انتظار وصول'  WHEN 2 THEN N'وصول شده'  WHEN 3 THEN N'برگشت خورده' WHEN 4 THEN N'حقوقی شده' 
								 when 5 then  N'عودت داده شده' end
								 FROM            chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'در انتظار وصول') AS NameVaziat, 
                         chk.tblAghsatCheckAmani.fldIdCheckHayeVarede, chk.tblAghsatCheckAmani.fldUserId, chk.tblAghsatCheckAmani.fldDesc, chk.tblAghsatCheckAmani.fldDate,
                         ISNULL( ( SELECT TOP(1) tblCheckStatus.fldTarikh FROM chk.tblCheckStatus
                       WHERE fldAghsatId=chk.tblAghsatCheckAmani.fldId ORDER BY fldId desc),N'') fldTarikhVaziat
FROM            chk.tblAghsatCheckAmani 

	COMMIT
GO
