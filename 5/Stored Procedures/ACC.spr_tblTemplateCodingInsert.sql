SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblTemplateCodingInsert] 
   
    @fldPID int,
    @fldItemId int,
    @fldName nvarchar(200),
    @fldPCod VARCHAR(100),
    @fldMahiyatId int,
    @fldCode VARCHAR(100),
    @fldTempNameId int,
    @fldLevelsAccountTypId int,
	@fldTypeHesabId tinyint,
    @fldDesc nvarchar(MAX),
    @fldIp varchar(16),
    @fldUserId int,
	@fldCodeBudget VARCHAR(100),
	@fldAddChildNode bit,
	@fldMahiyat_GardeshId int
	
	
AS 
	
	BEGIN TRAN
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int ,@Child HIERARCHYID ,@last HIERARCHYID,@fldTempCodeId HIERARCHYID
	/*IF (@fldPID=0)
	BEGIN
		SET @Child=hierarchyid::GetRoot()
	END
	ELSE
	BEGIN*/
		SELECT @fldTempCodeId=fldTempCodeId FROM [ACC].[tblTemplateCoding] WHERE fldId=@fldPID
		SELECT @last=MAX(fldTempCodeId) FROM [ACC].[tblTemplateCoding] WHERE fldTempNameId=@fldTempNameId and fldTempCodeId.GetAncestor(1)=@fldTempCodeId--بزرگترین فرزندی که یک جد بالاتر آن  با ورودی  برابر باشد 
		SELECT @Child=@fldTempCodeId.GetDescendant(@last,NULL) --جدیدترین فرزند یک جد را میدهد
	--end
	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblTemplateCoding] 
	INSERT INTO [ACC].[tblTemplateCoding] ([fldId], fldTempCodeId, [fldItemId], [fldName],  [fldPCod], [fldMahiyatId], [fldCode], [fldTempNameId], [fldLevelsAccountTypId], [fldDesc], [fldDate], [fldIp], [fldUserId],fldTypeHesabId,fldCodeBudget,fldAddChildNode,fldMahiyat_GardeshId)
	SELECT @fldId, @Child, @fldItemId, @fldName, @fldPCod, @fldMahiyatId, @fldCode, @fldTempNameId, @fldLevelsAccountTypId, @fldDesc, GETDATE(), @fldIp, @fldUserId,@fldTypeHesabId,@fldCodeBudget,@fldAddChildNode,@fldMahiyat_GardeshId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
