SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [chk].[spr_tblCheckHayeVaredeInsert] 

    @fldIdShobe int,
    @fldMablagh int,
    @fldAshkhasId int,
    @fldTarikhVosolCheck nvarchar(10),
    @fldTarikhDaryaftCheck nvarchar(10),
    @fldShenaseKamelCheck nvarchar(50),
    @fldBabat nvarchar(MAX),
    @fldNoeeCheck bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldOrganId int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	--select @fldID =ISNULL(max(fldId),0)+1 from [chk].[tblCheckHayeVarede] 
	--INSERT INTO [chk].[tblCheckHayeVarede] ([fldId], [fldIdShobe], [fldMablagh], [fldAshkhasId], [fldTarikhVosolCheck], [fldTarikhDaryaftCheck], [fldShenaseKamelCheck], [fldBabat], [fldNoeeCheck], [fldUserId], [fldDesc], [fldDate],fldOrganId)
	--SELECT @fldId, @fldIdShobe, @fldMablagh, @fldAshkhasId, @fldTarikhVosolCheck, @fldTarikhDaryaftCheck, @fldShenaseKamelCheck, @fldBabat, @fldNoeeCheck, @fldUserId, @fldDesc, GETDATE(),@fldOrganId
	--if (@@ERROR<>0)
	--	ROLLBACK
	set @fldBabat=com.fn_TextNormalize(@fldBabat)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblCheck]
	INSERT INTO [Drd].[tblCheck] ([fldId], [fldShomareHesabId], [fldShomareSanad],fldReplyTaghsitId ,[fldTarikhSarResid], [fldMablaghSanad], [fldStatus], [fldTypeSanad], [fldUserId], [fldDesc], [fldDate],fldShomareHesabIdOrgan,fldTarikhAkhz,fldAshkhasId,fldBabat,fldOrganId,fldShobeId)
	SELECT @fldid,NULL,@fldShenaseKamelCheck,NUll,@fldTarikhVosolCheck,@fldMablagh,case when @fldNoeeCheck=0 then 1 else NUll end,@fldNoeeCheck,@fldUserId,@fldDesc,getdate(),NULL,@fldTarikhDaryaftCheck,@fldAshkhasId,@fldBabat,@fldOrganId,@fldIdShobe
		if (@@ERROR<>0)
			ROLLBACK
	else 
	begin
	if (@fldNoeeCheck=0)
		begin
		declare @id int 
		select @id =ISNULL(max(fldId),0)+1 from [chk].tblCheckStatus 
		INSERT INTO [chk].tblCheckStatus ([fldId], fldSodorCheckId,fldCheckVaredeId,fldAghsatId,fldVaziat,fldTarikh, [fldUserId], [fldDesc], [fldDate])
		SELECT @id, NULL, @fldid, NULL, 1,dbo.Fn_AssembelyMiladiToShamsi(getdate()),  @fldUserId, N'اینزرت چک', GETDATE()
		if (@@ERROR<>0)
			ROLLBACK
		end
	end
	COMMIT
GO
