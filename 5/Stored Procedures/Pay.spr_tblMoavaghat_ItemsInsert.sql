SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoavaghat_ItemsInsert] 
 
    @fldMoavaghatId int,
    @fldItemEstekhdamId int,
    @fldMablagh int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldTarikh nvarchar(10),
	@fldAnvaeEstekhdamId int,
	@fldTypeBimeId int,
	@fldSourceId int,
	@fldOrganId int
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

select top(1) @HeaderId=fldId from pay.tblMoteghayerhayeHoghoghi 
where fldAnvaeEstekhdamId=@fldAnvaeEstekhdamId and  fldTypeBimeId= @fldTypeBimeId AND (fldTarikhEjra)<=@fldTarikh
ORDER BY fldTarikhSodur DESC,fldTarikhEjra DESc


if exists(select * from pay.tblMoteghayerhayeHoghoghi_Detail where fldMoteghayerhayeHoghoghiId=@HeaderId and fldItemEstekhdamId=@fldItemEstekhdamId)
set @Bime=1

declare @PrsPersonalId INT,@fldShomareHesabId INT,@fldH_BankFixId INT,@employeeid INT,@AshkhasId INT,@fldHesabTypeItemId tinyint,@fldShomareHesabItemId int
,@fldIsMostamar tinyint

SELECT @fldH_BankFixId=fldH_BankFixId FROM Pay.tblSetting WHERE fldOrganId=@fldorganId
	SELECT @employeeid=fldEmployeeId FROM Prs.Prs_tblPersonalInfo WHERE fldId=@PrsPersonalId
	SELECT @AshkhasId=fldId FROM Com.tblAshkhas WHERE fldHaghighiId=@employeeid
    
	select @fldHesabTypeItemId=i.fldTypeHesabId,@fldIsMostamar=fldMostamar from com.tblItems_Estekhdam as e
	inner join com.tblItemsHoghughi as i on i.fldId=e.fldItemsHoghughiId
	where e.fldId=@fldItemEstekhdamId

SELECT @fldShomareHesabId=com.tblShomareHesabeOmoomi.fldId FROM com.tblShomareHesabeOmoomi INNER JOIN com.tblShomareHesabOmoomi_Detail  
	ON com.tblShomareHesabeOmoomi.fldId=com.tblShomareHesabOmoomi_Detail.fldShomareHesabId WHERE fldAshkhasId=@AshkhasId AND fldBankId=@fldH_BankFixId 
	 and fldHesabTypeId=@fldHesabTypeItemId

	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMoavaghat_Items] 
	INSERT INTO [Pay].[tblMoavaghat_Items] ([fldId], [fldMoavaghatId], [fldItemEstekhdamId], [fldMablagh], [fldUserId], [fldDesc], [fldDate],fldMaliyatMashmool,fldBimeMashmool,fldHesabTypeItemId,fldShomareHesabItemId,fldSourceId,fldMostamar)
	SELECT @fldId, @fldMoavaghatId, @fldItemEstekhdamId, @fldMablagh, @fldUserId, @fldDesc, GETDATE()	,@Maliyat,@Bime,@fldHesabTypeItemId,@fldShomareHesabId,@fldSourceId,@fldIsMostamar
	IF (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
