SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [chk].[spr_tblCheckHayeVaredeUpdate] 
    @fldId int,
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
	--UPDATE [chk].[tblCheckHayeVarede]
	--SET    [fldId] = @fldId, [fldIdShobe] = @fldIdShobe, [fldMablagh] = @fldMablagh, [fldAshkhasId] = @fldAshkhasId, [fldTarikhVosolCheck] = @fldTarikhVosolCheck, [fldTarikhDaryaftCheck] = @fldTarikhDaryaftCheck, [fldShenaseKamelCheck] = @fldShenaseKamelCheck, [fldBabat] = @fldBabat, [fldNoeeCheck] = @fldNoeeCheck, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldOrganId =@fldOrganId 
	--WHERE  [fldId] = @fldId
	set @fldBabat=com.fn_TextNormalize(@fldBabat)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	update drd.tblCheck
	set fldshobeid=@fldIdShobe,fldMablaghSanad=@fldMablagh,fldAshkhasId=@fldAshkhasId,fldTarikhSarResid=@fldTarikhVosolCheck,fldTarikhAkhz=@fldTarikhDaryaftCheck,fldShomareSanad=@fldShenaseKamelCheck,fldBabat=@fldBabat,fldTypeSanad=@fldNoeeCheck,fldUserId=@fldUserId,fldDesc=@fldDesc,flddate=getdate(),fldOrganId=@fldOrganId
	WHERE  [fldId] = @fldId
	if (@@ERROR<>0)
	rollback


	COMMIT TRAN
GO
