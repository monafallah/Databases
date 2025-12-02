SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [Pay].[fn_OnAccount]( @PresonalId int,@Year smallint,@Month tinyint,@NobatPardakht tinyint,@typeHesab tinyint, @BankId int)
returns table
return
	select sum( fldKhalesPardakhti ) as fldKhalesPardakhti  from(
	SELECT  distinct a.fldkhalesPardakhti
FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pay on pay.fldPrs_PersonalInfoId=p.fldId
	inner join pay.tblMohasebat as m on m.fldPersonalId=pay.fldId and m.fldYear=a.fldYear and m.fldMonth=a.fldMonth
	inner join com.tblShomareHesabeOmoomi as s on s.fldShomareHesab=a.fldShomareHesab
	inner join com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=s.fldId
                       WHERE a.fldYear=@Year AND a.fldMonth=@Month and fldBankId=@BankId  and d.fldHesabTypeId=@typeHesab
					  AND  pay.fldId=@PresonalId  and a.fldFlag=1
					  )t
GO
