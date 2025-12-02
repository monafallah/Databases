SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCodhayeDaramdSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT,
	@fiscALYear int,/*این فیلد فقط در فیلد نیم pid از wcf پر میاد برا بقیه فیلد نیم ها 0 فرستاده میشود*/
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	declare @year smallint
	select @year=fldYear from acc.tblFiscalYear where fldid=@fiscALYear
	if (@fieldname=N'fldId')/*در این فیلد نیم نیاز به شرط سال نداریم*/
SELECT TOP (@h)  tblCodhayeDaramd_1.fldId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldDaramadTitle, 
                  tblCodhayeDaramd_1.fldMashmooleArzesheAfzoode, tblCodhayeDaramd_1.fldMashmooleKarmozd,  
                  tblCodhayeDaramd_1.fldUnitId, tblCodhayeDaramd_1.fldLevel, tblCodhayeDaramd_1.fldStrhid, 
				   
                   tblCodhayeDaramd_1.fldUserId, tblCodhayeDaramd_1.fldDesc, tblCodhayeDaramd_1.fldDate, 
                   com.tblMeasureUnit.fldNameVahed,0 fldFlag,0 lastNod,fldAmuzeshParvaresh
FROM     drd.tblCodhayeDaramd AS tblCodhayeDaramd_1  LEFT OUTER JOIN
                  com.tblMeasureUnit ON tblCodhayeDaramd_1.fldUnitId = com.tblMeasureUnit.fldId
				  inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblCodhayeDaramd_1.fldid
				  /*outer apply (select 1 as fldflag from acc.tblCoding_Details
								inner join acc.tblCoding_Header on fldHeaderCodId=tblCoding_Header.fldid
				  where fldYear=@year and tblCodhayeDaramd_1.fldDaramadCode=tblCoding_Details.[fldDaramadCode])acc*/
	WHERE  tblCodhayeDaramd_1.fldId = @Value --and @year between fldstartYear and fldEndYear
	ORDER BY tblCodhayeDaramd_1.fldDaramadCode
	
if (@fieldname=N'fldDaramadCode')/*برا کدینگ جدیدسال 1403 باید شرط سال بزاریم*/
begin
set @year=substring(dbo.Fn_AssembelyMiladiToShamsi(gETDATE()),1,4)
	SELECT TOP (@h)  tblCodhayeDaramd_1.fldId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldDaramadTitle, 
                  tblCodhayeDaramd_1.fldMashmooleArzesheAfzoode, tblCodhayeDaramd_1.fldMashmooleKarmozd, 
                  tblCodhayeDaramd_1.fldUnitId, tblCodhayeDaramd_1.fldLevel, tblCodhayeDaramd_1.fldStrhid, 
				  
                  tblCodhayeDaramd_1.fldUserId, tblCodhayeDaramd_1.fldDesc, tblCodhayeDaramd_1.fldDate, 
                  com.tblMeasureUnit.fldNameVahed,0 fldFlag,0 lastNod,fldAmuzeshParvaresh
FROM     Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 INNER JOIN
                  com.tblMeasureUnit ON tblCodhayeDaramd_1.fldUnitId = com.tblMeasureUnit.fldId
				    inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblCodhayeDaramd_1.fldid
					  /*outer apply (select 1 as fldflag from acc.tblCoding_Details
								inner join acc.tblCoding_Header on fldHeaderCodId=tblCoding_Header.fldid
				  where fldYear=@year and tblCodhayeDaramd_1.fldDaramadCode=tblCoding_Details.[fldDaramadCode])acc*/
                      	WHERE  fldDaramadCode like @Value  and @year between fldstartYear and fldEndYear
               ORDER BY tblCodhayeDaramd_1.fldDaramadCode       	
end	
	if (@fieldname=N'fldDaramadTitle')/*برا کدینگ جدیدسال 1403 باید شرط سال بزاریم*/
begin
set @year=substring(dbo.Fn_AssembelyMiladiToShamsi(gETDATE()),1,4)
	SELECT TOP (@h) tblCodhayeDaramd_1.fldId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldDaramadTitle, 
                  tblCodhayeDaramd_1.fldMashmooleArzesheAfzoode, tblCodhayeDaramd_1.fldMashmooleKarmozd, 
                  tblCodhayeDaramd_1.fldUnitId, tblCodhayeDaramd_1.fldLevel, tblCodhayeDaramd_1.fldStrhid, 
				
                  tblCodhayeDaramd_1.fldUserId, tblCodhayeDaramd_1.fldDesc, tblCodhayeDaramd_1.fldDate, 
                  com.tblMeasureUnit.fldNameVahed,0 fldFlag,0 lastNod,fldAmuzeshParvaresh
FROM     Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 INNER JOIN
                  com.tblMeasureUnit ON tblCodhayeDaramd_1.fldUnitId = com.tblMeasureUnit.fldId
				    inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblCodhayeDaramd_1.fldid
					 /* outer apply (select 1 as fldflag from acc.tblCoding_Details
								inner join acc.tblCoding_Header on fldHeaderCodId=tblCoding_Header.fldid
				  where fldYear=@year and tblCodhayeDaramd_1.fldDaramadCode=tblCoding_Details.[fldDaramadCode])acc*/
	WHERE fldDaramadTitle like @Value and @year between fldstartYear and fldEndYear
	ORDER BY tblCodhayeDaramd_1.fldDaramadCode
end
	
	if (@fieldname=N'fldUnitId')/*در این فیلد نیم نیاز به شرط سال نداریم*/
begin
set @year=substring(dbo.Fn_AssembelyMiladiToShamsi(gETDATE()),1,4)
	SELECT TOP (@h) tblCodhayeDaramd_1.fldId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldDaramadTitle, 
                  tblCodhayeDaramd_1.fldMashmooleArzesheAfzoode, tblCodhayeDaramd_1.fldMashmooleKarmozd, 
                  tblCodhayeDaramd_1.fldUnitId, tblCodhayeDaramd_1.fldLevel, tblCodhayeDaramd_1.fldStrhid, 
				 
                  tblCodhayeDaramd_1.fldUserId, tblCodhayeDaramd_1.fldDesc, tblCodhayeDaramd_1.fldDate, 
                  com.tblMeasureUnit.fldNameVahed,0fldFlag,0 lastNod,fldAmuzeshParvaresh
FROM     Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 INNER JOIN
                  com.tblMeasureUnit ON tblCodhayeDaramd_1.fldUnitId = com.tblMeasureUnit.fldId
				    inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblCodhayeDaramd_1.fldid
					  /*outer apply (select 1 as fldflag from acc.tblCoding_Details
								inner join acc.tblCoding_Header on fldHeaderCodId=tblCoding_Header.fldid
				  where fldYear=@year and tblCodhayeDaramd_1.fldDaramadCode=tblCoding_Details.[fldDaramadCode])acc*/
	WHERE fldUnitId= @Value   and @year between fldstartYear and fldEndYear
ORDER BY tblCodhayeDaramd_1.fldDaramadCode

end	
	if (@fieldname=N'fldMashmooleArzesheAfzoode')/*در این فیلد نیم نیاز به شرط سال نداریم*/
begin
set @year=substring(dbo.Fn_AssembelyMiladiToShamsi(gETDATE()),1,4)
	SELECT TOP (@h)  tblCodhayeDaramd_1.fldId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldDaramadTitle, 
                  tblCodhayeDaramd_1.fldMashmooleArzesheAfzoode, tblCodhayeDaramd_1.fldMashmooleKarmozd, 
                  tblCodhayeDaramd_1.fldUnitId, tblCodhayeDaramd_1.fldLevel, tblCodhayeDaramd_1.fldStrhid, 
				   
                  tblCodhayeDaramd_1.fldUserId, tblCodhayeDaramd_1.fldDesc, tblCodhayeDaramd_1.fldDate, 
                  com.tblMeasureUnit.fldNameVahed,0 fldFlag,0 lastNod,fldAmuzeshParvaresh
FROM     Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 INNER JOIN
                  com.tblMeasureUnit ON tblCodhayeDaramd_1.fldUnitId = com.tblMeasureUnit.fldId
				    inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblCodhayeDaramd_1.fldid
					/*  outer apply (select 1 as fldflag from acc.tblCoding_Details
								inner join acc.tblCoding_Header on fldHeaderCodId=tblCoding_Header.fldid
				  where fldYear=@year and tblCodhayeDaramd_1.fldDaramadCode=tblCoding_Details.[fldDaramadCode])acc*/
	WHERE fldMashmooleArzesheAfzoode= 1   and @year between fldstartYear and fldEndYear
ORDER BY tblCodhayeDaramd_1.fldDaramadCode
end
if (@fieldname=N'fldMashmooleKarmozd')/*در این فیلد نیم نیاز به شرط سال نداریم*/
begin
set @year=substring(dbo.Fn_AssembelyMiladiToShamsi(gETDATE()),1,4)
	SELECT TOP (@h)  tblCodhayeDaramd_1.fldId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldDaramadTitle, 
                  tblCodhayeDaramd_1.fldMashmooleArzesheAfzoode, tblCodhayeDaramd_1.fldMashmooleKarmozd, 
                  tblCodhayeDaramd_1.fldUnitId, tblCodhayeDaramd_1.fldLevel, tblCodhayeDaramd_1.fldStrhid, 
				   
                  tblCodhayeDaramd_1.fldUserId, tblCodhayeDaramd_1.fldDesc, tblCodhayeDaramd_1.fldDate, 
                  com.tblMeasureUnit.fldNameVahed,0 fldFlag,0 lastNod,fldAmuzeshParvaresh
FROM     Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 INNER JOIN
                  com.tblMeasureUnit ON tblCodhayeDaramd_1.fldUnitId = com.tblMeasureUnit.fldId
				    inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblCodhayeDaramd_1.fldid
					 /* outer apply (select 1 as fldflag from acc.tblCoding_Details
								inner join acc.tblCoding_Header on fldHeaderCodId=tblCoding_Header.fldid
				  where fldYear=@year and tblCodhayeDaramd_1.fldDaramadCode=tblCoding_Details.[fldDaramadCode])acc*/
	WHERE fldMashmooleKarmozd= 1   and @year between fldstartYear and fldEndYear 
ORDER BY tblCodhayeDaramd_1.fldDaramadCode
end

IF(@fieldname='PId')
BEGIN


IF(@value=0)
	SELECT TOP (@h)  c.fldId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldMashmooleKarmozd, c.fldUnitId, 
                  c.fldLevel, c.fldStrhid, c.fldUserId, c.fldDesc, c.fldDate, 
                  com.tblMeasureUnit.fldNameVahed,isnull (fldflag,0)fldFlag,0 lastNod,fldAmuzeshParvaresh
FROM     Drd.tblCodhayeDaramd AS c LEFT OUTER JOIN
                  com.tblMeasureUnit ON c.fldUnitId = com.tblMeasureUnit.fldId
				    inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=c.fldid
					 -- outer apply (select 1 as fldflag from acc.tblCoding_Details
						--		inner join acc.tblCoding_Header on fldHeaderCodId=tblCoding_Header.fldid
				  --where fldYear=@year and c.fldDaramadCode=tblCoding_Details.[fldDaramadCode])acc
				  outer apply (select 1 as fldflag from acc.tblCoding_Details as p
									inner join acc.tblTemplateCoding as t on t.fldId=p.fldTempCodingId 
									inner join acc.tblCoding_Details as d on  p.fldHeaderCodId=d.fldHeaderCodId  and d.fldCodeId.IsDescendantOf(p.fldCodeId) =1
									inner join acc.tblCoding_Header on d.fldHeaderCodId=tblCoding_Header.fldid
									where fldYear=@year and c.fldDaramadCode=d.[fldDaramadCode]and t.fldItemId=7 )acc
                      WHERE c.fldDaramadId=HIERARCHYID::GetRoot()   and @year between fldstartYear and fldEndYear
 ORDER BY c.fldDaramadCode
 
 else  
 SELECT TOP (@h)  c.fldId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldMashmooleKarmozd,  c.fldUnitId, 
                  c.fldLevel, c.fldStrhid,c.fldUserId, c.fldDesc, c.fldDate,
                  com.tblMeasureUnit.fldNameVahed,isnull (fldflag,0)fldFlag,isnull(lastNod,0) lastNod,c.fldAmuzeshParvaresh
FROM     Drd.tblCodhayeDaramd AS c INNER JOIN
                  Drd.tblCodhayeDaramd AS p ON p.fldId = @value AND c.fldDaramadId.GetAncestor(1) = p.fldDaramadId  LEFT OUTER JOIN
                  com.tblMeasureUnit ON c.fldUnitId = com.tblMeasureUnit.fldId  
				    inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=c.fldid
					outer apply (select 1 as fldflag from acc.tblCoding_Details as p
									inner join acc.tblTemplateCoding as t on t.fldId=p.fldTempCodingId 
									inner join acc.tblCoding_Details as d on  p.fldHeaderCodId=d.fldHeaderCodId  and d.fldCodeId.IsDescendantOf(p.fldCodeId) =1
									inner join acc.tblCoding_Header on d.fldHeaderCodId=tblCoding_Header.fldid
									where fldYear=@year and c.fldDaramadCode=d.[fldDaramadCode]and t.fldItemId=7 )acc
						outer apply(				select 1 lastNod
									fROM           Drd.tblCodhayeDaramd  s left outer join
											 Drd.tblCodhayeDaramd as p on p.fldDaramadId.GetAncestor(1)=s.fldDaramadId
											where p.fldid is null and s.fldid=  c.fldId )lastNod
				     where   @year between fldstartYear and fldEndYear    
ORDER BY c.fldDaramadCode                  
--SELECT TOP (@h)  c.fldId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldMashmooleKarmozd,  c.fldUnitId, 
--                  c.fldLevel, c.fldStrhid,c.fldUserId, c.fldDesc, c.fldDate,
--                  com.tblMeasureUnit.fldNameVahed
--FROM     Drd.tblCodhayeDaramd AS c INNER JOIN
--                  Drd.tblCodhayeDaramd AS p ON p.fldId = @value AND c.fldDaramadId.GetAncestor(1) = p.fldDaramadId  LEFT OUTER JOIN
--                  com.tblMeasureUnit ON c.fldUnitId = com.tblMeasureUnit.fldId  
--				  cross apply (select h.fldid from acc.tblCoding_Details d
--									inner join acc.tblCoding_Header h on fldHeaderCodId=h.fldid
--												cross apply (select top(1) parent.fldAcc_CodingDetailId from drd.tblCodhayeDaramd child inner join
--														drd.tblCodhayeDaramd parent on child.fldId=@value and child.fldDaramadId.IsDescendantOf(parent.fldDaramadId)=1
--														and parent.fldAcc_CodingDetailId is not null
--														order by parent.fldid desc
--														)parent
		
--									where d.fldid=fldAcc_CodingDetailId --and h.fldYear=@year
--							)Acc          
--ORDER BY c.fldDaramadCode

END

IF(@fieldname='PId_value')
BEGIN

--select @year=fldYear from acc.tblFiscalYear where fldid=@fiscALYear
IF(@value=1)
	 SELECT TOP (@h)  c.fldId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldMashmooleKarmozd,  c.fldUnitId, 
					  c.fldLevel, c.fldStrhid,c.fldUserId, c.fldDesc, c.fldDate,
					  com.tblMeasureUnit.fldNameVahed,isnull (fldflag,0)fldFlag,0 lastNod,c.fldAmuzeshParvaresh
	FROM     Drd.tblCodhayeDaramd AS c INNER JOIN
					  Drd.tblCodhayeDaramd AS p ON p.fldId = @value AND c.fldDaramadId.GetAncestor(1) = p.fldDaramadId  LEFT OUTER JOIN
					  com.tblMeasureUnit ON c.fldUnitId = com.tblMeasureUnit.fldId  
					   inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=c.fldid 
					     outer apply (select 1 as fldflag from acc.tblCoding_Details
								inner join acc.tblCoding_Header on fldHeaderCodId=tblCoding_Header.fldid
				  where fldYear=@year and c.fldDaramadCode=tblCoding_Details.[fldDaramadCode])acc
					    where  @year between fldstartYear and fldEndYear        
	ORDER BY c.fldDaramadCode
else
	 SELECT  TOP (@h)   c.fldId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldMashmooleKarmozd,  c.fldUnitId, 
                  c.fldLevel, c.fldStrhid,c.fldUserId, c.fldDesc, c.fldDate,
                  com.tblMeasureUnit.fldNameVahed,isnull (fldflag,0)fldFlag,0 lastNod,c.fldAmuzeshParvaresh
FROM     Drd.tblCodhayeDaramd AS c INNER JOIN
                  Drd.tblCodhayeDaramd AS p ON p.fldId = @value AND c.fldDaramadId.GetAncestor(1) = p.fldDaramadId  LEFT OUTER JOIN
                  com.tblMeasureUnit ON c.fldUnitId = com.tblMeasureUnit.fldId  
				   inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=c.fldid 
				     outer apply (select 1 as fldflag from acc.tblCoding_Details
								inner join acc.tblCoding_Header on fldHeaderCodId=tblCoding_Header.fldid
				  where fldYear=@year and c.fldDaramadCode=tblCoding_Details.[fldDaramadCode])acc
				    where  @year between fldstartYear and fldEndYear        
ORDER BY c.fldDaramadCode

END

IF(@fieldname='PId_OrganId')
BEGIN
IF(@value=0)
	SELECT TOP (@h)  c.fldId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldMashmooleKarmozd, c.fldUnitId, 
                  c.fldLevel, c.fldStrhid, c.fldUserId, c.fldDesc, c.fldDate, 
                  com.tblMeasureUnit.fldNameVahed,isnull (fldflag,0)fldFlag,0 lastNod,fldAmuzeshParvaresh
FROM     Drd.tblCodhayeDaramd AS c LEFT OUTER JOIN
                  com.tblMeasureUnit ON c.fldUnitId = com.tblMeasureUnit.fldId
				    inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=c.fldid
					  outer apply (select 1 as fldflag from acc.tblCoding_Details
								inner join acc.tblCoding_Header on fldHeaderCodId=tblCoding_Header.fldid
				  where fldYear=@year and c.fldDaramadCode=tblCoding_Details.[fldDaramadCode])acc
                      WHERE c.fldDaramadId=HIERARCHYID::GetRoot() AND  c.fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldOrganId=@OrganId) 
					 and @year between fldstartYear and fldEndYear
 ORDER BY c.fldDaramadCode
 else                     
SELECT TOP (@h) c.fldId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldMashmooleKarmozd,  c.fldUnitId, 
                  c.fldLevel, c.fldStrhid,c.fldUserId, c.fldDesc, c.fldDate,
                  com.tblMeasureUnit.fldNameVahed,isnull (fldflag,0)fldFlag,0 lastNod,c.fldAmuzeshParvaresh
FROM     Drd.tblCodhayeDaramd AS c INNER JOIN
                  Drd.tblCodhayeDaramd AS p ON p.fldId = @value AND c.fldDaramadId.GetAncestor(1) = p.fldDaramadId  LEFT OUTER JOIN
                  com.tblMeasureUnit ON c.fldUnitId = com.tblMeasureUnit.fldId  
				    inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=c.fldid    
					  outer apply (select 1 as fldflag from acc.tblCoding_Details
								inner join acc.tblCoding_Header on fldHeaderCodId=tblCoding_Header.fldid
				  where fldYear=@year and c.fldDaramadCode=tblCoding_Details.[fldDaramadCode])acc
                  WHERE c.fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldOrganId=@OrganId)  
				   and @year between fldstartYear and fldEndYear    
ORDER BY c.fldDaramadCode

END

	if (@fieldname=N'fldLastNode')/*در این فیلد نیم نیاز به شرط سال نداریم*/
	begin
	set @year=substring(dbo.Fn_AssembelyMiladiToShamsi(gETDATE()),1,4)
SELECT TOP (@h)  c.fldId, c.fldDaramadCode, c.fldDaramadTitle, c.fldMashmooleArzesheAfzoode, c.fldMashmooleKarmozd,  c.fldUnitId, 
                  c.fldLevel, c.fldStrhid,c.fldUserId, c.fldDesc, c.fldDate,
                  com.tblMeasureUnit.fldNameVahed,0 fldFlag,0 lastNod,c.fldAmuzeshParvaresh
FROM     Drd.tblCodhayeDaramd AS c left JOIN
                  Drd.tblCodhayeDaramd AS p ON  c.fldDaramadId = p.fldDaramadId.GetAncestor(1)  LEFT OUTER JOIN
                  com.tblMeasureUnit ON c.fldUnitId = com.tblMeasureUnit.fldId    
				    inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=c.fldid
					  /*outer apply (select 1 as fldflag from acc.tblCoding_Details
								inner join acc.tblCoding_Header on fldHeaderCodId=tblCoding_Header.fldid
				  where fldYear=@year and c.fldDaramadCode=tblCoding_Details.[fldDaramadCode])acc*/
	WHERE p.fldDaramadId IS NULL  and @year between fldstartYear and fldEndYear
ORDER BY c.fldDaramadCode
end


	if (@fieldname=N'fldDesc')/*در این فیلد نیم نیاز به شرط سال نداریم*/
	begin
SELECT TOP (@h) tblCodhayeDaramd_1.fldId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldDaramadTitle, 
                  tblCodhayeDaramd_1.fldMashmooleArzesheAfzoode, tblCodhayeDaramd_1.fldMashmooleKarmozd,  
                  tblCodhayeDaramd_1.fldUnitId, tblCodhayeDaramd_1.fldLevel, tblCodhayeDaramd_1.fldStrhid, 
				   
                   tblCodhayeDaramd_1.fldUserId, tblCodhayeDaramd_1.fldDesc, tblCodhayeDaramd_1.fldDate, 
                   com.tblMeasureUnit.fldNameVahed,0 fldFlag,0 lastNod,fldAmuzeshParvaresh
FROM     drd.tblCodhayeDaramd AS tblCodhayeDaramd_1  LEFT OUTER JOIN
                  com.tblMeasureUnit ON tblCodhayeDaramd_1.fldUnitId = com.tblMeasureUnit.fldId
				    inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblCodhayeDaramd_1.fldid
					  /*outer apply (select 1 as fldflag from acc.tblCoding_Details
								inner join acc.tblCoding_Header on fldHeaderCodId=tblCoding_Header.fldid
				  where fldYear=@year and tblCodhayeDaramd_1.fldDaramadCode=tblCoding_Details.[fldDaramadCode])acc*/
	WHERE  tblCodhayeDaramd_1.fldDesc like  @Value and @year between fldstartYear and fldEndYear
ORDER BY tblCodhayeDaramd_1.fldDaramadCode
end
	if (@fieldname=N'')/*در این فیلد نیم نیاز به شرط سال نداریم*/
	begin
	set @year=substring(dbo.Fn_AssembelyMiladiToShamsi(gETDATE()),1,4)
	SELECT TOP (@h) tblCodhayeDaramd_1.fldId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldDaramadTitle, 
                  tblCodhayeDaramd_1.fldMashmooleArzesheAfzoode, tblCodhayeDaramd_1.fldMashmooleKarmozd, 
                  tblCodhayeDaramd_1.fldUnitId, tblCodhayeDaramd_1.fldLevel, tblCodhayeDaramd_1.fldStrhid, 
				  
                  tblCodhayeDaramd_1.fldUserId, tblCodhayeDaramd_1.fldDesc, tblCodhayeDaramd_1.fldDate, 
                  com.tblMeasureUnit.fldNameVahed,0 fldFlag,0 lastNod,fldAmuzeshParvaresh
FROM     Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 INNER JOIN
                  com.tblMeasureUnit ON tblCodhayeDaramd_1.fldUnitId = com.tblMeasureUnit.fldId
				    inner join Drd.tblShomareHedabCodeDaramd_Detail  d on d.fldCodeDaramdId=tblCodhayeDaramd_1.fldid
					  /*outer apply (select 1 as fldflag from acc.tblCoding_Details
								inner join acc.tblCoding_Header on fldHeaderCodId=tblCoding_Header.fldid
				  where fldYear=@year and tblCodhayeDaramd_1.fldDaramadCode=tblCoding_Details.[fldDaramadCode])acc*/
					where   @year between fldstartYear and fldEndYear
     ORDER BY tblCodhayeDaramd_1.fldDaramadCode             
	end
	COMMIT
GO
