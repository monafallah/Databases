SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoteghayerhayeHoghoghiInsert] 
	--@fldID int OUT,
    @fldTarikhEjra nvarchar(10),
    @fldTarikhSodur nvarchar(10),
    @fldAnvaeEstekhdamId int,
    @fldTypeBimeId int,
    @fldZaribEzafeKar int,
    @fldSaatKari decimal(8, 4),
    @fldDarsadBimePersonal decimal(8, 4),
    @fldDarsadbimeKarfarma decimal(8, 4),
    @fldDarsadBimeBikari decimal(8, 4),
    @fldDarsadBimeJanbazan decimal(8, 4),
    @fldHaghDarmanKarmand decimal(8, 4),
    @fldHaghDarmanKarfarma decimal(8, 4),
    @fldHaghDarmanDolat decimal(8, 4),
    @fldHaghDarmanMazad int,
    @fldHaghDarmanTahteTakaffol int,
    @fldDarsadBimeMashagheleZiyanAvar decimal(8, 4),
    @fldMaxHaghDarman int,
    @fldZaribHoghoghiSal int,
    @fldHoghogh bit,
    @fldFoghShoghl bit,
    @fldTafavotTatbigh bit,
    @fldFoghVizhe bit,
    @fldHaghJazb bit,
    @fldTadil bit,
    @fldBarJastegi bit,
    @fldSanavat bit,
    @fldItemEstekhdam NVARCHAR(max),
	@fldFoghTalash BIT,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRANSACTION
	declare @fldID INT,@DetailId INT ,@flag BIT=0
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMoteghayerhayeHoghoghi] 
	INSERT INTO [Pay].[tblMoteghayerhayeHoghoghi] ([fldId], [fldTarikhEjra], [fldTarikhSodur], [fldAnvaeEstekhdamId], [fldTypeBimeId], [fldZaribEzafeKar], [fldSaatKari], [fldDarsadBimePersonal], [fldDarsadbimeKarfarma], [fldDarsadBimeBikari], [fldDarsadBimeJanbazan], [fldHaghDarmanKarmand], [fldHaghDarmanKarfarma], [fldHaghDarmanDolat], [fldHaghDarmanMazad], [fldHaghDarmanTahteTakaffol], [fldDarsadBimeMashagheleZiyanAvar], [fldMaxHaghDarman], [fldZaribHoghoghiSal], [fldHoghogh], [fldFoghShoghl], [fldTafavotTatbigh], [fldFoghVizhe], [fldHaghJazb], [fldTadil], [fldBarJastegi], [fldSanavat],fldFoghTalash, [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldTarikhEjra, @fldTarikhSodur, @fldAnvaeEstekhdamId, @fldTypeBimeId, @fldZaribEzafeKar, @fldSaatKari, @fldDarsadBimePersonal, @fldDarsadbimeKarfarma, @fldDarsadBimeBikari, @fldDarsadBimeJanbazan, @fldHaghDarmanKarmand, @fldHaghDarmanKarfarma, @fldHaghDarmanDolat, @fldHaghDarmanMazad, @fldHaghDarmanTahteTakaffol, @fldDarsadBimeMashagheleZiyanAvar, @fldMaxHaghDarman, @fldZaribHoghoghiSal, @fldHoghogh, @fldFoghShoghl, @fldTafavotTatbigh, @fldFoghVizhe, @fldHaghJazb, @fldTadil, @fldBarJastegi, @fldSanavat,@fldFoghTalash, @fldUserId, GETDATE(), @fldDesc
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@fldItemEstekhdam<>'')
	BEGIN
	IF(@flag=0)
	BEGIN
		SELECT @DetailId =ISNULL(max(fldId),0) from [Pay].[tblMoteghayerhayeHoghoghi_Detail]
		INSERT INTO [Pay].[tblMoteghayerhayeHoghoghi_Detail] ([fldId], [fldMoteghayerhayeHoghoghiId], [fldItemEstekhdamId],fldMazayaMashmool, [fldUserId], [fldDate], [fldDesc])
			select  @DetailId+ROW_NUMBER() over (order by (select 1)) as i,@fldID,t.item,cast(t2.item as bit) , @fldUserId, GETDATE(), @fldDesc
		from com.Split(@fldItemEstekhdam,';') as s
		cross apply(select ROW_NUMBER() over (order by (select 1)) as id, * from com.Split(s.item,',')t)t
		cross apply(select ROW_NUMBER() over (order by (select 1)) as id, * from com.Split(s.item,',')t)t2
		where t.id=1 and t2.id=2
		IF (@@ERROR<>0)
				ROLLBACK
		/*DECLARE @fldItemEstekhdamId INT,@count INT
		DECLARE @fldItem NVARCHAR(max)=''
		DECLARE @t TABLE(fldItemEstekhdamId INT)
		SET @fldItem=SUBSTRING(@fldItemEstekhdam,1,LEN(@fldItemEstekhdam)-1)
		INSERT INTO @t( fldItemEstekhdamId )
		SELECT CAST(Item AS INT) FROM Com.split(@fldItem,';')
		SELECT @count=COUNT(*) FROM @t
		WHILE (@count>0)
			BEGIN
			SELECT TOP(1) @fldItemEstekhdamId=fldItemEstekhdamId FROM @t
			SELECT @DetailId =ISNULL(max(fldId),0)+1 from [Pay].[tblMoteghayerhayeHoghoghi_Detail] 
			INSERT INTO [Pay].[tblMoteghayerhayeHoghoghi_Detail] ([fldId], [fldMoteghayerhayeHoghoghiId], [fldItemEstekhdamId], [fldUserId], [fldDate], [fldDesc])
			SELECT @DetailId, @fldID, @fldItemEstekhdamId, @fldUserId, GETDATE(), @fldDesc
			IF (@@ERROR<>0)
				ROLLBACK
			DELETE FROM @t WHERE fldItemEstekhdamId=@fldItemEstekhdamId
			SET @count=@count-1
			END*/
	END
end	
	
	COMMIT TRANSACTION
GO
