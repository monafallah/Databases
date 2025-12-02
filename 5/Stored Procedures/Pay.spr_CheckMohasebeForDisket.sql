SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Pay].[spr_CheckMohasebeForDisket]( @Year SMALLINT,@Month TINYINT,@OrganId INT)
AS
BEGIN tran
declare @CountPersonel int=0,@CountMohasebat int=0
SELECT  @CountPersonel=count(*)
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId 
                      WHERE fldYear =@Year AND fldMah=@Month 
                       AND Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) =@OrganId  AND Com.fn_MaxPersonalStatus( Pay.Pay_tblPersonalInfo.fldId ,'hoghoghi')=1
					   and exists (SELECT   top(1)    Prs.tblPersonalHokm .fldPrs_PersonalInfoId
							  FROM  Prs.tblPersonalHokm  
							   WHERE fldPrs_PersonalInfoId=  Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId  and  fldTarikhEjra<=Cast(@Year as varchar(5))+ '/'+  right('0' + convert(varchar,@Month),2)+'/31' and fldStatusHokm=1  
							   ORDER BY fldTarikhSodoor DESC,fldTarikhEjra DESC)

SELECT  @CountMohasebat=count(*)
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId 
                      WHERE fldYear =@Year AND fldMonth=@Month 
                       AND Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) =@OrganId
if(@CountMohasebat<>0 and @CountMohasebat=@CountPersonel)
	select 1 as fldCheck
else 
select 0 as fldCheck

commit tran
GO
