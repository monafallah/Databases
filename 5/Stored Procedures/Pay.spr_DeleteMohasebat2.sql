SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Pay].[spr_DeleteMohasebat2](@FieldName NVARCHAR(50),@PersonalId INT,@Mah TINYINT,@Sal SMALLINT,@NobatPardakht TINYINT,@organid int)
AS
BEGIN
DECLARE @id INT,@t NVARCHAR(max)='',@flag bit=0,@MohasebatId int
IF(@FieldName='Hoghogh_Personal')
BEGIN
declare @tt table(id int)
insert into @tt
SELECT fldId FROM Pay.tblMohasebat WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht

DELETE FROM Pay.tblMohasebat_PersonalInfo WHERE fldMohasebatId in(select * from @tt)--= @MohasebatId
if(@@ERROR<>0)
begin 
	set @flag=1
	rollback
end
if(@flag=0)
begin
DELETE FROM Pay.tblMohasebat_Items WHERE fldMohasebatId  in(select * from @tt)--in (@MohasebatId)
	if(@@ERROR<>0)
	begin 
	set @flag=1
	rollback
	end
end
if(@flag=0)
begin
DELETE FROM Pay.[tblMohasebat_kosorat/MotalebatParam] WHERE fldMohasebatId in(select * from @tt)--in(@MohasebatId)
	if(@@ERROR<>0)
	begin 
	set @flag=1
	rollback
	end
end
if(@flag=0)
begin
DELETE FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId in(select * from @tt)--in ( @MohasebatId)
	if(@@ERROR<>0)
	begin 
	set @flag=1
	rollback
	end
end
if(@flag=0)
begin
DELETE FROM Pay.tblMoavaghat_Items WHERE fldMoavaghatId IN (SELECT fldId FROM Pay.tblMoavaghat WHERE fldMohasebatId in(select * from @tt))
	if(@@ERROR<>0)
	begin 
	set @flag=1
	rollback
	end
end
if(@flag=0)
begin
DELETE FROM Pay.tblMoavaghat WHERE fldMohasebatId  in(select * from @tt)-- in (@MohasebatId)
	if(@@ERROR<>0)
	begin 
	set @flag=1
	rollback
	end
end
if(@flag=0)
begin
DELETE FROM Pay.tblMohasebat WHERE fldid in(select * from @tt)--in (@MohasebatId)
	if(@@ERROR<>0)
	begin 
	set @flag=1
	rollback
	end
end
end
IF(@FieldName='EzafeKar_Personal')
BEGIN
DELETE FROM Pay.tblMohasebat_PersonalInfo WHERE fldEzafe_TatilKariId IN (SELECT fldId FROM Pay.tblMohasebatEzafeKari_TatilKari WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=1)
DELETE FROM Pay.tblMohasebatEzafeKari_TatilKari WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=1
END 
IF(@FieldName='TatilKar_Personal')
BEGIN
DELETE FROM Pay.tblMohasebat_PersonalInfo WHERE fldEzafe_TatilKariId IN (SELECT fldId FROM Pay.tblMohasebatEzafeKari_TatilKari WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=2)
DELETE FROM Pay.tblMohasebatEzafeKari_TatilKari WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=2
END 
IF(@FieldName='Morakhasi_Personal')
BEGIN
DELETE FROM Pay.tblMohasebat_PersonalInfo  WHERE fldMorakhasiId =(SELECT fldId FROM Pay.tblMohasebat_Morakhasi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht)
DELETE FROM Pay.tblMohasebat_Morakhasi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht
END
IF(@FieldName='Mamooriyat_Personal')
BEGIN 
DELETE FROM tblMohasebat_PersonalInfo WHERE fldMamuriyatId=(SELECT fldId FROM Pay.tblMohasebat_Mamuriyat WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah )
DELETE FROM Pay.tblMohasebat_Mamuriyat WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah 
end
IF(@FieldName='Eydi_Personal')
BEGIN  
DELETE FROM tblMohasebat_PersonalInfo WHERE fldMohasebatEydiId=(SELECT fldId FROM Pay.tblMohasebat_Eydi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal /*AND fldMonth=@Mah*/ AND fldNobatPardakht=@NobatPardakht)
DELETE FROM Pay.tblMohasebat_Eydi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal /*AND fldMonth=@Mah*/ AND fldNobatPardakht=@NobatPardakht
END 

IF(@FieldName='Hoghogh')
BEGIN
DELETE FROM Pay.tblMohasebat_PersonalInfo WHERE fldMohasebatId IN (SELECT fldid from Pay.tblMohasebat  WHERE fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat.fldPersonalId)=@organid)
DELETE FROM Pay.tblMohasebat_Items WHERE fldMohasebatId IN (SELECT fldid from Pay.tblMohasebat  WHERE fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat.fldPersonalId)=@organid)
DELETE FROM Pay.[tblMohasebat_kosorat/MotalebatParam] WHERE fldMohasebatId IN (SELECT fldid from Pay.tblMohasebat  WHERE fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat.fldPersonalId)=@organid)
DELETE FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId  IN (SELECT fldid from Pay.tblMohasebat  WHERE fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat.fldPersonalId)=@organid)
DELETE FROM Pay.tblMoavaghat_Items WHERE fldMoavaghatId IN (SELECT fldId FROM tblMoavaghat WHERE fldMohasebatId  IN (SELECT fldid from Pay.tblMohasebat  WHERE fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat.fldPersonalId)=@organid))
DELETE FROM Pay.tblMoavaghat WHERE fldMohasebatId   IN (SELECT fldid from Pay.tblMohasebat  WHERE fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat.fldPersonalId)=@organid)
DELETE FROM Pay.tblMohasebat WHERE  fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat.fldPersonalId)=@organid
end
IF(@FieldName='EzafeKar')
BEGIN

DELETE FROM Pay.tblMohasebat_PersonalInfo WHERE fldEzafe_TatilKariId IN (SELECT fldId FROM  Pay.tblMohasebatEzafeKari_TatilKari  WHERE  fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=1and com.fn_organIdWithPayPersonal(Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId)=@organid)
DELETE FROM Pay.tblMohasebatEzafeKari_TatilKari WHERE  fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=1 and com.fn_organIdWithPayPersonal(Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId)=@organid
END 
IF(@FieldName='TatilKar')
BEGIN
DELETE FROM Pay.tblMohasebat_PersonalInfo WHERE fldEzafe_TatilKariId IN (SELECT fldId FROM  Pay.tblMohasebatEzafeKari_TatilKari  WHERE  fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=2and com.fn_organIdWithPayPersonal(Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId)=@organid)
DELETE FROM Pay.tblMohasebatEzafeKari_TatilKari WHERE fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=2and com.fn_organIdWithPayPersonal(Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId)=@organid
END 
IF(@FieldName='Morakhasi')
BEGIN
DELETE FROM Pay.tblMohasebat_PersonalInfo  WHERE fldMorakhasiId IN (SELECT fldId  FROM Pay.tblMohasebat_Morakhasi WHERE  fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat_Morakhasi.fldPersonalId)=@organid)
DELETE FROM Pay.tblMohasebat_Morakhasi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat_Morakhasi.fldPersonalId)=@organid
END
IF(@FieldName='Mamooriyat')
BEGIN
DELETE FROM tblMohasebat_PersonalInfo WHERE fldMamuriyatId IN (SELECT fldId FROM Pay.tblMohasebat_Mamuriyat WHERE  fldYear=@Sal AND fldMonth=@Mah and com.fn_organIdWithPayPersonal(Pay.tblMohasebat_Mamuriyat.fldPersonalId)=@organid)
DELETE FROM Pay.tblMohasebat_Mamuriyat WHERE fldYear=@Sal AND fldMonth=@Mah and com.fn_organIdWithPayPersonal(Pay.tblMohasebat_Mamuriyat.fldPersonalId)=@organid
end
IF(@FieldName='Eydi')
BEGIN
DELETE FROM tblMohasebat_PersonalInfo WHERE fldMohasebatEydiId IN (SELECT fldId FROM Pay.tblMohasebat_Eydi WHERE  fldYear=@Sal /*AND fldMonth=@Mah */AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat_Eydi.fldPersonalId)=@organid)
DELETE FROM Pay.tblMohasebat_Eydi WHERE  fldYear=@Sal /*AND fldMonth=@Mah*/ AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat_Eydi.fldPersonalId)=@organid
END 

END
GO
