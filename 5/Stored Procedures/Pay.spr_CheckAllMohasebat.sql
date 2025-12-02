SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Pay].[spr_CheckAllMohasebat]
 @PersonalId int
as
begin tran
declare @year smallint,@month tinyint,@payId int=0
set @year=SUBSTRING( dbo.Fn_AssembelyMiladiToShamsi(getdate()),1,4)
set @month=SUBSTRING( dbo.Fn_AssembelyMiladiToShamsi(getdate()),6,2)
select @payId=fldId from pay.Pay_tblPersonalInfo
where fldPrs_PersonalInfoId=@PersonalId

select fldFlag,fldPersonalId from pay.tblMohasebat
where fldPersonalId=@payId and fldYear=@year and fldMonth=@month
union all
select cast(0 as bit),fldPersonalId from pay.tblMohasebat_Eydi
where fldPersonalId=@payId and fldYear=@year and fldMonth=@month
union all
select cast(0 as bit),fldPersonalId from pay.tblMohasebat_Mamuriyat
where fldPersonalId=@payId and fldYear=@year and fldMonth=@month
union all
select cast(0 as bit),fldPersonalId from pay.tblMohasebat_Morakhasi
where fldPersonalId=@payId and fldYear=@year and fldMonth=@month
union all
select cast(0 as bit),fldPersonalId from pay.tblMohasebatEzafeKari_TatilKari
where fldPersonalId=@payId and fldYear=@year and fldMonth=@month
commit tran
GO
