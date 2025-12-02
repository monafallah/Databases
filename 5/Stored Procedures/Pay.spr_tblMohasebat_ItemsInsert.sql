SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_ItemsInsert] 

    @fldMohasebatId int,
    @fldItemEstekhdamId int,
    @fldMablagh int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldTarikh nvarchar(10),
	@fldAnvaeEstekhdamId int,
	@fldTypeBimeId int,
	@fldSourceId int,
	@fldOrganId int,
	@fldCalcType tinyint=1
AS 
	
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int ,@FiscalHeaderId int,@Maliyat bit=0,@HeaderId int,@Bime bit=0

	SELECT    TOP(1)    @FiscalHeaderId=fldId 
                  FROM            Pay.tblFiscal_Header 
                 WHERE (fldEffectiveDate)<=@fldTarikh
                  ORDER BY fldDateOfIssue DESC,fldEffectiveDate DESC

	if exists( select * from pay.tblFiscalTitle WHERE fldFiscalHeaderId=@FiscalHeaderId and fldItemEstekhdamId=@fldItemEstekhdamId and fldAnvaEstekhdamId=@fldAnvaeEstekhdamId)
		set @Maliyat=1

select TOP(1) @HeaderId=fldId from pay.tblMoteghayerhayeHoghoghi 
where fldAnvaeEstekhdamId=@fldAnvaeEstekhdamId and  fldTypeBimeId= @fldTypeBimeId AND (fldTarikhEjra)<=@fldTarikh
ORDER BY fldTarikhSodur DESC,fldTarikhEjra DESc

if exists(select * from pay.tblMoteghayerhayeHoghoghi_Detail where fldMoteghayerhayeHoghoghiId=@HeaderId and fldItemEstekhdamId=@fldItemEstekhdamId)
set @Bime=1

declare @PrsPersonalId INT,@fldShomareHesabId INT,@fldH_BankFixId INT,@employeeid INT,@AshkhasId INT,@fldHesabTypeItemId tinyint,@fldShomareHesabItemId int
,@fldIsMostamar tinyint

select @PrsPersonalId=p.fldPrs_PersonalInfoId from pay.tblMohasebat as m
inner join  pay.Pay_tblPersonalInfo as p on p.fldid=m.fldPersonalId where m.fldid=@fldMohasebatId

SELECT @fldH_BankFixId=fldH_BankFixId FROM Pay.tblSetting WHERE fldOrganId=@fldorganId
	SELECT @employeeid=fldEmployeeId FROM Prs.Prs_tblPersonalInfo WHERE fldId=@PrsPersonalId
	SELECT @AshkhasId=fldId FROM Com.tblAshkhas WHERE fldHaghighiId=@employeeid
    
	select @fldHesabTypeItemId=i.fldTypeHesabId,@fldIsMostamar=fldMostamar from com.tblItems_Estekhdam as e
	inner join com.tblItemsHoghughi as i on i.fldId=e.fldItemsHoghughiId
	where e.fldId=@fldItemEstekhdamId

SELECT @fldShomareHesabId=com.tblShomareHesabeOmoomi.fldId FROM com.tblShomareHesabeOmoomi INNER JOIN com.tblShomareHesabOmoomi_Detail  
	ON com.tblShomareHesabeOmoomi.fldId=com.tblShomareHesabOmoomi_Detail.fldShomareHesabId WHERE fldAshkhasId=@AshkhasId AND fldBankId=@fldH_BankFixId 
	 and fldHesabTypeId=@fldHesabTypeItemId

	-- select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblError] 
	--INSERT INTO [Com].[tblError] ([fldId], [fldUserName], [fldMatn], [fldTarikh], [fldIP], [fldUserId], [fldDesc], [fldDate])
	--SELECT @fldId, @fldH_BankFixId, @fldorganId, @fldTarikh, @AshkhasId, @fldUserId,@fldHesabTypeItemId , GETDATE()

select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMohasebat_Items] 
	INSERT INTO [Pay].[tblMohasebat_Items] ([fldId], [fldMohasebatId], [fldItemEstekhdamId], [fldMablagh], [fldUserId], [fldDesc], [fldDate],fldMaliyatMashmool,fldBimeMashmool,fldSourceId,fldHesabTypeItemId,fldShomareHesabItemId,fldMostamar)
	SELECT @fldId, @fldMohasebatId, @fldItemEstekhdamId, @fldMablagh, @fldUserId, @fldDesc, GETDATE(),@Maliyat,@Bime,@fldSourceId,@fldHesabTypeItemId,@fldShomareHesabId,@fldIsMostamar
	if (@@ERROR<>0)
		ROLLBACK
	--fldCalcType=1  محاسبات اصلی
	--fldCalcType=2  محاسبات فرعی
	else if(@fldCalcType=2)
	begin
		declare @fldPersonalId int, @fldYear smallint, @fldMonth tinyint,@mablagh int
		select @fldPersonalId=fldPersonalId,@fldYear=fldYear,@fldMonth=fldMonth from pay.tblMohasebat where fldid=@fldMohasebatId

		select @mablagh=@fldMablagh-i.fldMablagh from pay.tblMohasebat as m
		inner join [Pay].[tblMohasebat_Items]as i on i.fldMohasebatId=m.fldId
		where fldPersonalId=@fldPersonalId and fldYear=@fldYear and fldMonth=@fldMonth and i.fldItemEstekhdamId=@fldItemEstekhdamId and fldCalcType=1

		select @fldID =ISNULL(max(fldId),0)+1 from [Pay].tblMohasebat_ItemMotamam 
		if(@mablagh<>0)
		begin
			INSERT INTO [Pay].tblMohasebat_ItemMotamam ([fldId], [fldMohasebatId], [fldItemEstekhdamId], [fldMablagh],fldMaliyatMashmool,fldBimeMashmool,fldSourceId,fldHesabTypeItemId,fldShomareHesabItemId,fldMostamar)
			SELECT @fldId, @fldMohasebatId, @fldItemEstekhdamId, @mablagh, @Maliyat,@Bime,@fldSourceId,@fldHesabTypeItemId,@fldShomareHesabId,@fldIsMostamar
			if (@@ERROR<>0)
				ROLLBACK
		end
	end
	COMMIT
GO
