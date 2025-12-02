SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Drd].[spr_NerkhSal](@sal char(4))
as
select fldDaramadCode, fldDaramadTitle, fldNameParametreFa, fldNameParametreEn, 
                      fldVaziyat, fldTarikhFaalSazi, fldValue from 
(SELECT DISTINCT 
                      Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId, Drd.tblCodhayeDaramd.fldDaramadCode, Drd.tblCodhayeDaramd.fldDaramadTitle, Drd.tblParametreSabet.fldNameParametreFa, 
                      Drd.tblParametreSabet.fldNameParametreEn, Drd.tblParametreSabet.fldVaziyat, Drd.tblParametreSabet_Nerkh.fldTarikhFaalSazi, 
					  --case when fldvalue like N'%.%' then fldvalue else  cast(format(cast(Drd.tblParametreSabet_Nerkh.fldValue as int),'###,###')as nvarchar(500)) end fldValue
					 case when Drd.tblParametreSabet_Nerkh.fldValue like N'%.%' then Drd.tblParametreSabet_Nerkh.fldValue else cast( REPLACE(CONVERT(VARCHAR, CONVERT(MONEY, Drd.tblParametreSabet_Nerkh.fldValue), 1), '.00', '') as nvarchar(500))end fldValue --sql 2008
FROM         Drd.tblParametreSabet INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblParametreSabet.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblParametreSabet_Nerkh ON Drd.tblParametreSabet.fldId = Drd.tblParametreSabet_Nerkh.fldParametreSabetId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId
WHERE     (Drd.tblParametreSabet_Nerkh.fldTarikhFaalSazi LIKE @sal + '%'))as d
ORDER BY d.fldCodeDaramadId
GO
