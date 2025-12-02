SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Dead].[spr_RptGhetePor_Khali](@fieldName nvarchar(50),@vadiSalam varchar(10),@organ varchar(10))
as 
--declare @fieldName nvarchar(50)='por',@vadiSalam varchar(10)='2',@organ varchar(10)='1'
--در فیلد نیم پر فقط قطعاتی که همه قبر های ان پر شده هستن نشان داده میشود
--select 0 fldGheteId,0RadifId,''fldShomare,''fldNameRadif,'' NameGhete,0ShomareId,''fldNamevadiSalam,
--	''Name_Family,''Meli_Moshakhase,'' As FatherName,'' Sh_Sh,'' as TarikhFot,''As Tabaghe ,''TabaghatKhali

declare @query nvarchar(max)='',@amant nvarchar(20)=N' امانت',@Rezerv nvarchar(20)=N'رزرو',@tabaghe nvarchar(10)=N'طبقه'



	if (@fieldname='Por')

	set @query='select i. fldGheteId,0RadifId,0fldShomare,''''fldNameRadif, d.fldNameGhete NameGhete,0ShomareId,v.fldName fldNamevadiSalam,
	i.fldname +'''' + fldFamily Name_Family,fldMeliCode Meli_Moshakhase,fldNameFather FatherName,'''' Sh_Sh
	, ''''TarikhFot
	,fldTabaghe ,'''' TabaghatKhali 
	
	from dead.tblGhabrInfo i 
	inner join dead.tblGhete d on d.fldid=i.fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	where i.fldGheteId not in (select i1.fldGheteId from dead.tblGhabrInfo i1 where i1.fldGheteId=i.fldGheteId and fldStatus=1)'
						

	if (@fieldname =N'Nesfe')

	set @query='select i. fldGheteId,0RadifId,0fldShomare,''''fldNameRadif, d.fldNameGhete NameGhete,0ShomareId,v.fldName fldNamevadiSalam,
	i.fldname +'''' + fldFamily Name_Family,fldMeliCode Meli_Moshakhase,fldNameFather FatherName,'''' Sh_Sh
	, ''''TarikhFot
	,fldTabaghe ,'''' TabaghatKhali 
	
	from dead.tblGhabrInfo i 
	inner join dead.tblGhete d on d.fldid=i.fldGheteId
	inner join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	where i.fldGheteId  in (select i1.fldGheteId from dead.tblGhabrInfo i1
	 where i1.fldGheteId=i.fldGheteId and fldStatus=1)
	 and  i.fldGheteId  in (select i1.fldGheteId from dead.tblGhabrInfo i1
	 where i1.fldGheteId=i.fldGheteId and fldStatus in (2,3))'
	
	

--select @query
execute (@query)
GO
