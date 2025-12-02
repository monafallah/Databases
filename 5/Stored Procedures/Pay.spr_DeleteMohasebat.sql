SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_DeleteMohasebat](@FieldName NVARCHAR(50),@PersonalId INT,@Mah TINYINT,@Sal SMALLINT,@NobatPardakht TINYINT,@organid int,@CostCenterId varchar(max),@AnvaeEstekhdamId varchar(max),@CalcType TINYINT)
AS
BEGIN
DECLARE @id INT,@t NVARCHAR(max)='',@flag bit=0,@MohasebatId int
IF(@FieldName='Hoghogh_Personal')
BEGIN
declare @tt table(id int)
insert into @tt
SELECT fldId FROM Pay.tblMohasebat WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and fldCalcType=@CalcType and fldFlag=0

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
	delete  from pay.tblP_MaliyatManfi 
	WHERE fldMohasebeId  in(select * from @tt)
	if(@@ERROR<>0)
		begin 
		set @flag=1
		rollback
		end
end
if(@flag=0)
begin
	delete  from pay.tblMaliyatManfi 
	WHERE fldMohasebeId  in(select * from @tt)
	if(@@ERROR<>0)
		begin 
		set @flag=1
		rollback
		end
end
if(@flag=0 and @CalcType=2)
begin
	delete  from pay.tblMohasebat_ItemMotamam
	WHERE fldMohasebatId  in(select * from @tt)
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
DELETE FROM Pay.tblMohasebat_PersonalInfo WHERE fldEzafe_TatilKariId IN (SELECT fldId FROM Pay.tblMohasebatEzafeKari_TatilKari WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=1 and fldFlag=0)
DELETE FROM Pay.tblMohasebatEzafeKari_TatilKari WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=1 and fldFlag=0
END 
IF(@FieldName='TatilKar_Personal')
BEGIN
DELETE FROM Pay.tblMohasebat_PersonalInfo WHERE fldEzafe_TatilKariId IN (SELECT fldId FROM Pay.tblMohasebatEzafeKari_TatilKari WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=2 and fldFlag=0)
DELETE FROM Pay.tblMohasebatEzafeKari_TatilKari WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=2 and fldFlag=0
END 
IF(@FieldName='Morakhasi_Personal')
BEGIN
DELETE FROM Pay.tblMohasebat_PersonalInfo  WHERE fldMorakhasiId =(SELECT fldId FROM Pay.tblMohasebat_Morakhasi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and fldFlag=0)
DELETE FROM Pay.tblMohasebat_Morakhasi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and fldFlag=0
END
IF(@FieldName='Mamooriyat_Personal')
BEGIN 
DELETE FROM tblMohasebat_PersonalInfo WHERE fldMamuriyatId=(SELECT fldId FROM Pay.tblMohasebat_Mamuriyat WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah  and fldFlag=0)
DELETE FROM Pay.tblMohasebat_Mamuriyat WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah  and fldFlag=0
end
IF(@FieldName='Eydi_Personal')
BEGIN  
DELETE FROM tblMohasebat_PersonalInfo WHERE fldMohasebatEydiId=(SELECT fldId FROM Pay.tblMohasebat_Eydi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal /*AND fldMonth=@Mah*/ AND fldNobatPardakht=@NobatPardakht and fldFlag=0)
DELETE FROM Pay.tblMohasebat_Eydi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal /*AND fldMonth=@Mah*/ AND fldNobatPardakht=@NobatPardakht and fldFlag=0
END 

declare @m table (id int)
IF(@FieldName='Hoghogh')
BEGIN
insert @m
select m.fldId from pay.tblMohasebat as m
left join Pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
where fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(m.fldPersonalId)=@organid
 and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=p.fldAnvaEstekhdamId ))
 and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=p.fldCostCenterId ))
  and fldCalcType=@CalcType and fldFlag=0

DELETE FROM Pay.tblMohasebat_PersonalInfo WHERE fldMohasebatId IN (SELECT id from @m)
--WHERE fldMohasebatId IN (SELECT fldid from Pay.tblMohasebat  WHERE fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat.fldPersonalId)=@organid) 
DELETE FROM Pay.tblMohasebat_Items WHERE fldMohasebatId IN (SELECT id from @m)
--WHERE fldMohasebatId IN (SELECT fldid from Pay.tblMohasebat  WHERE fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat.fldPersonalId)=@organid)
DELETE FROM Pay.[tblMohasebat_kosorat/MotalebatParam] WHERE fldMohasebatId IN (SELECT id from @m)
--WHERE fldMohasebatId IN (SELECT fldid from Pay.tblMohasebat  WHERE fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat.fldPersonalId)=@organid)
DELETE FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId IN (SELECT id from @m)
--WHERE fldMohasebatId  IN (SELECT fldid from Pay.tblMohasebat  WHERE fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat.fldPersonalId)=@organid)
DELETE FROM Pay.tblMoavaghat_Items WHERE fldMoavaghatId IN (SELECT o.fldId from @m as m inner join pay.tblMoavaghat as o on o.fldMohasebatId=m.id)
--WHERE fldMoavaghatId IN (SELECT fldId FROM tblMoavaghat WHERE fldMohasebatId  IN (SELECT fldid from Pay.tblMohasebat  WHERE fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat.fldPersonalId)=@organid))
DELETE FROM Pay.tblMoavaghat WHERE fldMohasebatId IN (SELECT id from @m)
--WHERE fldMohasebatId   IN (SELECT fldid from Pay.tblMohasebat  WHERE fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat.fldPersonalId)=@organid)
delete  from pay.tblP_MaliyatManfi 	WHERE fldMohasebeId  IN (SELECT id from @m)
delete  from pay.tblMaliyatManfi 	WHERE fldMohasebeId  IN (SELECT id from @m)
if(@CalcType=2)
DELETE FROM Pay.tblMohasebat_ItemMotamam WHERE fldMohasebatId IN (SELECT id from @m)
DELETE FROM Pay.tblMohasebat WHERE fldId IN (SELECT id from @m)
--WHERE  fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat.fldPersonalId)=@organid
end
IF(@FieldName='EzafeKar')
BEGIN
insert @m
select m.fldId from pay.tblMohasebatEzafeKari_TatilKari as m
left join Pay.tblMohasebat_PersonalInfo as p on p.fldEzafe_TatilKariId=m.fldId
where fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=1 and com.fn_organIdWithPayPersonal(m.fldPersonalId)=@organid and fldFlag=0
 and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=p.fldAnvaEstekhdamId ))
 and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=p.fldCostCenterId )) 

DELETE FROM Pay.tblMohasebat_PersonalInfo  WHERE fldEzafe_TatilKariId IN (SELECT id from @m)
--WHERE fldEzafe_TatilKariId IN (SELECT fldId FROM  Pay.tblMohasebatEzafeKari_TatilKari  WHERE  fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=1and com.fn_organIdWithPayPersonal(Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId)=@organid)
DELETE FROM Pay.tblMohasebatEzafeKari_TatilKari WHERE fldId IN (SELECT id from @m)
--WHERE  fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=1 and com.fn_organIdWithPayPersonal(Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId)=@organid
END 
IF(@FieldName='TatilKar')
BEGIN
insert @m
select m.fldId from pay.tblMohasebatEzafeKari_TatilKari as m
left join Pay.tblMohasebat_PersonalInfo as p on p.fldEzafe_TatilKariId=m.fldId
where fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=2and com.fn_organIdWithPayPersonal(m.fldPersonalId)=@organid and fldFlag=0
 and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=p.fldAnvaEstekhdamId ))
 and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=p.fldCostCenterId ))

DELETE FROM Pay.tblMohasebat_PersonalInfo   WHERE fldEzafe_TatilKariId IN (SELECT id from @m)
--WHERE fldEzafe_TatilKariId IN (SELECT fldId FROM  Pay.tblMohasebatEzafeKari_TatilKari  WHERE  fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=2and com.fn_organIdWithPayPersonal(Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId)=@organid)
DELETE FROM Pay.tblMohasebatEzafeKari_TatilKari   WHERE fldId IN (SELECT id from @m)
--WHERE fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=2and com.fn_organIdWithPayPersonal(Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId)=@organid
END 
IF(@FieldName='Morakhasi')
BEGIN
insert @m
select m.fldId from pay.tblMohasebat_Morakhasi as m
left join Pay.tblMohasebat_PersonalInfo as p on p.fldMorakhasiId=m.fldId
where fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(m.fldPersonalId)=@organid and fldFlag=0
 and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=p.fldAnvaEstekhdamId ))
 and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=p.fldCostCenterId ))

DELETE FROM Pay.tblMohasebat_PersonalInfo   WHERE fldMorakhasiId IN (SELECT id from @m)
--WHERE fldMorakhasiId IN (SELECT fldId  FROM Pay.tblMohasebat_Morakhasi WHERE  fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat_Morakhasi.fldPersonalId)=@organid)
DELETE FROM Pay.tblMohasebat_Morakhasi WHERE fldId IN (SELECT id from @m)
--WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat_Morakhasi.fldPersonalId)=@organid
END
IF(@FieldName='Mamooriyat')
BEGIN
insert @m
select m.fldId from pay.tblMohasebat_Mamuriyat as m
left join Pay.tblMohasebat_PersonalInfo as p on p.fldMamuriyatId=m.fldId
where fldYear=@Sal AND fldMonth=@Mah and com.fn_organIdWithPayPersonal(m.fldPersonalId)=@organid and fldFlag=0
 and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=p.fldAnvaEstekhdamId ))
 and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=p.fldCostCenterId ))

DELETE FROM tblMohasebat_PersonalInfo  WHERE fldMamuriyatId IN (SELECT id from @m)
--WHERE fldMamuriyatId IN (SELECT fldId FROM Pay.tblMohasebat_Mamuriyat WHERE  fldYear=@Sal AND fldMonth=@Mah and com.fn_organIdWithPayPersonal(Pay.tblMohasebat_Mamuriyat.fldPersonalId)=@organid)
DELETE FROM Pay.tblMohasebat_Mamuriyat  WHERE fldId IN (SELECT id from @m)
--WHERE fldYear=@Sal AND fldMonth=@Mah and com.fn_organIdWithPayPersonal(Pay.tblMohasebat_Mamuriyat.fldPersonalId)=@organid
end
IF(@FieldName='Eydi')
BEGIN
insert @m
select m.fldId from pay.tblMohasebat_Eydi as m
left join Pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatEydiId=m.fldId
where fldYear=@Sal /*AND fldMonth=@Mah */AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(m.fldPersonalId)=@organid and fldFlag=0
 and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=p.fldAnvaEstekhdamId ))
 and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=p.fldCostCenterId ))

DELETE FROM tblMohasebat_PersonalInfo WHERE fldMohasebatEydiId IN (SELECT id from @m)
--WHERE fldMohasebatEydiId IN (SELECT fldId FROM Pay.tblMohasebat_Eydi WHERE  fldYear=@Sal /*AND fldMonth=@Mah */AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat_Eydi.fldPersonalId)=@organid)
DELETE FROM Pay.tblMohasebat_Eydi WHERE fldId IN (SELECT id from @m)
--WHERE  fldYear=@Sal /*AND fldMonth=@Mah*/ AND fldNobatPardakht=@NobatPardakht and com.fn_organIdWithPayPersonal(Pay.tblMohasebat_Eydi.fldPersonalId)=@organid
END 

IF(@FieldName='AllMohasebat_Personal')
BEGIN
set @Sal=SUBSTRING( dbo.Fn_AssembelyMiladiToShamsi(getdate()),1,4)
set @Mah=SUBSTRING( dbo.Fn_AssembelyMiladiToShamsi(getdate()),6,2)
insert into @tt
SELECT fldId FROM Pay.tblMohasebat WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah  and fldFlag=0  and fldCalcType=@CalcType 


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
if(@flag=0 and @CalcType=2)
begin
DELETE FROM Pay.tblMohasebat_ItemMotamam WHERE fldMohasebatId  in(select * from @tt)--in (@MohasebatId)
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
	delete  from pay.tblP_MaliyatManfi 
	WHERE fldMohasebeId  in(select * from @tt)
	if(@@ERROR<>0)
		begin 
		set @flag=1
		rollback
		end
end
if(@flag=0)
begin
	delete  from pay.tblMaliyatManfi 
	WHERE fldMohasebeId  in(select * from @tt)
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


DELETE FROM Pay.tblMohasebat_PersonalInfo WHERE fldEzafe_TatilKariId IN (SELECT fldId FROM Pay.tblMohasebatEzafeKari_TatilKari 
WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah and fldFlag=0)
DELETE FROM Pay.tblMohasebatEzafeKari_TatilKari WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah  and fldFlag=0


DELETE FROM Pay.tblMohasebat_PersonalInfo  WHERE fldMorakhasiId =(SELECT fldId FROM Pay.tblMohasebat_Morakhasi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah and fldFlag=0 )
DELETE FROM Pay.tblMohasebat_Morakhasi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah  and fldFlag=0


DELETE FROM tblMohasebat_PersonalInfo WHERE fldMamuriyatId=(SELECT fldId FROM Pay.tblMohasebat_Mamuriyat WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah and fldFlag=0)
DELETE FROM Pay.tblMohasebat_Mamuriyat WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah  and fldFlag=0
 
--DELETE FROM tblMohasebat_PersonalInfo WHERE fldMohasebatEydiId=(SELECT fldId FROM Pay.tblMohasebat_Eydi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal /*AND fldMonth=@Mah*/ )
--DELETE FROM Pay.tblMohasebat_Eydi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal /*AND fldMonth=@Mah*/ 

END 
IF(@FieldName='AllMohasebat_Personal_sal')
BEGIN

insert into @tt
SELECT fldId FROM Pay.tblMohasebat WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah  and fldFlag=0  --and fldCalcType=@CalcType

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
if(@flag=0 and @CalcType=2)
begin
DELETE FROM Pay.tblMohasebat_ItemMotamam WHERE fldMohasebatId  in(select * from @tt)--in (@MohasebatId)
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
	delete  from pay.tblP_MaliyatManfi 
	WHERE fldMohasebeId  in(select * from @tt)
	if(@@ERROR<>0)
		begin 
		set @flag=1
		rollback
		end
end
if(@flag=0)
begin
	delete  from pay.tblMaliyatManfi 
	WHERE fldMohasebeId  in(select * from @tt)
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


DELETE FROM Pay.tblMohasebat_PersonalInfo WHERE fldEzafe_TatilKariId IN (SELECT fldId FROM Pay.tblMohasebatEzafeKari_TatilKari 
WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah and fldFlag=0 )
DELETE FROM Pay.tblMohasebatEzafeKari_TatilKari WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah  and fldFlag=0


DELETE FROM Pay.tblMohasebat_PersonalInfo  WHERE fldMorakhasiId =(SELECT fldId FROM Pay.tblMohasebat_Morakhasi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah and fldFlag=0)
DELETE FROM Pay.tblMohasebat_Morakhasi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah  and fldFlag=0


DELETE FROM tblMohasebat_PersonalInfo WHERE fldMamuriyatId=(SELECT fldId FROM Pay.tblMohasebat_Mamuriyat WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah and fldFlag=0)
DELETE FROM Pay.tblMohasebat_Mamuriyat WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah  and fldFlag=0
 
--DELETE FROM tblMohasebat_PersonalInfo WHERE fldMohasebatEydiId=(SELECT fldId FROM Pay.tblMohasebat_Eydi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal /*AND fldMonth=@Mah*/ )
--DELETE FROM Pay.tblMohasebat_Eydi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal /*AND fldMonth=@Mah*/ 

END 



IF(@FieldName='AllMohasebat_sal')
BEGIN

insert into @tt
SELECT fldId FROM Pay.tblMohasebat WHERE  fldYear=@Sal AND fldMonth=@Mah  and fldFlag=0 and com.fn_organIdWithPayPersonal(fldPersonalId)=@organid --and fldCalcType=@CalcType

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
if(@flag=0 and @CalcType=2)
begin
DELETE FROM Pay.tblMohasebat_ItemMotamam WHERE fldMohasebatId  in(select * from @tt)--in (@MohasebatId)
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
	delete  from pay.tblP_MaliyatManfi 
	WHERE fldMohasebeId  in(select * from @tt)
	if(@@ERROR<>0)
		begin 
		set @flag=1
		rollback
		end
end
if(@flag=0)
begin
	delete  from pay.tblMaliyatManfi 
	WHERE fldMohasebeId  in(select * from @tt)
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


DELETE FROM Pay.tblMohasebat_PersonalInfo WHERE fldEzafe_TatilKariId IN (SELECT fldId FROM Pay.tblMohasebatEzafeKari_TatilKari 
WHERE  fldYear=@Sal AND fldMonth=@Mah and fldFlag=0) and fldOrganId=@organid
DELETE FROM Pay.tblMohasebatEzafeKari_TatilKari WHERE  fldYear=@Sal AND fldMonth=@Mah and com.fn_organIdWithPayPersonal(fldPersonalId)=@organid and fldFlag=0


DELETE FROM Pay.tblMohasebat_PersonalInfo  WHERE fldMorakhasiId in(SELECT fldId FROM Pay.tblMohasebat_Morakhasi WHERE  fldYear=@Sal AND fldMonth=@Mah   and fldFlag=0 )and fldOrganId=@organid
DELETE FROM Pay.tblMohasebat_Morakhasi WHERE  fldYear=@Sal AND fldMonth=@Mah  and com.fn_organIdWithPayPersonal(fldPersonalId)=@organid and fldFlag=0


DELETE FROM tblMohasebat_PersonalInfo WHERE fldMamuriyatId in(SELECT fldId FROM Pay.tblMohasebat_Mamuriyat WHERE  fldYear=@Sal AND fldMonth=@Mah   and fldFlag=0) and fldOrganId=@organid  
DELETE FROM Pay.tblMohasebat_Mamuriyat WHERE  fldYear=@Sal AND fldMonth=@Mah  and com.fn_organIdWithPayPersonal(fldPersonalId)=@organid and fldFlag=0
 
--DELETE FROM tblMohasebat_PersonalInfo WHERE fldMohasebatEydiId in(SELECT fldId FROM Pay.tblMohasebat_Eydi WHERE  fldYear=@Sal /*AND fldMonth=@Mah*/ ) and fldOrganId=@organid
--DELETE FROM Pay.tblMohasebat_Eydi WHERE  fldYear=@Sal /*AND fldMonth=@Mah*/  and com.fn_organIdWithPayPersonal(fldPersonalId)=@organid

END 

IF(@FieldName='AllMohasebat_Personal_Motalebat')
BEGIN

insert into @tt
SELECT m.fldId FROM Pay.tblMohasebat as m
inner join pay.[tblMohasebat_kosorat/MotalebatParam] as km on km.fldMohasebatId=m.fldId
WHERE  km.fldMotalebatId=@PersonalId and m.fldFlag=0  --and fldCalcType=@CalcType

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
if(@flag=0 and @CalcType=2)
begin
DELETE FROM Pay.tblMohasebat_ItemMotamam WHERE fldMohasebatId  in(select * from @tt)--in (@MohasebatId)
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
	delete  from pay.tblP_MaliyatManfi 
	WHERE fldMohasebeId  in(select * from @tt)
	if(@@ERROR<>0)
		begin 
		set @flag=1
		rollback
		end
end
if(@flag=0)
begin
	delete  from pay.tblMaliyatManfi 
	WHERE fldMohasebeId  in(select * from @tt)
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

END 

IF(@FieldName='AllMohasebat_Personal_Kosorat')
BEGIN

insert into @tt
SELECT m.fldId FROM Pay.tblMohasebat as m
inner join pay.[tblMohasebat_kosorat/MotalebatParam] as km on km.fldMohasebatId=m.fldId
WHERE  km.fldKosoratId=@PersonalId and m.fldFlag=0  --and fldCalcType=@CalcType

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
if(@flag=0 and @CalcType=2)
begin
DELETE FROM Pay.tblMohasebat_ItemMotamam WHERE fldMohasebatId  in(select * from @tt)--in (@MohasebatId)
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
	delete  from pay.tblP_MaliyatManfi 
	WHERE fldMohasebeId  in(select * from @tt)
	if(@@ERROR<>0)
		begin 
		set @flag=1
		rollback
		end
end
if(@flag=0)
begin
	delete  from pay.tblMaliyatManfi 
	WHERE fldMohasebeId  in(select * from @tt)
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

END 

END
GO
