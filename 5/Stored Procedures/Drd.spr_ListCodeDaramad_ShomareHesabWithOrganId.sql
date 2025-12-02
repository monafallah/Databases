SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_ListCodeDaramad_ShomareHesabWithOrganId] (@OrganId INT,@Type TINYINT,@fiscalYear int)
AS 
declare @year smallint--,@OrganId INT=1,@Type TINYINT=3,@fiscalYear int=5
select @year=fldYear from acc.tblFiscalYear where fldid=@fiscalYear
IF(@Type=1)
 
 SELECT     Drd.tblCodhayeDaramd.fldId, Drd.tblCodhayeDaramd.fldDaramadCode, Drd.tblCodhayeDaramd.fldDaramadTitle, Com.tblMeasureUnit.fldNameVahed
,ISNULL(fldShomareHesab,'')fldShomareHesab,
ISNULL(    fldShomareHesadId,'')fldShomareHesabId,fldMashmooleArzesheAfzoode,fldMashmooleKarmozd,tblCodhayeDaramd.fldDesc,
                       ISNULL(   shomare_code.fldId,'')fldShomareHsabCodeDaramadId,
                       ISNULL(   fldShorooshenaseGhabz,'')fldShorooshenaseGhabz,
					   ISNULL(   fldStatus,'')fldStatus
FROM         Drd.tblCodhayeDaramd INNER JOIN
                      Com.tblMeasureUnit ON Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join drd.tblShomareHedabCodeDaramd_Detail d on d.fldCodeDaramdId=tblCodhayeDaramd.fldid
					  outer apply (select  sh.fldShomareHesab,fldShomareHesadId,s.fldId,fldShorooshenaseGhabz,
											fldStatus
									from drd.tblShomareHesabCodeDaramad s
									
									inner join com.tblShomareHesabeOmoomi sh on sh.fldid=s.fldShomareHesadId
									where s.fldCodeDaramadId=Drd.tblCodhayeDaramd.fldId AND fldOrganId=@OrganId
									
								)shomare_code
                        WHERE tblCodhayeDaramd.fldId <>1 and  @year between fldStartYear and fldEndYear
                        
  IF(@Type=2)
   SELECT     Drd.tblCodhayeDaramd.fldId, Drd.tblCodhayeDaramd.fldDaramadCode, Drd.tblCodhayeDaramd.fldDaramadTitle, Com.tblMeasureUnit.fldNameVahed
,ISNULL(fldShomareHesab,'')fldShomareHesab,
ISNULL(    fldShomareHesadId,'')fldShomareHesabId,fldMashmooleArzesheAfzoode,fldMashmooleKarmozd,tblCodhayeDaramd.fldDesc,
                       ISNULL(   shomare_code.fldId,'')fldShomareHsabCodeDaramadId,
                       ISNULL(   fldShorooshenaseGhabz,'')fldShorooshenaseGhabz,
					   ISNULL(   fldStatus,'')fldStatus
FROM         Drd.tblCodhayeDaramd INNER JOIN
                      Com.tblMeasureUnit ON Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId
					   inner join drd.tblShomareHedabCodeDaramd_Detail d on d.fldCodeDaramdId=tblCodhayeDaramd.fldid
					    cross apply (select  sh.fldShomareHesab,fldShomareHesadId,s.fldId,fldShorooshenaseGhabz,
											fldStatus
									from drd.tblShomareHesabCodeDaramad s
									inner join com.tblShomareHesabeOmoomi sh on sh.fldid=s.fldShomareHesadId
									where s.fldCodeDaramadId=Drd.tblCodhayeDaramd.fldId AND fldOrganId=@OrganId
								
								)shomare_code
                        WHERE tblCodhayeDaramd.fldId <>1 	and @year between fldStartYear and fldEndYear --AND tblCodhayeDaramd.fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=tblCodhayeDaramd.fldId AND fldOrganId=@OrganId)
                        
                       
  IF(@Type=3)
   SELECT     Drd.tblCodhayeDaramd.fldId, Drd.tblCodhayeDaramd.fldDaramadCode, Drd.tblCodhayeDaramd.fldDaramadTitle, Com.tblMeasureUnit.fldNameVahed
   ,'' fldShomareHesab,0 fldShomareHesabId,fldMashmooleArzesheAfzoode,fldMashmooleKarmozd,tblCodhayeDaramd.fldDesc,0 fldShomareHsabCodeDaramadId,cast(0 as tinyint)fldShorooshenaseGhabz,cast(0 as bit)fldStatus
/*,ISNULL((SELECT     Com.tblShomareHesabeOmoomi.fldShomareHesab
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId WHERE fldCodeDaramadId=Drd.tblCodhayeDaramd.fldId AND fldOrganId=@OrganId),'')fldShomareHesab,
ISNULL( (SELECT   fldShomareHesadId
                     FROM Drd.tblShomareHesabCodeDaramad
                       WHERE fldCodeDaramadId=Drd.tblCodhayeDaramd.fldId AND fldOrganId=@OrganId),'')fldShomareHesabId,fldMashmooleArzesheAfzoode,fldMashmooleKarmozd,tblCodhayeDaramd.fldDesc,
                       ISNULL( (SELECT   fldId
                     FROM Drd.tblShomareHesabCodeDaramad
                       WHERE fldCodeDaramadId=Drd.tblCodhayeDaramd.fldId AND fldOrganId=@OrganId),'')fldShomareHsabCodeDaramadId,
                       ISNULL( (SELECT   fldShorooshenaseGhabz
                     FROM Drd.tblShomareHesabCodeDaramad
                       WHERE fldCodeDaramadId=Drd.tblCodhayeDaramd.fldId AND fldOrganId=@OrganId),'')fldShorooshenaseGhabz,
					       ISNULL( (SELECT   fldStatus
                     FROM Drd.tblShomareHesabCodeDaramad
                       WHERE fldCodeDaramadId=Drd.tblCodhayeDaramd.fldId AND fldOrganId=@OrganId),'')fldStatus*/
FROM         Drd.tblCodhayeDaramd INNER JOIN
                      Com.tblMeasureUnit ON Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId
					  inner join drd.tblShomareHedabCodeDaramd_Detail d on d.fldCodeDaramdId=tblCodhayeDaramd.fldid
                        WHERE tblCodhayeDaramd.fldId <>1 AND 
						not exists (select * from  drd.tblShomareHesabCodeDaramad s
									
									where s.fldCodeDaramadId=Drd.tblCodhayeDaramd.fldId AND fldOrganId=@OrganId
									 )and @year between fldStartYear and fldEndYear
						--tblCodhayeDaramd.fldId NOT IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=tblCodhayeDaramd.fldId AND fldOrganId=@OrganId)                                                           
                        
                                             
GO
