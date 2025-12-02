SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Drd].[spr_ElamAvarelog](@ElamAvarezId int)
as
select dbo.Fn_AssembelyMiladiToShamsi(Drd_tblElamAvarez_CT.fldDate)as fldTarikh,cast(cast(Drd_tblElamAvarez_CT.fldDate as time(3)) as nvarchar(20))as fldtime,case when __$operation=2 then N'اعلام عوارض' when __$operation=4 then N'ویرایش اعلام عوارض' end as fldTypeEghdam,
tblEmployee.fldName+' '+tblEmployee.fldFamily+'('+tblEmployee.fldCodemeli+')' as fldUser
 from cdc.Drd_tblElamAvarez_CT
inner join com.tblUser on tblUser.fldId=Drd_tblElamAvarez_CT.fldUserId
inner join com.tblEmployee on tblEmployee.fldId=tblUser.fldEmployId
where Drd_tblElamAvarez_CT.fldid=@ElamAvarezId and __$operation in(2,4)
union
select fldTarikh,cast(cast(tblSodoorFish.fldDate  as time(3)) as nvarchar(20)),N'صدور فیش'+cast(tblSodoorFish.fldId as nvarchar(max)),
tblEmployee.fldName+' '+tblEmployee.fldFamily+'('+tblEmployee.fldCodemeli+')' as fldUser
from drd.tblSodoorFish
inner join com.tblUser on tblUser.fldId=tblSodoorFish.fldUserId
inner join com.tblEmployee on tblEmployee.fldId=tblUser.fldEmployId
where tblSodoorFish.fldElamAvarezId=@ElamAvarezId
union
select dbo.Fn_AssembelyMiladiToShamsi(tblEbtal.fldDate),cast(cast(tblEbtal.fldDate as time(3)) as nvarchar(20)),N'ابطال فیش شماره'+cast(tblEbtal.fldFishId as nvarchar(max)),
tblEmployee.fldName+' '+tblEmployee.fldFamily+'('+tblEmployee.fldCodemeli+')' as fldUser
from drd.tblEbtal
inner join com.tblUser on tblUser.fldId=tblEbtal.fldUserId
inner join com.tblEmployee on tblEmployee.fldId=tblUser.fldEmployId
where fldFishId in(select fldid from drd.tblSodoorFish where tblSodoorFish.fldElamAvarezId=@ElamAvarezId)
union
select dbo.Fn_AssembelyMiladiToShamsi(tblPardakhtFish.fldDate),cast(cast(tblPardakhtFish.fldDate as time(3)) as nvarchar(20)),N'پرداخت فیش شماره'+cast(tblPardakhtFish.fldFishId as nvarchar(max)),
tblEmployee.fldName+' '+tblEmployee.fldFamily+'('+tblEmployee.fldCodemeli+')' as fldUser
from drd.tblPardakhtFish
inner join com.tblUser on tblUser.fldId=tblPardakhtFish.fldUserId
inner join com.tblEmployee on tblEmployee.fldId=tblUser.fldEmployId
where fldFishId in(select fldid from drd.tblSodoorFish where tblSodoorFish.fldElamAvarezId=@ElamAvarezId)
union
select dbo.Fn_AssembelyMiladiToShamsi(tblRequestTaghsit_Takhfif.fldDate),cast(cast(tblRequestTaghsit_Takhfif.fldDate as time(3)) as nvarchar(20)),
case when fldRequestType=2 then N'ثبت درخواست تخفیف' else N'ثبت درخواست تقسیط' end,
tblEmployee.fldName+' '+tblEmployee.fldFamily+'('+tblEmployee.fldCodemeli+')' as fldUser
from drd.tblRequestTaghsit_Takhfif
inner join com.tblUser on tblUser.fldId=tblRequestTaghsit_Takhfif.fldUserId
inner join com.tblEmployee on tblEmployee.fldId=tblUser.fldEmployId
where fldElamAvarezId=@ElamAvarezId
union
select dbo.Fn_AssembelyMiladiToShamsi(drd_tblReplyTakhfif_CT.fldDate),cast(cast(drd_tblReplyTakhfif_CT.fldDate as time(3)) as nvarchar(20)),
case when __$operation=2 then N'ثبت پاسخ تخفیف' when __$operation=4 then N'ویرایش پاسخ تخفیف' end,
tblEmployee.fldName+' '+tblEmployee.fldFamily+'('+tblEmployee.fldCodemeli+')' as fldUser 
from cdc.drd_tblReplyTakhfif_CT
inner join com.tblUser on tblUser.fldId=drd_tblReplyTakhfif_CT.fldUserId
inner join com.tblEmployee on tblEmployee.fldId=tblUser.fldEmployId
where fldStatusId in(select fldid from drd.tblStatusTaghsit_Takhfif
 where fldRequestId in(select fldid from drd.tblRequestTaghsit_Takhfif where fldElamAvarezId=@ElamAvarezId)
)and __$operation in(2,4)
union
select dbo.Fn_AssembelyMiladiToShamsi(tblReplyTaghsit.fldDate),cast(cast(tblReplyTaghsit.fldDate as time(3)) as nvarchar(20)),N'ثبت پاسخ تقسیط',
tblEmployee.fldName+' '+tblEmployee.fldFamily+'('+tblEmployee.fldCodemeli+')' as fldUser 
from drd.tblReplyTaghsit
inner join com.tblUser on tblUser.fldId=tblReplyTaghsit.fldUserId
inner join com.tblEmployee on tblEmployee.fldId=tblUser.fldEmployId
where fldStatusId in(select fldid from drd.tblStatusTaghsit_Takhfif
 where fldRequestId in(select fldid from drd.tblRequestTaghsit_Takhfif where fldElamAvarezId=@ElamAvarezId)
)
union
select dbo.Fn_AssembelyMiladiToShamsi(drd_tblCheck_CT.fldDate),cast(cast(drd_tblCheck_CT.fldDate as time(3)) as nvarchar(20)),
case when __$operation=2 then N'ثبت چک شماره '+fldShomareSanad when __$operation=4 then CASE 
WHEN drd_tblCheck_CT.fldStatus = 2 THEN N'ثبت وصول چک '+fldShomareSanad
 WHEN drd_tblCheck_CT.fldStatus = 3 THEN N'ثبت برگشتی چک '+fldShomareSanad 
WHEN drd_tblCheck_CT.fldStatus = 4 THEN N'ثبت حقوقی چک'+fldShomareSanad WHEN drd_tblCheck_CT.fldStatus
                   = 5 THEN N'عودت چک'+fldShomareSanad END end,
tblEmployee.fldName+' '+tblEmployee.fldFamily+'('+tblEmployee.fldCodemeli+')' as fldUser 
from cdc.drd_tblCheck_CT
inner join com.tblUser on tblUser.fldId=drd_tblCheck_CT.fldUserId
inner join com.tblEmployee on tblEmployee.fldId=tblUser.fldEmployId
where drd_tblCheck_CT.fldReplyTaghsitId in(select fldid from drd.tblReplyTaghsit where fldStatusId in(select fldid from drd.tblStatusTaghsit_Takhfif
 where fldRequestId in(select fldid from drd.tblRequestTaghsit_Takhfif where fldElamAvarezId=@ElamAvarezId)))
 and __$operation in(2,4)
GO
