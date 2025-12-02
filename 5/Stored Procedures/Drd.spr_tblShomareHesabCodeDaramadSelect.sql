SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblShomareHesabCodeDaramadSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value1 NVARCHAR(50),
	@FiscalYear int,
	@h int
AS 
	BEGIN TRAN
	declare @year smallint,@organid int
	select @year=fldYear,@organid=fldOrganId from acc.tblFiscalYear where fldid=@fiscALYear
	
	/*	select   0 as  fldId, 0 fldShomareHesadId, -2 fldCodeDaramadId, 
                    0  fldOrganId, 0 fldUserId,'' fldDesc, 
                     getdate ()fldDate, ''fldShomareHesab,cast(0 as tinyint) fldShorooshenaseGhabz, 
                    '' fldFormolsaz,0 fldFormulKoliId, 
                     0 fldFormulMohasebatId, 
                     NULL fldReportFileId, '_'fldDaramadCode, Title fldDaramadTitle, cast(0 as bit) fldMashmooleArzesheAfzoode, 0 fldUnitId, 
                      cast(0 as bit)fldMashmooleKarmozd,''fldNameVahed, '' fldSharhCodDaramd,cast( 1 as bit) fldStatus
		from 
		drd.fn_TitleAvarezAcc('Maliyat',@year,@organId)*/

	if (@h=0) set @h=2147483647
	declare @Tarikh varchar(10)=dbo.Fn_AssembelyMiladiToShamsi( cast(getdate ()as date))
	if (@fieldname=N'fldId')
SELECT TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId,tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                  Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                  Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                  Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId, 
                  Drd.tblShomareHesabCodeDaramad.fldReportFileId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldDaramadTitle, 
                  tblCodhayeDaramd_1.fldMashmooleArzesheAfzoode, tblCodhayeDaramd_1.fldUnitId, tblCodhayeDaramd_1.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed, 
                  Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,fldAmuzeshParvaresh
FROM     Drd.tblShomareHesabCodeDaramad INNER JOIN
                  Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                  Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                  Com.tblMeasureUnit ON tblCodhayeDaramd_1.fldUnitId = Com.tblMeasureUnit.fldId AND tblCodhayeDaramd_1.fldUnitId = Com.tblMeasureUnit.fldId AND 
                  tblCodhayeDaramd_1.fldUnitId = Com.tblMeasureUnit.fldId
					 inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
					 outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1  order by s.fldid desc) Formul
					 
					  WHERE  (Drd.tblShomareHesabCodeDaramad.fldId = @Value) and @year between fldstartYear and fldEndYear
	
	if (@fieldname=N'fldId_HesabRayan')
SELECT TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId,tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                  Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                  Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                  Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId, 
                  Drd.tblShomareHesabCodeDaramad.fldReportFileId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldDaramadTitle, 
                  tblCodhayeDaramd_1.fldMashmooleArzesheAfzoode, tblCodhayeDaramd_1.fldUnitId, tblCodhayeDaramd_1.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed, 
                  Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,fldAmuzeshParvaresh
FROM     Drd.tblShomareHesabCodeDaramad INNER JOIN
                  Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                  Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                  Com.tblMeasureUnit ON tblCodhayeDaramd_1.fldUnitId = Com.tblMeasureUnit.fldId AND tblCodhayeDaramd_1.fldUnitId = Com.tblMeasureUnit.fldId AND 
                  tblCodhayeDaramd_1.fldUnitId = Com.tblMeasureUnit.fldId
					 inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
					 outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1  order by s.fldid desc) Formul
					 
					  WHERE  (Drd.tblShomareHesabCodeDaramad.fldId = @Value) --and @year between fldstartYear and fldEndYear
	


	if (@fieldname=N'fldOrganId')
		SELECT TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, Drd.tblCodhayeDaramd.fldDaramadCode, 
                      Drd.tblCodhayeDaramd.fldDaramadTitle, Drd.tblCodhayeDaramd.fldMashmooleArzesheAfzoode, Drd.tblCodhayeDaramd.fldUnitId, 
                      Drd.tblCodhayeDaramd.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  fldAmuzeshParvaresh
FROM    Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Com.tblMeasureUnit ON Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND 
                      Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId
					  	 inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
						 outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
	WHERE  fldOrganId = @Value and Drd.tblCodhayeDaramd.fldId<>1  and @year between fldstartYear and fldEndYear
	
	IF (@fieldname='PId')
	BEGIN
	IF(@Value=0)
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, Drd.tblCodhayeDaramd.fldDaramadCode, 
                      Drd.tblCodhayeDaramd.fldDaramadTitle, Drd.tblCodhayeDaramd.fldMashmooleArzesheAfzoode, Drd.tblCodhayeDaramd.fldUnitId, 
                      Drd.tblCodhayeDaramd.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus
					  ,fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Com.tblMeasureUnit ON Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND 
                      Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                       outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					   WHERE tblCodhayeDaramd.fldDaramadId=HIERARCHYID::GetRoot() AND fldorganId=@value1
					    and @year between fldstartYear and fldEndYear
   else                    
SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId INNER JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS p ON p.fldId = @value AND c.fldDaramadId.GetAncestor(1) = p.fldDaramadId
                      inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
					   outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  fldorganId=@value1  and @year between fldstartYear and fldEndYear
     END
                   
     	if (@fieldname=N'LastNode_Organ')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, 
                      Formul.fldFormulMohasebatId, 
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  	 inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                       outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1  order by s.fldid desc) Formul
					  WHERE  fldorganId = @Value	AND  p.fldDaramadId IS NULL AND tblShomareHesabCodeDaramad.fldStatus = 1 
					   and @year between fldstartYear and fldEndYear


	
	   	if (@fieldname=N'LastNode_fldNameVahed')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail   d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                      outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  fldNameVahed LIKE @value 	AND  p.fldDaramadId IS NULL  AND fldOrganId=@Value1 AND tblShomareHesabCodeDaramad.fldStatus = 1 
                       and @year between fldstartYear and fldEndYear
                      
             	if (@fieldname=N'LastNode_fldShorooshenaseGhabz')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                       outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  fldShorooshenaseGhabz LIKE @value 	AND  p.fldDaramadId IS NULL  AND fldOrganId=@Value1 AND tblShomareHesabCodeDaramad.fldStatus = 1 
                       and @year between fldstartYear and fldEndYear
                      
                      
             	if (@fieldname=N'LastNode_fldShomareHesab')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                       outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  fldShomareHesab LIKE @value 	AND  p.fldDaramadId IS NULL  AND fldOrganId=@Value1 AND tblShomareHesabCodeDaramad.fldStatus = 1 
                       and @year between fldstartYear and fldEndYear
                      
             	if (@fieldname=N'LastNode_fldDaramadTitle')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                       outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  c.fldDaramadTitle LIKE @value	AND  p.fldDaramadId IS NULL  AND fldOrganId=@Value1 AND tblShomareHesabCodeDaramad.fldStatus = 1 
                       and @year between fldstartYear and fldEndYear
                      
             	if (@fieldname=N'LastNode_fldDaramadCode')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                       outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  c.fldDaramadCode LIKE @value 	AND  p.fldDaramadId IS NULL     AND fldOrganId=@Value1        AND tblShomareHesabCodeDaramad.fldStatus = 1 
                        and @year between fldstartYear and fldEndYear           
                                  
                                  
                      
	
	
	if (@fieldname=N'fldShomareHesadId')
SELECT TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, Drd.tblCodhayeDaramd.fldDaramadCode, 
                      Drd.tblCodhayeDaramd.fldDaramadTitle, Drd.tblCodhayeDaramd.fldMashmooleArzesheAfzoode, Drd.tblCodhayeDaramd.fldUnitId, 
                      Drd.tblCodhayeDaramd.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  fldAmuzeshParvaresh
FROM     Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Com.tblMeasureUnit ON Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND 
                      Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
				       outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
	WHERE  Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = @Value  --and @year between fldstartYear and fldEndYear
	
	if (@fieldname=N'fldCodeDaramadId')
SELECT TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, Drd.tblCodhayeDaramd.fldDaramadCode, 
                      Drd.tblCodhayeDaramd.fldDaramadTitle, Drd.tblCodhayeDaramd.fldMashmooleArzesheAfzoode, Drd.tblCodhayeDaramd.fldUnitId, 
                      Drd.tblCodhayeDaramd.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  fldAmuzeshParvaresh
FROM     Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Com.tblMeasureUnit ON Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND 
                      Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
					 outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
	WHERE  Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = @Value  --and @year between fldstartYear and fldEndYear

		if (@fieldname=N'fldDesc')
SELECT TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                  Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                  Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                  Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                  Drd.tblShomareHesabCodeDaramad.fldReportFileId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldDaramadTitle, 
                  tblCodhayeDaramd_1.fldMashmooleArzesheAfzoode, tblCodhayeDaramd_1.fldUnitId, tblCodhayeDaramd_1.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed, 
                  Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,fldAmuzeshParvaresh
FROM     Drd.tblShomareHesabCodeDaramad INNER JOIN
                  Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                  Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                  Com.tblMeasureUnit ON tblCodhayeDaramd_1.fldUnitId = Com.tblMeasureUnit.fldId AND tblCodhayeDaramd_1.fldUnitId = Com.tblMeasureUnit.fldId AND 
                  tblCodhayeDaramd_1.fldUnitId = Com.tblMeasureUnit.fldId
				    inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                      outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  (Drd.tblShomareHesabCodeDaramad.fldDesc like @Value)  and @year between fldstartYear and fldEndYear


	if (@fieldname=N'fldDaramadCode')
SELECT TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                  Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                  Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                  Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                  Drd.tblShomareHesabCodeDaramad.fldReportFileId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldDaramadTitle, 
                  tblCodhayeDaramd_1.fldMashmooleArzesheAfzoode, tblCodhayeDaramd_1.fldUnitId, tblCodhayeDaramd_1.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed, 
                  Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,fldAmuzeshParvaresh
FROM     Drd.tblShomareHesabCodeDaramad INNER JOIN
                  Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                  Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                  Com.tblMeasureUnit ON tblCodhayeDaramd_1.fldUnitId = Com.tblMeasureUnit.fldId AND tblCodhayeDaramd_1.fldUnitId = Com.tblMeasureUnit.fldId AND 
                  tblCodhayeDaramd_1.fldUnitId = Com.tblMeasureUnit.fldId
				  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                      outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  Drd.tblShomareHesabCodeDaramad.fldOrganId = @Value1 and  tblCodhayeDaramd_1.fldDaramadCode like @Value
                      AND tblCodhayeDaramd_1.fldid<>1  and @year between fldstartYear and fldEndYear


if (@fieldname=N'fldShorooshenaseGhabz')
		SELECT TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, Drd.tblCodhayeDaramd.fldDaramadCode, 
                      Drd.tblCodhayeDaramd.fldDaramadTitle, Drd.tblCodhayeDaramd.fldMashmooleArzesheAfzoode, Drd.tblCodhayeDaramd.fldUnitId, 
                      Drd.tblCodhayeDaramd.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,fldAmuzeshParvaresh

FROM    Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Com.tblMeasureUnit ON Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND 
                      Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
						 outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
	WHERE  Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz LIKE @Value and Drd.tblCodhayeDaramd.fldId<>1 AND fldOrganId=@Value1
 and @year between fldstartYear and fldEndYear


	if (@fieldname=N'fldShomareHesab')
		SELECT TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, Drd.tblCodhayeDaramd.fldDaramadCode, 
                      Drd.tblCodhayeDaramd.fldDaramadTitle, Drd.tblCodhayeDaramd.fldMashmooleArzesheAfzoode, Drd.tblCodhayeDaramd.fldUnitId, 
                      Drd.tblCodhayeDaramd.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,fldAmuzeshParvaresh
FROM    Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Com.tblMeasureUnit ON Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND 
                      Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
					 outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
	WHERE  Com.tblShomareHesabeOmoomi.fldShomareHesab like @Value and Drd.tblCodhayeDaramd.fldId<>1 AND fldOrganId=@Value1
	 and @year between fldstartYear and fldEndYear


	if (@fieldname=N'fldNameVahed')
		SELECT TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, Drd.tblCodhayeDaramd.fldDaramadCode, 
                      Drd.tblCodhayeDaramd.fldDaramadTitle, Drd.tblCodhayeDaramd.fldMashmooleArzesheAfzoode, Drd.tblCodhayeDaramd.fldUnitId, 
                      Drd.tblCodhayeDaramd.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus
					  ,fldAmuzeshParvaresh
FROM    Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Com.tblMeasureUnit ON Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND 
                      Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
					 outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
	WHERE  Com.tblMeasureUnit.fldNameVahed like @Value and Drd.tblCodhayeDaramd.fldId<>1 AND fldOrganId=@Value1
	 and @year between fldstartYear and fldEndYear

		if (@fieldname=N'fldDaramadTitle')
		SELECT TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, Drd.tblCodhayeDaramd.fldDaramadCode, 
                      Drd.tblCodhayeDaramd.fldDaramadTitle, Drd.tblCodhayeDaramd.fldMashmooleArzesheAfzoode, Drd.tblCodhayeDaramd.fldUnitId, 
                      Drd.tblCodhayeDaramd.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus
					  ,fldAmuzeshParvaresh
FROM    Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Com.tblMeasureUnit ON Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND 
                      Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
					 outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
	WHERE  Drd.tblCodhayeDaramd.fldDaramadTitle like @Value and Drd.tblCodhayeDaramd.fldId<>1 AND fldOrganId=@Value1
	 and @year between fldstartYear and fldEndYear

	
	if (@fieldname=N'fldMashmooleArzesheAfzoode')
SELECT TOP (@h)Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, Drd.tblCodhayeDaramd.fldDaramadCode, 
                      Drd.tblCodhayeDaramd.fldDaramadTitle, Drd.tblCodhayeDaramd.fldMashmooleArzesheAfzoode, Drd.tblCodhayeDaramd.fldUnitId, 
                      Drd.tblCodhayeDaramd.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus
					  ,fldAmuzeshParvaresh
FROM    Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Com.tblMeasureUnit ON Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND 
                      Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
					 outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE fldMashmooleArzesheAfzoode=1  and @year between fldstartYear and fldEndYear

if (@fieldname=N'fldMashmooleKarmozd')
SELECT TOP (@h)Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, Drd.tblCodhayeDaramd.fldDaramadCode, 
                      Drd.tblCodhayeDaramd.fldDaramadTitle, Drd.tblCodhayeDaramd.fldMashmooleArzesheAfzoode, Drd.tblCodhayeDaramd.fldUnitId, 
                      Drd.tblCodhayeDaramd.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus
					  ,fldAmuzeshParvaresh
FROM    Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Com.tblMeasureUnit ON Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND 
                      Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
					  outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE fldMashmooleKarmozd=1  and @year between fldstartYear and fldEndYear

	if (@fieldname=N'')
SELECT TOP (@h)Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, Drd.tblCodhayeDaramd.fldDaramadCode, 
                      Drd.tblCodhayeDaramd.fldDaramadTitle, Drd.tblCodhayeDaramd.fldMashmooleArzesheAfzoode, Drd.tblCodhayeDaramd.fldUnitId, 
                      Drd.tblCodhayeDaramd.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus
					  ,fldAmuzeshParvaresh
FROM    Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId INNER JOIN
                      Com.tblMeasureUnit ON Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId AND 
                      Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
					  outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE   @year between fldstartYear and fldEndYear
----------------------------------------------------
if (@fieldname=N'LastNode_Organ_ArzesheAfzoode')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, 
                      Formul.fldFormulMohasebatId, 
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                       outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  fldorganId = @Value	AND  p.fldDaramadId IS NULL AND tblShomareHesabCodeDaramad.fldStatus = 1   --AND c.fldMashmooleArzesheAfzoode=1
					   and @year between fldstartYear and fldEndYear

	
	   	if (@fieldname=N'LastNode_fldNameVahed_ArzesheAfzoode')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                       outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  fldNameVahed LIKE @value 	AND  p.fldDaramadId IS NULL  AND fldOrganId=@Value1 AND tblShomareHesabCodeDaramad.fldStatus = 1 --AND c.fldMashmooleArzesheAfzoode=1
                       and @year between fldstartYear and fldEndYear
                      
             	if (@fieldname=N'LastNode_fldShorooshenaseGhabz_ArzesheAfzoode')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                      outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  fldShorooshenaseGhabz LIKE @value 	AND  p.fldDaramadId IS NULL  AND fldOrganId=@Value1 AND tblShomareHesabCodeDaramad.fldStatus = 1 --AND c.fldMashmooleArzesheAfzoode=1
                       and @year between fldstartYear and fldEndYear
                      
                      
             	if (@fieldname=N'LastNode_fldShomareHesab_ArzesheAfzoode')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                      outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  fldShomareHesab LIKE @value 	AND  p.fldDaramadId IS NULL  AND fldOrganId=@Value1 AND tblShomareHesabCodeDaramad.fldStatus = 1 --AND c.fldMashmooleArzesheAfzoode=1
                       and @year between fldstartYear and fldEndYear
                      
             	if (@fieldname=N'LastNode_fldDaramadTitle_ArzesheAfzoode')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                     outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  c.fldDaramadTitle LIKE @value	AND  p.fldDaramadId IS NULL  AND fldOrganId=@Value1 AND tblShomareHesabCodeDaramad.fldStatus = 1 --AND c.fldMashmooleArzesheAfzoode=1
                       and @year between fldstartYear and fldEndYear
                      
             	if (@fieldname=N'LastNode_fldDaramadCode_ArzesheAfzoode')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                      outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  c.fldDaramadCode LIKE @value 	AND  p.fldDaramadId IS NULL     AND fldOrganId=@Value1   AND tblShomareHesabCodeDaramad.fldStatus = 1 --AND c.fldMashmooleArzesheAfzoode=1
						 and @year between fldstartYear and fldEndYear
----------------------------------------------------

----------------------------------------------------
if (@fieldname=N'LastNode_Organ_Karmozd')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, 
                      Formul.fldFormulMohasebatId, 
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                       outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  fldorganId = @Value	AND  p.fldDaramadId IS NULL  --AND c.fldMashmooleKarmozd=1
					   and @year between fldstartYear and fldEndYear

	
	   	if (@fieldname=N'LastNode_fldNameVahed_Karmozd')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                      outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  fldNameVahed LIKE @value 	AND  p.fldDaramadId IS NULL  AND fldOrganId=@Value1 AND tblShomareHesabCodeDaramad.fldStatus = 1 --AND c.fldMashmooleKarmozd=1
                       and @year between fldstartYear and fldEndYear
                      
             	if (@fieldname=N'LastNode_fldShorooshenaseGhabz_Karmozd')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                      outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul 
					  WHERE  fldShorooshenaseGhabz LIKE @value 	AND  p.fldDaramadId IS NULL  AND fldOrganId=@Value1 --AND c.fldMashmooleKarmozd=1
                       and @year between fldstartYear and fldEndYear
                      
                      
             	if (@fieldname=N'LastNode_fldShomareHesab_Karmozd')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                       outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1  order by s.fldid desc) Formul
					  WHERE  fldShomareHesab LIKE @value 	AND  p.fldDaramadId IS NULL  AND fldOrganId=@Value1 --AND c.fldMashmooleKarmozd=1
                       and @year between fldstartYear and fldEndYear
                      
             	if (@fieldname=N'LastNode_fldDaramadTitle_Karmozd')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                       outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  c.fldDaramadTitle LIKE @value	AND  p.fldDaramadId IS NULL  AND fldOrganId=@Value1 AND tblShomareHesabCodeDaramad.fldStatus = 1 --AND c.fldMashmooleKarmozd=1
                       and @year between fldstartYear and fldEndYear

                      
             	if (@fieldname=N'LastNode_fldDaramadCode_Karmozd')   
	SELECT     TOP (@h) Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, Formul.fldFormulMohasebatId,  
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                       outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1 order by s.fldid desc) Formul
					  WHERE  c.fldDaramadCode LIKE @value 	AND  p.fldDaramadId IS NULL     AND fldOrganId=@Value1  AND tblShomareHesabCodeDaramad.fldStatus = 1  --AND c.fldMashmooleKarmozd=1
					   and @year between fldstartYear and fldEndYear
----------------------------------------------------


	if (@fieldname=N'LastNode_Organ_Tanzimat')   
	SELECT     TOP (@h)* from (select  Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, 
                      Formul.fldFormulMohasebatId, 
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  	 inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                       outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1  order by s.fldid desc) Formul
					  WHERE  fldorganId = @Value1	AND  p.fldDaramadId IS NULL AND tblShomareHesabCodeDaramad.fldStatus = 1 
					   and @year between fldstartYear and fldEndYear
		union all
		select  0 as  fldId, 0 fldShomareHesadId, -1 fldCodeDaramadId, 
                   @value1  fldOrganId, 0 fldUserId,'' fldDesc, 
                     getdate ()fldDate, ''fldShomareHesab,CAST(0 AS TINYINT) fldShorooshenaseGhabz, 
                    NULL fldFormolsaz,NULL fldFormulKoliId, 
                     NULL fldFormulMohasebatId, 
                     NULL fldReportFileId, '_'fldDaramadCode, isnull(Title,N'عوارض') fldDaramadTitle, cast(0 as bit) fldMashmooleArzesheAfzoode, 0 fldUnitId, 
                      cast(0 as bit)fldMashmooleKarmozd,''fldNameVahed, '' fldSharhCodDaramd,cast(1 as bit)fldStatus,cast(0 as bit)fldAmuzeshParvaresh
		from 
		drd.fn_TitleAvarezAcc('Avarez',@year,@organId) t 
		/*inner join acc.tblCoding_Details c on c.fldid=t.fldAvarezId
		 WHERE  fldorganId = @Value1*/
		
		union all
		select   0 as  fldId, 0 fldShomareHesadId, -2 fldCodeDaramadId, 
                    @Value1  fldOrganId, 0 fldUserId,'' fldDesc, 
                     getdate ()fldDate, ''fldShomareHesab,cast(0 as tinyint) fldShorooshenaseGhabz, 
                    NULL fldFormolsaz,NULL fldFormulKoliId, 
                     NULL fldFormulMohasebatId, 
                     NULL fldReportFileId, '_'fldDaramadCode, isnull(Title,N'مالیات') fldDaramadTitle, cast(0 as bit) fldMashmooleArzesheAfzoode, 0 fldUnitId, 
                      cast(0 as bit)fldMashmooleKarmozd,''fldNameVahed, '' fldSharhCodDaramd,cast( 1 as bit) fldStatus,cast(0 as bit)fldAmuzeshParvaresh
		from 
		drd.fn_TitleAvarezAcc('Maliyat',@year,@organId)t 
		/*inner join acc.tblCoding_Details c on c.fldid=t.fldMaliyatId
		 WHERE  fldorganId = @Value1*/

		 union all
		select  0 as  fldId, 0 fldShomareHesadId, -3 fldCodeDaramadId, 
                    @Value1  fldOrganId, 0 fldUserId,'' fldDesc, 
                     getdate ()fldDate, ''fldShomareHesab,cast(0 as tinyint) fldShorooshenaseGhabz, 
                    NULL fldFormolsaz,NULL fldFormulKoliId, 
                     NULL fldFormulMohasebatId, 
                     NULL fldReportFileId, '_'fldDaramadCode, title fldDaramadTitle, cast(0 as bit) fldMashmooleArzesheAfzoode, 0 fldUnitId, 
                      cast(0 as bit)fldMashmooleKarmozd,''fldNameVahed, '' fldSharhCodDaramd,cast( 1 as bit) fldStatus,cast(0 as bit)fldAmuzeshParvaresh

	from (select top(1) N'آموزش و پرورش'	title,fldDarsadAmuzeshParvaresh	from  Com.tblMaliyatArzesheAfzoode
		 WHERE fldFromDate<=@Tarikh AND fldEndDate>=@Tarikh ORDER BY fldId DESC
		 )t1
		 where fldDarsadAmuzeshParvaresh<>0.0


		 )t
-----------------------

	if (@fieldname=N'LastNode_Organ_Tanzimat_fldDaramadCode')   
	SELECT     TOP (@h)* from (select  Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, 
                      Formul.fldFormulMohasebatId, 
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,
					  c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  	 inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                       outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1  order by s.fldid desc) Formul
					  WHERE  fldorganId = @Value1	AND  p.fldDaramadId IS NULL AND tblShomareHesabCodeDaramad.fldStatus = 1 
					   and @year between fldstartYear and fldEndYear
		union all
		select  0 as  fldId, 0 fldShomareHesadId, -1 fldCodeDaramadId, 
                   @value1  fldOrganId, 0 fldUserId,'' fldDesc, 
                     getdate ()fldDate, ''fldShomareHesab,CAST(0 AS TINYINT) fldShorooshenaseGhabz, 
                    NULL fldFormolsaz,NULL fldFormulKoliId, 
                     NULL fldFormulMohasebatId, 
                     NULL fldReportFileId, '_'fldDaramadCode, isnull(Title,N'عوارض') fldDaramadTitle, cast(0 as bit) fldMashmooleArzesheAfzoode, 0 fldUnitId, 
                      cast(0 as bit)fldMashmooleKarmozd,''fldNameVahed, '' fldSharhCodDaramd,cast(1 as bit)fldStatus,cast(0 as bit)fldAmuzeshParvaresh
		from 
		drd.fn_TitleAvarezAcc('Avarez',@year,@organId) t 
		/*inner join acc.tblCoding_Details c on c.fldid=t.fldAvarezId
		 WHERE  fldorganId = @Value1*/
		union all
			select   0 as  fldId, 0 fldShomareHesadId, -2 fldCodeDaramadId, 
                    @value1  fldOrganId, 0 fldUserId,'' fldDesc, 
                     getdate ()fldDate, ''fldShomareHesab,cast(0 as tinyint) fldShorooshenaseGhabz, 
                    NULL fldFormolsaz,NULL fldFormulKoliId, 
                     NULL fldFormulMohasebatId, 
                     NULL fldReportFileId, '_'fldDaramadCode, isnull(Title,N'مالیات') fldDaramadTitle, cast(0 as bit) fldMashmooleArzesheAfzoode, 0 fldUnitId, 
                      cast(0 as bit)fldMashmooleKarmozd,''fldNameVahed, '' fldSharhCodDaramd,cast( 1 as bit) fldStatus,cast(0 as bit)fldAmuzeshParvaresh 
		from 
		drd.fn_TitleAvarezAcc('Maliyat',@year,@organId) t 
	 union all
		select  0 as  fldId, 0 fldShomareHesadId, -3 fldCodeDaramadId, 
                    @Value1  fldOrganId, 0 fldUserId,'' fldDesc, 
                     getdate ()fldDate, ''fldShomareHesab,cast(0 as tinyint) fldShorooshenaseGhabz, 
                    NULL fldFormolsaz,NULL fldFormulKoliId, 
                     NULL fldFormulMohasebatId, 
                     NULL fldReportFileId, '_'fldDaramadCode, title fldDaramadTitle, cast(0 as bit) fldMashmooleArzesheAfzoode, 0 fldUnitId, 
                      cast(0 as bit)fldMashmooleKarmozd,''fldNameVahed, '' fldSharhCodDaramd,cast( 1 as bit) fldStatus,cast(0 as bit)fldAmuzeshParvaresh

	from (select top(1) N'آموزش و پرورش'	title,fldDarsadAmuzeshParvaresh	from  Com.tblMaliyatArzesheAfzoode
		 WHERE fldFromDate<=@Tarikh AND fldEndDate>=@Tarikh ORDER BY fldId DESC
		 )t1
		 where fldDarsadAmuzeshParvaresh<>0.0
		 )t
		 where fldDaramadCode like @Value

--------------------------

if (@fieldname=N'LastNode_Organ_Tanzimat_fldDaramadTitle')   
	SELECT     TOP (@h) fldId, fldShomareHesadId, fldCodeDaramadId, 
                     fldOrganId, fldUserId, fldDesc, 
                      fldDate, fldShomareHesab, fldShorooshenaseGhabz, 
                      fldFormolsaz, fldFormulKoliId,
					  fldFormulMohasebatId, 
                      fldReportFileId, fldDaramadCode, isnull(fldDaramadTitle,'')fldDaramadTitle, fldMashmooleArzesheAfzoode, fldUnitId, 
                      fldMashmooleKarmozd, fldNameVahed,fldSharhCodDaramd,fldStatus,fldAmuzeshParvaresh
 
					   from (select  Drd.tblShomareHesabCodeDaramad.fldId, Drd.tblShomareHesabCodeDaramad.fldShomareHesadId, tblShomareHesabCodeDaramad.fldCodeDaramadId, 
                      Drd.tblShomareHesabCodeDaramad.fldOrganId, Drd.tblShomareHesabCodeDaramad.fldUserId, Drd.tblShomareHesabCodeDaramad.fldDesc, 
                      Drd.tblShomareHesabCodeDaramad.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz, 
                      Formul.fldFormolsaz, Formul.fldFormulKoliId, 
                      Formul.fldFormulMohasebatId, 
                      Drd.tblShomareHesabCodeDaramad.fldReportFileId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldUnitId, 
                      c.fldMashmooleKarmozd, Com.tblMeasureUnit.fldNameVahed,Drd.tblShomareHesabCodeDaramad.fldSharhCodDaramd,fldStatus,c.fldAmuzeshParvaresh
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS c ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = c.fldId left JOIN
                      Drd.tblCodhayeDaramd AS p ON c.fldDaramadId = p.fldDaramadId.GetAncestor(1) LEFT outer JOIN
                      Com.tblMeasureUnit ON c.fldUnitId = Com.tblMeasureUnit.fldId
					  	 inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblShomareHesabCodeDaramad.fldCodeDaramadId
                       outer apply (select top(1) [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId] from drd.tblShomareHesab_Formula s
									where s.fldShomareHesab_CodeId=Drd.tblShomareHesabCodeDaramad.fldId  
										and fldtarikhEjra<=@tarikh and fldActive=1  order by s.fldid desc) Formul
					  WHERE  fldorganId = @Value1	AND  p.fldDaramadId IS NULL AND tblShomareHesabCodeDaramad.fldStatus = 1 
					   and @year between fldstartYear and fldEndYear
		union all
		select  0 as  fldId, 0 fldShomareHesadId, -1 fldCodeDaramadId, 
                   @value1  fldOrganId, 0 fldUserId,'' fldDesc, 
                     getdate ()fldDate, ''fldShomareHesab,CAST(0 AS TINYINT) fldShorooshenaseGhabz, 
                   NULL fldFormolsaz,NULL fldFormulKoliId, 
                     NULL fldFormulMohasebatId, 
                     NULL fldReportFileId, '_'fldDaramadCode, isnull(Title,N'عوارض') fldDaramadTitle, cast(0 as bit) fldMashmooleArzesheAfzoode, 0 fldUnitId, 
                      cast(0 as bit)fldMashmooleKarmozd,''fldNameVahed, '' fldSharhCodDaramd, cast(1 as bit) fldStatus ,cast(0 as bit)fldAmuzeshParvaresh
		from 
		drd.fn_TitleAvarezAcc('Avarez',@year,@organId) t 
		/*inner join acc.tblCoding_Details c on c.fldid=t.fldAvarezId
		 WHERE  fldorganId = @Value1*/
		
		union all
			select   0 as  fldId, 0 fldShomareHesadId, -2 fldCodeDaramadId, 
                    @value1  fldOrganId, 0 fldUserId,'' fldDesc, 
                     getdate ()fldDate, ''fldShomareHesab,cast(0 as tinyint) fldShorooshenaseGhabz, 
                    NULL fldFormolsaz,NULL fldFormulKoliId, 
                     NULL fldFormulMohasebatId, 
                     NULL fldReportFileId, '_'fldDaramadCode, isnull(Title,N'مالیات') fldDaramadTitle, cast(0 as bit) fldMashmooleArzesheAfzoode, 0 fldUnitId, 
                      cast(0 as bit)fldMashmooleKarmozd,''fldNameVahed, '' fldSharhCodDaramd,cast( 1 as bit) fldStatus,cast(0 as bit)fldAmuzeshParvaresh 
		from 
		drd.fn_TitleAvarezAcc('Maliyat',@year,@organId) t 
		/*inner join acc.tblCoding_Details c on c.fldid=t.fldMaliyatId
		 WHERE  fldorganId = @Value1*/
		  union all
		select  0 as  fldId, 0 fldShomareHesadId, -3 fldCodeDaramadId, 
                    @Value1  fldOrganId, 0 fldUserId,'' fldDesc, 
                     getdate ()fldDate, ''fldShomareHesab,cast(0 as tinyint) fldShorooshenaseGhabz, 
                    NULL fldFormolsaz,NULL fldFormulKoliId, 
                     NULL fldFormulMohasebatId, 
                     NULL fldReportFileId, '_'fldDaramadCode, title fldDaramadTitle, cast(0 as bit) fldMashmooleArzesheAfzoode, 0 fldUnitId, 
                      cast(0 as bit)fldMashmooleKarmozd,''fldNameVahed, '' fldSharhCodDaramd,cast( 1 as bit) fldStatus,cast(0 as bit)fldAmuzeshParvaresh

	from (select top(1) N'آموزش و پرورش'	title,fldDarsadAmuzeshParvaresh	from  Com.tblMaliyatArzesheAfzoode
		 WHERE fldFromDate<=@Tarikh AND fldEndDate>=@Tarikh ORDER BY fldId DESC
		 )t1
		 where fldDarsadAmuzeshParvaresh<>0.0
		 )t 
		 where fldDaramadTitle like @value
	
	COMMIT
GO
