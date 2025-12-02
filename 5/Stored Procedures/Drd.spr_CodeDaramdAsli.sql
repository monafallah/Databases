SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Drd].[spr_CodeDaramdAsli]
as
declare @tarikh int,@date nvarchar(10)
set @tarikh=substring(dbo.Fn_AssembelyMiladiToShamsi(getdate()),1,4)
set @date=dbo.Fn_AssembelyMiladiToShamsi(getdate())
/*declare @table table ([fldId] int,[fldDaramadId] hierarchyid,[fldDaramadCode] varchar(50),[fldDaramadTitle] nvarchar(250) ,[fldMashmooleArzesheAfzoode]bit,[fldMashmooleKarmozd] bit,
	[fldUnitId] int,[fldLevel]  nvarchar(50),[fldUserId] int,[fldDesc] nvarchar(max) ,[fldDate] datetime,[fldsStrhid] nvarchar(50))
	insert into @table
SELECT        fldId, fldDaramadId, fldDaramadCode, fldDaramadTitle, fldMashmooleArzesheAfzoode, fldMashmooleKarmozd, fldUnitId, fldLevel, fldUserId, fldDesc, fldDate,
fldStrhid
FROM            Drd.tblCodhayeDaramd as c
inner join drd.tblShomareHedabCodeDaramd_Detail s1 on s1.fldCodeDaramdId=s.fldid and @tarikh between fldStartYear and fldEndYear
where c.fldid not in (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  inner join drd.tblShomareHedabCodeDaramd_Detail s1 on s1.fldCodeDaramdId=s.fldid and @tarikh between fldStartYear and fldEndYear
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid/* and /*برای مالیات بر ارزش افزوده*/s.fldid not in (307)*/)
							  and fldLevel not in (0)
							

select s.fldId AS fldCodeDaramadId,s.fldDaramadCode,s.fldDaramadTitle,s.fldMashmooleArzesheAfzoode,s.fldMashmooleKarmozd,(SELECT fldNameVahed FROM Com.tblMeasureUnit WHERE tblMeasureUnit.fldId=s.fldUnitId)fldNameVahed from
							@table  AS s left JOIN
							@table AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							inner join drd.tblShomareHedabCodeDaramd_Detail s1 on s1.fldCodeDaramdId=s.fldid and @tarikh between fldStartYear and fldEndYear
							WHERE p.fldDaramadId IS NULL*/


select distinct s.fldId AS fldCodeDaramadId,s.fldDaramadCode,s.fldDaramadTitle,s.fldMashmooleArzesheAfzoode,s.fldMashmooleKarmozd,s.fldAmuzeshParvaresh,(SELECT fldNameVahed FROM Com.tblMeasureUnit WHERE tblMeasureUnit.fldId=s.fldUnitId)fldNameVahed from
							drd.tblCodhayeDaramd  AS s left JOIN
							drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							inner join drd.tblShomareHedabCodeDaramd_Detail s1 on s1.fldCodeDaramdId=s.fldid and @tarikh between fldStartYear and fldEndYear
							WHERE p.fldDaramadId IS not  NULL   and s.fldLevel not in (0) and s.fldStrhid <> '/'
union all
 select -3 AS fldCodeDaramadId,'_'fldDaramadCode,title fldDaramadTitle,cast (0 as bit)fldMashmooleArzesheAfzoode,cast(0 as bit)fldMashmooleKarmozd,cast(1 as bit) fldAmuzeshParvaresh  
 ,''fldNameVahed 

from (select top(1) N'آموزش و پرورش'	title,fldDarsadAmuzeshParvaresh	from  Com.tblMaliyatArzesheAfzoode
		 WHERE fldFromDate<=@date AND fldEndDate>=@date ORDER BY fldId DESC
		 )t1
		 where fldDarsadAmuzeshParvaresh<>0.0
GO
