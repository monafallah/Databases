SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Com].[spr_Pre_UpdateHoghogh]
as
begin
---------------------------------------acc
------------------ACC.tblTemplateCoding
--1705	/1/1/1/9/	4	/1/1/1/9/	NULL	بانک ها	1101	1	110103	3	15		2024-06-02 08:35:46.710	192.168.1.17	1	1	NULL	0	4
--1706	/1/1/1/10/	4	/1/1/1/10/	NULL	حساب موقت بانکی	1101	1	110107	3	15		2024-06-02 08:43:05.167	192.168.1.17	1	1	NULL	0	4

------------------ACC.tblCoding_Details
--1740	/1/1/1/9/	4	/1/1/1/9/	3	1101	1705	بانک ها	110103	20		2024-06-02 08:41:28.417	192.168.1.17	1	1	1	NULL	4
--1741	/1/1/1/10/	4	/1/1/1/10/	3	1101	1706	حساب موقت بانکی	110107	20		2024-06-02 08:41:52.790	192.168.1.17	1	1	1	NULL	4

--------------------------------
update   ACC.tblCoding_Details set fldTitle =N'تنخواه گردان کارپردازی'
where fldCode in ('110102001')



------------------------------------------

if(not exists (select * from [Com].[tblHistoryTahsilat]))
begin
declare @fldID int 
	select @fldID =ISNULL(max(fldId),0) from [Com].[tblHistoryTahsilat] 
	INSERT INTO [Com].[tblHistoryTahsilat] ([fldId], [fldEmployeeId], [fldMadrakId], [fldReshteId], [fldTarikh], [fldUserId], [fldDesc], [fldDate])
select @fldID+ROW_NUMBER() over (order by fldEmployeeId),fldEmployeeId,fldMadrakId,fldReshteId,dbo.Fn_AssembelyMiladiToShamsi(fldDate),fldUserId,'',fldDate from com.tblEmployee_Detail
where fldMadrakId is not null and fldReshteId is not null
end

if(not exists (select * from [Pay].[tblMaxBime]))
begin
INSERT [Pay].[tblMaxBime] ([fldId], [fldYear], [fldMablaghBime], [fldUserId], [fldDate], [fldIp]) VALUES (1, 1402, 12385996, 1, CAST(N'2023-11-29T11:45:49.717' AS DateTime), N'::1')
INSERT [Pay].[tblMaxBime] ([fldId], [fldYear], [fldMablaghBime], [fldUserId], [fldDate], [fldIp]) VALUES (2, 1401, 9752750, 1, CAST(N'2023-11-29T11:45:49.717' AS DateTime), N'::1')
INSERT [Pay].[tblMaxBime] ([fldId], [fldYear], [fldMablaghBime], [fldUserId], [fldDate], [fldIp]) VALUES (3, 1403, 16721096, 1, CAST(N'2023-11-29T11:45:49.717' AS DateTime), N'::1')

end
if(not exists (select * from [Com].[tblGeneralSetting]))
begin
INSERT [Com].[tblGeneralSetting] ([fldId], [fldName], [fldValue], [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldModuleId], [fldFormulId]) VALUES (1, N'تهیه دیسکت بیمه', N'1', 1, N'', CAST(N'2022-12-18T23:12:28.583' AS DateTime), 1, 3, NULL)
INSERT [Com].[tblGeneralSetting] ([fldId], [fldName], [fldValue], [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldModuleId], [fldFormulId]) VALUES (2, N'تاریخ', N'1410/01/01', 1, N'', CAST(N'2023-01-03T22:46:42.533' AS DateTime), 1, NULL, NULL)
INSERT [Com].[tblGeneralSetting] ([fldId], [fldName], [fldValue], [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldModuleId], [fldFormulId]) VALUES (3, N'نمایش عنوان حساب', N'', 1, N'', CAST(N'2023-06-13T13:16:03.263' AS DateTime), 1, 4, NULL)
INSERT [Com].[tblGeneralSetting] ([fldId], [fldName], [fldValue], [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldModuleId], [fldFormulId]) VALUES (4, N'چک کردن مانده', N'', 1, N'', CAST(N'2023-01-03T22:47:48.177' AS DateTime), 1, 4, NULL)
INSERT [Com].[tblGeneralSetting] ([fldId], [fldName], [fldValue], [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldModuleId], [fldFormulId]) VALUES (5, N'اجباری بودن شماره بایگانی', N'', 1, N'', CAST(N'2023-06-13T13:11:50.153' AS DateTime), 1, 4, NULL)
INSERT [Com].[tblGeneralSetting_Value] ([fldId], [fldGeneralSettingId], [fldValue], [fldUserId], [fldDesc], [fldDate], [fldOrganId]) VALUES (1, 1, N'1', 1, N' ', CAST(N'2023-01-02T23:51:28.620' AS DateTime), 1)
INSERT [Com].[tblGeneralSetting_Value] ([fldId], [fldGeneralSettingId], [fldValue], [fldUserId], [fldDesc], [fldDate], [fldOrganId]) VALUES (2, 2, N'1410/01/01', 1, N'', CAST(N'2023-01-03T22:46:42.533' AS DateTime), 1)
INSERT [Com].[tblGeneralSetting_Value] ([fldId], [fldGeneralSettingId], [fldValue], [fldUserId], [fldDesc], [fldDate], [fldOrganId]) VALUES (3, 3, N'0', 1, N'', CAST(N'2023-06-13T13:16:03.263' AS DateTime), 1)
INSERT [Com].[tblGeneralSetting_Value] ([fldId], [fldGeneralSettingId], [fldValue], [fldUserId], [fldDesc], [fldDate], [fldOrganId]) VALUES (4, 4, N'1', 1, N'', CAST(N'2023-01-03T22:47:48.190' AS DateTime), 1)
INSERT [Com].[tblGeneralSetting_Value] ([fldId], [fldGeneralSettingId], [fldValue], [fldUserId], [fldDesc], [fldDate], [fldOrganId]) VALUES (5, 5, N'1', 1, N'', CAST(N'2023-06-13T13:11:50.153' AS DateTime), 1)
INSERT [Com].[tblGeneralSetting_Value] ([fldId], [fldGeneralSettingId], [fldValue], [fldUserId], [fldDesc], [fldDate], [fldOrganId]) VALUES (6, 3, N'1', 1, N'  ', CAST(N'2023-05-24T09:35:18.143' AS DateTime), 2)
INSERT [Com].[tblGeneralSetting_Value] ([fldId], [fldGeneralSettingId], [fldValue], [fldUserId], [fldDesc], [fldDate], [fldOrganId]) VALUES (7, 4, N'1', 1, N' ', CAST(N'2023-05-24T09:36:02.847' AS DateTime), 2)
INSERT [Com].[tblGeneralSetting_Value] ([fldId], [fldGeneralSettingId], [fldValue], [fldUserId], [fldDesc], [fldDate], [fldOrganId]) VALUES (8, 5, N'0', 1, N'', CAST(N'2023-05-24T10:11:39.600' AS DateTime), 2)
end
if(not exists (select * from [Com].[tblHesabType]))
begin
INSERT [Com].[tblHesabType] ([fldId], [fldTitle], [fldType]) VALUES (1, N'بن کارت', 1)
INSERT [Com].[tblHesabType] ([fldId], [fldTitle], [fldType]) VALUES (2, N'حقوق', 2)
end
if(not exists (select * from [Com].[tblRaste]))
begin
SET IDENTITY_INSERT [Com].[tblRaste] ON 

INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (1, 0, N'-', N'-')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (2, 1, N'آموزشی وفرهنگی', N'اموزشیوفرهنگی')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (3, 2, N'اداری ومالی', N'اداریومالی')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (4, 3, N'اموراجتماعی', N'اموراجتماعی')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (5, 4, N'بهداشتی ودرمانی', N'بهداشتیودرمانی')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (6, 5, N'خدمات', N'خدمات')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (7, 6, N'کشاورزی و محیط زیست', N'کشاورزیومحیطزیست')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (8, 7, N'فنی ومهندسی', N'فنیومهندسی')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (9, 8, N'فن آوری اطلاعات', N'فناوریاطلاعات')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (10, 9, N'قضایی', N'قضایی')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (11, 10, N'هیئت علمی', N'هیئتعلمی')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (12, 11, N'مقامات', N'مقامات')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (13, 12, N'سیاسی', N'سیاسی')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (14, 13, N'فرآوری داده ها', N'فراوریدادهها')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (15, 1001, N'آموزشی فرهنگی', N'اموزشیفرهنگی')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (16, 1002, N'اداری مالی', N'اداریمالی')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (17, 1003, N'امور و اجتماعی', N'امورواجتماعی')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (18, 1004, N'بهداشتی درمانی', N'بهداشتیدرمانی')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (19, 1005, N'خدماتی', N'خدماتی')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (20, 1006, N'کشاورزی', N'کشاورزی')
INSERT [Com].[tblRaste] ([fldId], [fldCode], [fldText], [fldIndex]) VALUES (21, 1007, N'فنی مهندسی', N'فنیمهندسی')
SET IDENTITY_INSERT [Com].[tblRaste] OFF

end
if(not exists (select * from [Com].[tblTypeEstekhdam_Formul]))
begin
INSERT [Com].[tblTypeEstekhdam_Formul] ([fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate]) VALUES (1, N'کارگری', 1, N'', CAST(N'2023-02-22T12:46:25.157' AS DateTime))
INSERT [Com].[tblTypeEstekhdam_Formul] ([fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate]) VALUES (2, N'کارمند رسمی', 1, N'', CAST(N'2023-02-22T12:46:48.297' AS DateTime))
INSERT [Com].[tblTypeEstekhdam_Formul] ([fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate]) VALUES (3, N'کارمند غیر رسمی', 1, N'', CAST(N'2023-02-22T12:47:31.637' AS DateTime))
INSERT [Com].[tblTypeEstekhdam_Formul] ([fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate]) VALUES (4, N'شهردار', 1, N'', CAST(N'2023-02-22T12:49:37.887' AS DateTime))
end

update pay.tblMohasebat set fldMaliyatType=1

update com.tblShomareHesabOmoomi_Detail set fldHesabTypeId=1
where fldTypeHesab=1

update com.tblShomareHesabOmoomi_Detail set fldHesabTypeId=2
where fldTypeHesab=0

update pay.tblMohasebat set fldHesabTypeId=2
update pay.tblMohasebat_Eydi set fldHesabTypeId=2
update pay.tblMohasebat_Mamuriyat set fldHesabTypeId=2
update pay.tblMohasebat_Morakhasi set fldHesabTypeId=2
update pay.tblMohasebatEzafeKari_TatilKari set fldHesabTypeId=2

--دسترسی نوع استخدام
declare @id int
select @id=max(fldid) from pay.tblTypeEstekhdam_UserGroup 
insert into pay.tblTypeEstekhdam_UserGroup (fldid,fldTypeEstekhamId,fldUseGroupId,fldOrganId,fldUserId,fldDesc,fldIP,fldDate)
select  distinct row_number()over (order by (select 1 ))+@id ,tblTypeEstekhdam.fldid,UserGroup.fldid,1,1,'','::1',getdate() from com.tblTypeEstekhdam
cross join (select u.fldid from com.tblPermission p
inner join com.tblApplicationPart a on p.fldApplicationPartID=a.fldid
inner join com.tblUserGroup_ModuleOrgan um on um.fldid=p.fldUserGroup_ModuleOrganID
inner join com.tblUserGroup u on u.fldid=um.fldUserGroupId
where a.fldTitle like N'%حکم%' 
group by u.fldid
)UserGroup
-- tblTypeEstekhdam.fldid<>4/*shahrdar*/and
where not exists (select * from pay.tblTypeEstekhdam_UserGroup where fldTypeEstekhamId=tblTypeEstekhdam.fldid and UserGroup.fldid=fldUseGroupId)

update com.tblItemsHoghughi set fldTypeHesabId=2

update com.tblItemsHoghughi set fldMostamar=1

update com.tblItemsHoghughi set fldMostamar=2
where fldid in (33,34,35,36,55,64,67,68)

update m set fldMostamar=i.fldMostamar  from  pay.tblMohasebat_Items as m
inner join com.tblItems_Estekhdam as e on e.fldId=m.fldItemEstekhdamId
inner join com.tblItemsHoghughi as i on i.fldId=e.fldItemsHoghughiId

update m set fldMostamar=i.fldMostamar  from  pay.tblMoavaghat_Items as m
inner join com.tblItems_Estekhdam as e on e.fldId=m.fldItemEstekhdamId
inner join com.tblItemsHoghughi as i on i.fldId=e.fldItemsHoghughiId

update pay.tblParametrs set fldHesabTypeParam=2,fldActive=1 ,fldPrivate=1
update pay.tblParametrs set fldIsMostamar=2

update m set fldIsMostamar=i.fldIsMostamar  from  pay.[tblMohasebat_kosorat/MotalebatParam] as m
inner join pay.tblMotalebateParametri_Personal as e on e.fldId=m.fldMotalebatId
inner join pay.tblParametrs as i on i.fldId=e.fldParametrId 

update i set fldHesabTypeparamId=m.fldHesabTypeId,fldShomareHesabparamId=p.fldShomareHesabId
from pay.tblMohasebat as m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
inner join pay.[tblMohasebat_kosorat/MotalebatParam] as i on i.fldMohasebatId=m.fldId
where fldHesabTypeId>2

--select m.fldHesabTypeId,p.fldShomareHesabId 
update i set fldHesabTypeItemId=m.fldHesabTypeId,fldShomareHesabItemId=p.fldShomareHesabId
from pay.tblMohasebat as m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
inner join pay.tblMohasebat_Items as i on i.fldMohasebatId=m.fldId
where fldHesabTypeId=2

--select m.fldHesabTypeId,p.fldShomareHesabId
update i set fldHesabTypeItemId=m.fldHesabTypeId,fldShomareHesabItemId=p.fldShomareHesabId
from pay.tblMohasebat as m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
inner join pay.tblMoavaghat as o on o.fldMohasebatId=m.fldId
inner join pay.tblMoavaghat_Items as i on i.fldMoavaghatId=o.fldId
where fldHesabTypeId=2

update pay.tblMohasebat_Eydi set fldFlag=1
update pay.tblMohasebat_Mamuriyat set fldFlag=1
update pay.tblMohasebatEzafeKari_TatilKari set fldFlag=1
update pay.tblMohasebat_Morakhasi set fldFlag=1
update pay.tblEtelaatEydi set fldFlag=1
update pay.tblMamuriyat set fldFlag=1
update pay.tblEzafeKari_TatilKari set fldFlag=1
update pay.tblMorakhasi set fldFlag=1
update pay.tblKomakGheyerNaghdi set fldFlag=1
update pay.tblSayerPardakhts set fldFlag=1



update o set fldMaliyat=0
--fldMaliyatCalc=o.fldMaliyat
--select o.fldMaliyat 
from pay.tblMohasebat as m
inner join pay.tblMoavaghat as o on o.fldMohasebatId=m.fldId
where m.fldyear=1403 and m.fldmonth=1
end
GO
