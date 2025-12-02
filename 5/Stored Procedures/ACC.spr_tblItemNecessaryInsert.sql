SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblItemNecessaryInsert] 
    
    @fldPID int,
    @fldNameItem nvarchar(100),
    @fldMahiyatId int,
	@fldTypeHesabId tinyint,
    @fldDesc nvarchar(MAX),
    
    @fldIp varchar(16),
    @fldUserId int,
	@fldMahiyat_GardeshId int
AS 
	
	BEGIN TRAN
	SET @fldNameItem=Com.fn_TextNormalize(@fldNameItem)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int ,@Child HIERARCHYID ,@last HIERARCHYID,@fldItemId HIERARCHYID
	IF (@fldPID=0)
	BEGIN
		SET @Child=hierarchyid::GetRoot()
	END
	ELSE
	BEGIN
		SELECT @fldItemId=fldItemId FROM [ACC].[tblItemNecessary] WHERE fldId=@fldPID
		SELECT @last=MAX(fldItemId) FROM [ACC].[tblItemNecessary] WHERE fldItemId.GetAncestor(1)=@fldItemId--بزرگترین فرزندی که یک جد بالاتر آن  با ورودی  برابر باشد 
		SELECT @Child=@fldItemId.GetDescendant(@last,NULL) --جدیدترین فرزند یک جد را میدهد
	end
	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblItemNecessary] 
	INSERT INTO [ACC].[tblItemNecessary] ([fldId], [fldItemId], [fldNameItem], [fldMahiyatId], [fldDesc], [fldDate], [fldIp], [fldUserId],fldTypeHesabId,fldMahiyat_GardeshId)
	SELECT @fldId, @Child, @fldNameItem, @fldMahiyatId, @fldDesc, GETDATE(), @fldIp, @fldUserId,@fldTypeHesabId,@fldMahiyat_GardeshId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
