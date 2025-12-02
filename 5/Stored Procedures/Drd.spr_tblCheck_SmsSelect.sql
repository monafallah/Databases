SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCheck_SmsSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),

@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)s.[fldId], [fldCheckId], s.[fldStatus], s.[fldUserId],  s.[fldIP], s.[fldDate] 
	,fldNameShakhs,isnull(ru.fldMobile,'')fldMobile,fldTarikhSarResid,fldShomareSanad,fldBankName,d2.fldName as fldShobeName
	,case when s.[fldStatus]=0 then N'ارسال نشده' when s.[fldStatus]=7 then N'7 روز ارسال شده' when s.[fldStatus]=1 then N'1 روز مانده' end  as fldStatusName
	FROM   [Drd].[tblCheck_Sms]  s
	inner join drd.tblcheck c on c.fldid=fldCheckId
	inner join com.tblShomareHesabeOmoomi s1 on s1.fldid=fldShomareHesabId
	inner join com.tblSHobe d2 on d2.fldid=s1.fldShobeId
	inner join com.tblBank b on b.fldid=d2.fldBankId
	inner join drd.tblReplyTaghsit r on r.fldid=c.fldReplyTaghsitId
	inner join drd.tblStatusTaghsit_Takhfif sr on sr.fldid=r.fldStatusId
	inner join drd.tblRequestTaghsit_Takhfif ru on ru.fldid=sr.fldRequestId 
cross apply 
					(
						select fldname+' '+fldFamily fldNameShakhs from com.tblEmployee
						inner join com.tblAshkhas a on tblEmployee.fldid=fldHaghighiId
						left join com.tblEmployee_Detail d on d.fldEmployeeId=tblEmployee.fldid
						where a.fldid=s1.fldAshkhasId
					union all
						select fldName fldNameShakhs  from com.tblAshkhaseHoghoghi
						inner join com.tblAshkhas a on tblAshkhaseHoghoghi.fldid=fldHoghoghiId
						where a.fldid=s1.fldAshkhasId
					)shakhs
	WHERE  s.fldId=@value
	
	if (@fieldname='')
	SELECT top(@h)s.[fldId], [fldCheckId], s.[fldStatus], s.[fldUserId],  s.[fldIP], s.[fldDate] 
	,fldNameShakhs,isnull(ru.fldMobile,'')fldMobile,fldTarikhSarResid,fldShomareSanad,fldBankName,d2.fldName as fldShobeName
	,case when s.[fldStatus]=0 then N'ارسال نشده' when s.[fldStatus]=7 then N'7 روز ارسال شده' when s.[fldStatus]=1 then N'1 روز مانده' end  as fldStatusName
	FROM   [Drd].[tblCheck_Sms]  s
	inner join drd.tblcheck c on c.fldid=fldCheckId
	inner join com.tblShomareHesabeOmoomi s1 on s1.fldid=fldShomareHesabId
	inner join com.tblSHobe d2 on d2.fldid=s1.fldShobeId
	inner join com.tblBank b on b.fldid=d2.fldBankId
	inner join drd.tblReplyTaghsit r on r.fldid=c.fldReplyTaghsitId
	inner join drd.tblStatusTaghsit_Takhfif sr on sr.fldid=r.fldStatusId
	inner join drd.tblRequestTaghsit_Takhfif ru on ru.fldid=sr.fldRequestId 
cross apply 
					(
						select fldname+' '+fldFamily fldNameShakhs from com.tblEmployee
						inner join com.tblAshkhas a on tblEmployee.fldid=fldHaghighiId
						left join com.tblEmployee_Detail d on d.fldEmployeeId=tblEmployee.fldid
						where a.fldid=s1.fldAshkhasId
					union all
						select fldName fldNameShakhs  from com.tblAshkhaseHoghoghi
						inner join com.tblAshkhas a on tblAshkhaseHoghoghi.fldid=fldHoghoghiId
						where a.fldid=s1.fldAshkhasId
					)shakhs
	

	if (@fieldname='7Day')
	SELECT top(@h)  [fldId], [fldCheckId],[fldStatus], [fldUserId],  [fldIP],[fldDate] 
	,fldNameShakhs,fldMobile,fldTarikhSarResid,fldShomareSanad,fldBankName,fldShobeName
	,fldStatusName from (select  s.[fldId], [fldCheckId], s.[fldStatus], s.[fldUserId],  s.[fldIP], s.[fldDate] 
	,fldNameShakhs,isnull(ru.fldMobile,'')fldMobile,fldTarikhSarResid,fldShomareSanad,fldBankName,d2.fldName as fldShobeName
	,case when s.[fldStatus]=0 then N'ارسال نشده' when s.[fldStatus]=7 then N'7 روز ارسال شده' when s.[fldStatus]=1 then N'1 روز مانده' end  as fldStatusName
	,dbo.Fn_AssembelyShamsiToMiladiDate(fldTarikhSarResid) DataSarResid,c.fldStatus as fldStatusCheck
	FROM   [Drd].[tblCheck_Sms]  s
	inner join drd.tblcheck c on c.fldid=fldCheckId
	inner join com.tblShomareHesabeOmoomi s1 on s1.fldid=fldShomareHesabId
	inner join com.tblSHobe d2 on d2.fldid=s1.fldShobeId
	inner join com.tblBank b on b.fldid=d2.fldBankId
	inner join drd.tblReplyTaghsit r on r.fldid=c.fldReplyTaghsitId
	inner join drd.tblStatusTaghsit_Takhfif sr on sr.fldid=r.fldStatusId
	inner join drd.tblRequestTaghsit_Takhfif ru on ru.fldid=sr.fldRequestId 
cross apply 
					(
						select fldname+' '+fldFamily fldNameShakhs from com.tblEmployee
						inner join com.tblAshkhas a on tblEmployee.fldid=fldHaghighiId
						left join com.tblEmployee_Detail d on d.fldEmployeeId=tblEmployee.fldid
						where a.fldid=s1.fldAshkhasId
					union all
						select fldName fldNameShakhs  from com.tblAshkhaseHoghoghi
						inner join com.tblAshkhas a on tblAshkhaseHoghoghi.fldid=fldHoghoghiId
						where a.fldid=s1.fldAshkhasId
					)shakhs
					where fldTypeSanad=0
)t
					where [fldStatus]=0 and DATEDIFF(day,getdate(),DataSarResid)=7
					and fldStatusCheck=1


if (@fieldname='1Day')
	SELECT top(@h)  [fldId], [fldCheckId],[fldStatus], [fldUserId], [fldIP],[fldDate] 
	,fldNameShakhs,fldMobile,fldTarikhSarResid,fldShomareSanad,fldBankName,fldShobeName
	,fldStatusName
	 from (select  s.[fldId], [fldCheckId], s.[fldStatus], s.[fldUserId],  s.[fldIP], s.[fldDate] 
	,fldNameShakhs,isnull(ru.fldMobile,'')fldMobile,fldTarikhSarResid,fldShomareSanad,fldBankName,d2.fldName as fldShobeName
	,case when s.[fldStatus]=0 then N'ارسال نشده' when s.[fldStatus]=7 then N'7 روز ارسال شده' when s.[fldStatus]=1 then N'1 روز مانده' end  as fldStatusName
	,dbo.Fn_AssembelyShamsiToMiladiDate(fldTarikhSarResid) DataSarResid,c.fldStatus as fldStatusCheck
	FROM   [Drd].[tblCheck_Sms]  s
	inner join drd.tblcheck c on c.fldid=fldCheckId
	inner join com.tblShomareHesabeOmoomi s1 on s1.fldid=fldShomareHesabId
	inner join com.tblSHobe d2 on d2.fldid=s1.fldShobeId
	inner join com.tblBank b on b.fldid=d2.fldBankId
	inner join drd.tblReplyTaghsit r on r.fldid=c.fldReplyTaghsitId
	inner join drd.tblStatusTaghsit_Takhfif sr on sr.fldid=r.fldStatusId
	inner join drd.tblRequestTaghsit_Takhfif ru on ru.fldid=sr.fldRequestId 
cross apply 
					(
						select fldname+' '+fldFamily fldNameShakhs from com.tblEmployee
						inner join com.tblAshkhas a on tblEmployee.fldid=fldHaghighiId
						left join com.tblEmployee_Detail d on d.fldEmployeeId=tblEmployee.fldid
						where a.fldid=s1.fldAshkhasId
					union all
						select fldName fldNameShakhs  from com.tblAshkhaseHoghoghi
						inner join com.tblAshkhas a on tblAshkhaseHoghoghi.fldid=fldHoghoghiId
						where a.fldid=s1.fldAshkhasId
					)shakhs
					where fldTypeSanad=0
)t
					where ([fldStatus]=0 or [fldStatus]=7) and DATEDIFF(day,getdate(),DataSarResid)=1
					and fldStatusCheck=1
	COMMIT
GO
