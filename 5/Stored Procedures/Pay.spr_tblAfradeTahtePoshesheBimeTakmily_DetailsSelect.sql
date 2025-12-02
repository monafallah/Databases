SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblAfradeTahtePoshesheBimeTakmily_DetailsSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@Value2 nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=Com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) d.[fldId], d.[fldAfradTahtePoshehsId], d.[fldBimeTakmiliId], d.[fldUserId], d.[fldDesc], d.[fldDate] 
	,a.fldPersonalId, a.fldName, a.fldFamily, a.fldBirthDate,a.fldCodeMeli,datediff(year,t.flddate,getdate()) as fldAge
	,case when a.fldNesbat=6 then 1 else 0 end as fldBedonePoshesh
	,case when a.fldNesbat=6 then N'خارج از پوشش' else N'تحت پوشش' end as fldBedonePosheshName
	,CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END AS fldNameNesbatShakhs
	FROM   [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] as d
	inner join [Prs].[tblAfradTahtePooshesh]  as a on a.fldId=d.fldAfradTahtePoshehsId
	inner join pay.tblAfradeTahtePoshesheBimeTakmily as b on b.fldId=d.fldBimeTakmiliId
	inner join com.tblDateDim as t on t.fldTarikh=a.fldBirthDate 
	WHERE  d.fldId=@Value

	if (@FieldName='fldPersonalId')/*فرق داره*/
	begin
			SELECT top(@h) isnull(d.[fldId],0) as fldId, isnull(d.[fldAfradTahtePoshehsId],a.fldId) as fldAfradTahtePoshehsId, isnull(d.[fldBimeTakmiliId],0) as fldBimeTakmiliId
			, isnull(d.[fldUserId],0) as fldUserId, isnull(d.[fldDesc],'')as fldDesc, isnull(d.[fldDate] ,getdate()) as fldDate
			,a.fldPersonalId, a.fldName, a.fldFamily,a.fldBirthDate,a.fldCodeMeli,datediff(year,t.flddate,getdate()) as fldAge
	,case when a.fldNesbat=6 then 1 else 0 end as fldBedonePoshesh
	,case when a.fldNesbat=6 then N'خارج از پوشش' else N'تحت پوشش' end as fldBedonePosheshName
			 ,CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END AS fldNameNesbatShakhs
			FROM   [Prs].[tblAfradTahtePooshesh]  as a
			inner join com.tblDateDim as t on t.fldTarikh=a.fldBirthDate 
			left join [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] as d   
			inner join pay.tblAfradeTahtePoshesheBimeTakmily as b on b.fldId=d.fldBimeTakmiliId
			on a.fldId=d.fldAfradTahtePoshehsId and d.fldBimeTakmiliId=@Value2
			WHERE  a.fldPersonalId=@Value
		 
	end

	if (@FieldName='')
	SELECT top(@h) d.[fldId], d.[fldAfradTahtePoshehsId], d.[fldBimeTakmiliId], d.[fldUserId], d.[fldDesc], d.[fldDate] 
	,a.fldPersonalId, a.fldName, a.fldFamily, a.fldBirthDate,a.fldCodeMeli,datediff(year,t.flddate,getdate()) as fldAge
	,case when a.fldNesbat=6 then 1 else 0 end as fldBedonePoshesh
	,case when a.fldNesbat=6 then N'خارج از پوشش' else N'تحت پوشش' end as fldBedonePosheshName
	,CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END AS fldNameNesbatShakhs
	FROM   [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] as d
	inner join [Prs].[tblAfradTahtePooshesh]  as a on a.fldId=d.fldAfradTahtePoshehsId
	inner join pay.tblAfradeTahtePoshesheBimeTakmily as b on b.fldId=d.fldBimeTakmiliId
	inner join com.tblDateDim as t on t.fldTarikh=a.fldBirthDate 
	
	COMMIT
GO
