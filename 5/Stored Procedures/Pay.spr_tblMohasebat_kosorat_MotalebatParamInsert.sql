SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_kosorat/MotalebatParamInsert] 
 
    @fldMohasebatId int,
    @fldKosoratId int,
    @fldMotalebatId int,
    @fldMablagh int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldOrganId int
AS 
	
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)

		declare @PrsPersonalId INT,@fldShomareHesabId INT,@fldH_BankFixId INT,@employeeid INT,@AshkhasId INT,@fldHesabTypeItemId tinyint,@fldShomareHesabItemId int
		,@fldIsMostamar tinyint 

select @PrsPersonalId=p.fldPrs_PersonalInfoId from pay.tblMohasebat as m
inner join  pay.Pay_tblPersonalInfo as p on p.fldid=m.fldPersonalId where m.fldid=@fldMohasebatId

SELECT @fldH_BankFixId=fldH_BankFixId FROM Pay.tblSetting WHERE fldOrganId=@fldorganId
	SELECT @employeeid=fldEmployeeId FROM Prs.Prs_tblPersonalInfo WHERE fldId=@PrsPersonalId
	SELECT @AshkhasId=fldId FROM Com.tblAshkhas WHERE fldHaghighiId=@employeeid
    
	if(@fldMotalebatId is not null)
		select @fldHesabTypeItemId=i.fldHesabTypeParam,@fldIsMostamar=fldIsMostamar from pay.tblMotalebateParametri_Personal as e
		inner join pay.tblParametrs as i on i.fldId=e.fldParametrId
		where e.fldId=@fldMotalebatId
	else
			select @fldHesabTypeItemId=i.fldHesabTypeParam,@fldIsMostamar=fldIsMostamar from pay.tblKosorateParametri_Personal as e
			inner join pay.tblParametrs as i on i.fldId=e.fldParametrId
			where e.fldId=@fldKosoratId

SELECT @fldShomareHesabId=com.tblShomareHesabeOmoomi.fldId FROM com.tblShomareHesabeOmoomi INNER JOIN com.tblShomareHesabOmoomi_Detail  
	ON com.tblShomareHesabeOmoomi.fldId=com.tblShomareHesabOmoomi_Detail.fldShomareHesabId WHERE fldAshkhasId=@AshkhasId AND fldBankId=@fldH_BankFixId 
	 and fldHesabTypeId=@fldHesabTypeItemId

	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMohasebat_kosorat/MotalebatParam] 
	INSERT INTO [Pay].[tblMohasebat_kosorat/MotalebatParam] ([fldId], [fldMohasebatId], [fldKosoratId], [fldMotalebatId], [fldMablagh], [fldUserId], [fldDate], [fldDesc],fldHesabTypeParamId,fldShomareHesabParamId,fldIsMostamar)
	SELECT @fldId, @fldMohasebatId, @fldKosoratId, @fldMotalebatId, @fldMablagh, @fldUserId, GETDATE(), @fldDesc,@fldHesabTypeItemId,@fldShomareHesabId,@fldIsMostamar
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
