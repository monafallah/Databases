SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Weigh].[spr_SelectParamerValueFromArze](@shomarehesadCodeDarad int,@baskoolId int,@organId int)
as
SELECT tblParametreSabet. fldId,  Drd.tblParametreSabet.fldNameParametreFa, 
        Drd.tblParametreSabet.fldNameParametreEn ,isnull(fldValue,'') as fldvalue
		,arze.fldValue_Combox
		,isnull(fldFlag ,cast(0 as bit))fldFlag,isnull(fldHeaderArzeId,0)fldHeaderArzeId,isnull(fldDetailIdArze,0)fldDetailIdArze
,fldNoeField
FROM     Drd.tblParametreSabet INNER JOIN
                  Drd.tblShomareHesabCodeDaramad ON Drd.tblParametreSabet.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                  Drd.tblCodhayeDaramd AS tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd.fldId LEFT OUTER JOIN
                  Drd.tblComboBox ON Drd.tblParametreSabet.fldComboBaxId = Drd.tblComboBox.fldId
				  outer apply (select d.fldValue,fldFlag,fldParametrSabetCodeDaramd 
				  ,case when fldNoeField=5 then c.fldTitle else  d.fldValue end as fldValue_Combox
				  ,fldHeaderId as fldHeaderArzeId,d.fldid as fldDetailIdArze
				  from Weigh.tblArze a
								inner join Weigh.tblArze_Detail d on d.fldHeaderId=a.fldid
								left join drd.tblComboBoxValue as c on c.fldComboBoxId=tblParametreSabet.fldComboBaxId and c.fldValue=d.fldValue
								where fldShomareHesabCodeDaramadId=tblShomareHesabCodeDaramad.fldid 
								and d.fldParametrSabetCodeDaramd=tblParametreSabet.fldid
								and a.fldOrganId=@organId and fldBaskoolId=@baskoolId
					)arze
where fldShomareHesabCodeDaramadId=@shomarehesadCodeDarad and fldTypeParametr=1 and tblShomareHesabCodeDaramad.fldOrganId=@organId

union all
select 0 fldId ,N'تعداد' fldNameParametreFa,'' fldNameParametreEn
,cast(isnull(arze.fldTedad,1) as nvarchar(200))fldvalue,N'' fldValue_Combox,cast(0 as bit)fldFlag,isnull(arze.fldid,0)fldHeaderArzeId
,0 fldDetailIdArze,0 fldNoeField

from drd.tblShomareHesabCodeDaramad s
 outer apply (select a.fldid,fldTedad from Weigh.tblArze a
				where fldShomareHesabCodeDaramadId=s.fldid and a.fldOrganId=@organId 
				and fldBaskoolId=@baskoolId
)arze

 where s.fldId=@shomarehesadCodeDarad and fldOrganId=@organId
 union all

 select  -1 fldId,N'مبلغ واحد'fldNameParametreFa,''fldNameParametreEn
 ,cast(isnull(fldMablagh,0) as nvarchar(200))fldvalue,N'' fldValue_Combox,cast(0 as bit)fldFlag,isnull(arze.fldid,0) fldHeaderArzeId,0 fldDetailIdArze
,0 fldNoeField
 from drd.tblShomareHesabCodeDaramad s 
outer apply (select fldmablagh/isnull(a.fldtedad,1) fldMablagh,a.fldid from Weigh.tblArze a
			where a.fldShomareHesabCodeDaramadId=s.fldid and fldBaskoolId=@baskoolId and a.fldOrganId=@organId
			)arze
where s.fldFormolsaz is null and s.fldFormulMohasebatId is null 
and s.fldId=@shomarehesadCodeDarad and s.fldOrganId=@organId 

GO
