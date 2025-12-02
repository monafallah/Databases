SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblCodeDaramadAramestanSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) a.[fldId], a.[fldCodeDaramadId], a.[fldUserId], a.[fldIP], a.[fldDesc], a.[fldDate] ,a.fldorganid,c.fldDaramadTitle
	,fldShomareHesab,fldMashmooleArzesheAfzoode,fldMashmooleKarmozd,fldNameVahed,fldDaramadCode
	FROM   [Dead].[tblCodeDaramadAramestan] a inner join drd.tblCodhayeDaramd c on 
	fldCodeDaramadId=c.fldid inner join drd.tblShomareHesabCodeDaramad sh on sh.fldCodeDaramadId=c.fldid
	and sh.fldOrganid=a.fldorganId
	inner join com.tblShomareHesabeOmoomi s on s.fldid=sh.fldShomareHesadId
	inner join com.tblMeasureUnit m  on m.fldid=c.fldUnitId
	WHERE  a.fldId=@Value and a.fldorganid=@OrganId
		group by   a.[fldId], a.[fldCodeDaramadId], a.[fldUserId], a.[fldIP], a.[fldDesc], a.[fldDate] ,a.fldorganid,c.fldDaramadTitle
	,fldShomareHesab,fldMashmooleArzesheAfzoode,fldMashmooleKarmozd,fldNameVahed,fldDaramadCode

	if (@FieldName='fldDesc')
		SELECT top(@h) a.[fldId], a.[fldCodeDaramadId], a.[fldUserId], a.[fldIP], a.[fldDesc], a.[fldDate] ,a.fldorganid,c.fldDaramadTitle
	,fldShomareHesab,fldMashmooleArzesheAfzoode,fldMashmooleKarmozd,fldNameVahed,fldDaramadCode
	FROM   [Dead].[tblCodeDaramadAramestan] a inner join drd.tblCodhayeDaramd c on 
	fldCodeDaramadId=c.fldid inner join drd.tblShomareHesabCodeDaramad sh on sh.fldCodeDaramadId=c.fldid
	and sh.fldOrganid=a.fldorganId
	inner join com.tblShomareHesabeOmoomi s on s.fldid=sh.fldShomareHesadId
	inner join com.tblMeasureUnit m  on m.fldid=c.fldUnitId
	WHERE  a.fldDesc like @Value and a.fldorganid=@OrganId
		group by   a.[fldId], a.[fldCodeDaramadId], a.[fldUserId], a.[fldIP], a.[fldDesc], a.[fldDate] ,a.fldorganid,c.fldDaramadTitle
	,fldShomareHesab,fldMashmooleArzesheAfzoode,fldMashmooleKarmozd,fldNameVahed,fldDaramadCode

	if (@FieldName='')
			SELECT top(@h) a.[fldId], a.[fldCodeDaramadId], a.[fldUserId], a.[fldIP], a.[fldDesc], a.[fldDate] ,a.fldorganid,c.fldDaramadTitle
	,fldShomareHesab,fldMashmooleArzesheAfzoode,fldMashmooleKarmozd,fldNameVahed,fldDaramadCode
	FROM   [Dead].[tblCodeDaramadAramestan] a inner join drd.tblCodhayeDaramd c on 
	fldCodeDaramadId=c.fldid inner join drd.tblShomareHesabCodeDaramad sh on sh.fldCodeDaramadId=c.fldid
	and sh.fldOrganid=a.fldorganId
	inner join com.tblShomareHesabeOmoomi s on s.fldid=sh.fldShomareHesadId
	inner join com.tblMeasureUnit m  on m.fldid=c.fldUnitId
	where  a.fldorganid=@OrganId
		group by   a.[fldId], a.[fldCodeDaramadId], a.[fldUserId], a.[fldIP], a.[fldDesc], a.[fldDate] ,a.fldorganid,c.fldDaramadTitle
	,fldShomareHesab,fldMashmooleArzesheAfzoode,fldMashmooleKarmozd,fldNameVahed,fldDaramadCode

		if (@FieldName='fldOrganid')
	SELECT top(@h) a.[fldId], a.[fldCodeDaramadId], a.[fldUserId], a.[fldIP], a.[fldDesc], a.[fldDate] ,a.fldorganid,c.fldDaramadTitle
	,fldShomareHesab,fldMashmooleArzesheAfzoode,fldMashmooleKarmozd,fldNameVahed,fldDaramadCode
	FROM   [Dead].[tblCodeDaramadAramestan] a inner join drd.tblCodhayeDaramd c on 
	fldCodeDaramadId=c.fldid inner join drd.tblShomareHesabCodeDaramad sh on sh.fldCodeDaramadId=c.fldid
	and sh.fldOrganid=a.fldorganId
	inner join com.tblShomareHesabeOmoomi s on s.fldid=sh.fldShomareHesadId
	inner join com.tblMeasureUnit m  on m.fldid=c.fldUnitId
	where  a.fldorganid=@OrganId
		group by   a.[fldId], a.[fldCodeDaramadId], a.[fldUserId], a.[fldIP], a.[fldDesc], a.[fldDate] ,a.fldorganid,c.fldDaramadTitle
	,fldShomareHesab,fldMashmooleArzesheAfzoode,fldMashmooleKarmozd,fldNameVahed,fldDaramadCode

	if (@FieldName='ExistsInOrgan')
	select  isnull(aramestan.fldid,0)[fldId],c.fldid fldCodeDaramadId,1 [fldUserId],''[fldIP], ''[fldDesc], getdate()[fldDate] ,@OrganId fldorganid,c.fldDaramadTitle
	,fldShomareHesab,c.fldMashmooleArzesheAfzoode,c.fldMashmooleKarmozd,fldNameVahed,c.fldDaramadCode
	 FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId 
					  outer apply (SELECT  top ( @h)[fldId], [fldCodeDaramadId], [fldUserId], [fldIP], [fldDesc], [fldDate] ,fldorganid
									FROM   [Dead].[tblCodeDaramadAramestan]
									where fldorganid=@OrganId and [fldCodeDaramadId]=c.fldid)aramestan
									   WHERE  tblShomareHesabCodeDaramad.fldorganId = @OrganId	AND  p.fldDaramadId IS NULL AND tblShomareHesabCodeDaramad.fldStatus = 1 

	COMMIT
GO
