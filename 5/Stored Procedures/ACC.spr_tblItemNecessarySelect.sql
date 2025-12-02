SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblItemNecessarySelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@value2 nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) i.[fldId],  [fldNameItem], [fldMahiyatId], [fldDesc], [fldDate], [fldIp], i.[fldUserId],fldTypeHesabId 
	,t.fldName as fldNameTypeHesab,fldMahiyat_GardeshId
	FROM   [ACC].[tblItemNecessary]  i
	left join acc.tblTypeHesab t on t.fldid=i.fldTypeHesabId
	WHERE  i.fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) i.[fldId],  [fldNameItem], [fldMahiyatId], [fldDesc], [fldDate], [fldIp], i.[fldUserId],fldTypeHesabId 
	,t.fldName as fldNameTypeHesab,fldMahiyat_GardeshId
	FROM   [ACC].[tblItemNecessary]  i
	left join acc.tblTypeHesab t on t.fldid=i.fldTypeHesabId
	WHERE fldDesc like  @Value

		if (@fieldname=N'fldTypeHesabId')
	SELECT top(@h) i.[fldId],  [fldNameItem], [fldMahiyatId], [fldDesc], [fldDate], [fldIp], i.[fldUserId],fldTypeHesabId 
	,t.fldName as fldNameTypeHesab,fldMahiyat_GardeshId
	FROM   [ACC].[tblItemNecessary]  i
	left join acc.tblTypeHesab t on t.fldid=i.fldTypeHesabId
	WHERE fldTypeHesabId like  @Value

		if (@fieldname=N'fldNameTypeHesab')
	SELECT top(@h) i.[fldId],  [fldNameItem], [fldMahiyatId], [fldDesc], [fldDate], [fldIp], i.[fldUserId],fldTypeHesabId 
	,t.fldName as fldNameTypeHesab,fldMahiyat_GardeshId
	FROM   [ACC].[tblItemNecessary]  i
	left join acc.tblTypeHesab t on t.fldid=i.fldTypeHesabId
	WHERE t.fldName like  @Value


	if (@fieldname=N'')
	SELECT top(@h) i.[fldId],  [fldNameItem], [fldMahiyatId], [fldDesc], [fldDate], [fldIp], i.[fldUserId],fldTypeHesabId 
	,t.fldName as fldNameTypeHesab,fldMahiyat_GardeshId
	FROM   [ACC].[tblItemNecessary]  i
	left join acc.tblTypeHesab t on t.fldid=i.fldTypeHesabId
	
	
	if (@fieldname=N'fldPID')
	BEGIN 
	IF (@Value=0)
	BEGIN
		SELECT top(@h) i.[fldId],  [fldNameItem], [fldMahiyatId], [fldDesc], [fldDate], [fldIp], i.[fldUserId] ,fldTypeHesabId
		,t.fldName as fldNameTypeHesab,i.fldMahiyat_GardeshId
		FROM   [ACC].[tblItemNecessary]  i
		left join acc.tblTypeHesab t on t.fldid=i.fldTypeHesabId
		WHERE fldItemId=HIERARCHYID::GetRoot() 
		order by fldId
	END 
	ELSE 
	BEGIN
		SELECT  c.[fldId],  c.[fldNameItem], c.[fldMahiyatId], c.[fldDesc], c.[fldDate], c.[fldIp], c.[fldUserId],c.fldTypeHesabId 
		,t.fldName as fldNameTypeHesab,c.fldMahiyat_GardeshId
		FROM   [ACC].[tblItemNecessary]  c inner join ACC.tblItemNecessary as p
		on p.fldId=@Value and c.fldItemId.GetAncestor(1)=p.fldItemId 
		left join acc.tblTypeHesab t on t.fldid=c.fldTypeHesabId
	END
	end 

	if (@fieldname=N'fldPCode')
	begin
		declare @ItemId int=0
		if(@Value='')
		begin
			SELECT  c.[fldId],  c.[fldNameItem], c.[fldMahiyatId], c.[fldDesc], c.[fldDate], c.[fldIp], c.[fldUserId],c.fldTypeHesabId
			,t.fldName as fldNameTypeHesab,c.fldMahiyat_GardeshId
			FROM   [ACC].[tblItemNecessary]  c inner join ACC.tblItemNecessary as p
			on p.fldId=1 and c.fldItemId.GetAncestor(1)=p.fldItemId
			left join acc.tblTypeHesab t on t.fldid=c.fldTypeHesabId
		end
		else
		begin
			select @ItemId=fldItemId from ACC.tblTemplateCoding where fldCode=@Value and fldTempNameId=@value2
			if (@ItemId<>0)
			SELECT  c.[fldId],  c.[fldNameItem], c.[fldMahiyatId], c.[fldDesc], c.[fldDate], c.[fldIp], c.[fldUserId] ,c.fldTypeHesabId
			,t.fldName as fldNameTypeHesab,c.fldMahiyat_GardeshId
			FROM   [ACC].[tblItemNecessary]  c inner join ACC.tblItemNecessary as p
			on p.fldId=@ItemId and c.fldItemId.GetAncestor(1)=p.fldItemId
			left join acc.tblTypeHesab t on t.fldid=c.fldTypeHesabId
			else
			
			SELECT  c.[fldId],  c.[fldNameItem], c.[fldMahiyatId], c.[fldDesc], c.[fldDate], c.[fldIp], c.[fldUserId] ,c.fldTypeHesabId
			,t.fldName as fldNameTypeHesab,c.fldMahiyat_GardeshId
			FROM   [ACC].[tblItemNecessary]  c
			left join acc.tblTypeHesab t on t.fldid=c.fldTypeHesabId
			where c.fldid<>1
			order by fldStrhid,fldid

		end


	END
	
	
	
	if (@fieldname=N'fldNameItem')
	SELECT top(@h) i.[fldId],  [fldNameItem], [fldMahiyatId], [fldDesc], [fldDate], [fldIp], i.[fldUserId] ,i.fldTypeHesabId
	,t.fldName as fldNameTypeHesab,fldMahiyat_GardeshId
	FROM   [ACC].[tblItemNecessary] i
	left join acc.tblTypeHesab t on t.fldid=i.fldTypeHesabId
	WHERE fldNameItem like  @Value
	
	
	COMMIT
GO
