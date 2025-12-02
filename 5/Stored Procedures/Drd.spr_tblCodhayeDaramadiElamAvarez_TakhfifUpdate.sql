SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCodhayeDaramadiElamAvarez_TakhfifUpdate] 
    @fldID int,
    @fldTedad int,
    @fldTakhfifAsliValue bigint,
    @fldElamAvarezId INT,
    @fldUserId int
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0,@fldMablaghID INT, @Tarikh NVARCHAR(10),@fldShomareHesabCodeDaramadId INT,@fldShomareHesabId INT,@fldTakhfifAvarezValue bigINT=NULL,@fldTakhfifMaliyatValue bigINT=NULL,@fldTakhfifAmuzeshValue bigINT=NULL
	SELECT  @Tarikh=dbo.Fn_AssembelyMiladiToShamsi(GETDATE()) FROM Drd.tblElamAvarez WHERE fldid=@fldElamAvarezId
	SELECT @fldShomareHesabCodeDaramadId=fldShomareHesabCodeDaramadId FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldID=@fldid
IF EXISTS (SELECT * FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldID=@fldID AND fldMaliyatValue<>0)
	BEGIN
		SELECT TOP(1) @fldTakhfifMaliyatValue=((fldDarsadeMaliyat*(@fldTakhfifAsliValue))/100)FROM Com.tblMaliyatArzesheAfzoode WHERE @Tarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldId DESC
	END
IF EXISTS (SELECT * FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldID=@fldID AND fldAvarezValue<>0)
	BEGIN
		SELECT TOP(1) @fldTakhfifAvarezValue=((fldDarsadeAvarez*(@fldTakhfifAsliValue))/100)FROM Com.tblMaliyatArzesheAfzoode WHERE @Tarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldId DESC
	END
IF EXISTS (SELECT * FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldID=@fldID AND fldAmuzeshParvareshValue<>0)
	BEGIN
		SELECT TOP(1) @fldTakhfifAmuzeshValue=((fldDarsadAmuzeshParvaresh*(@fldTakhfifAsliValue))/100)FROM Com.tblMaliyatArzesheAfzoode WHERE @Tarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldId DESC
	END	
	--IF EXISTS(SELECT  TOP(1)   * FROM         Drd.tblTakhfif INNER JOIN
 --                     Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
 --                     WHERE @Tarikh BETWEEN fldAzTarikh AND fldTaTarikh  AND fldShCodeDaramad=@fldShomareHesabCodeDaramadId
 --                     ORDER BY tblTakhfif.fldId desc)
 --   BEGIN
		
	--	SELECT  TOP(1)  @fldTakhfifAsliValue=@fldAsliValue-(((@fldAsliValue)*fldTakhfifKoli)/100), 
	--					@fldTakhfifMaliyatValue=@Maliyat-((@Maliyat*fldTakhfifKoli)/100)	,														
	--					@fldTakhfifAvarezValue=@Avarez-((@Avarez*fldTakhfifKoli)/100)
	--					FROM         Drd.tblTakhfif INNER JOIN
 --                     Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
 --                     WHERE @Tarikh BETWEEN fldAzTarikh AND fldTaTarikh  AND fldShCodeDaramad=@fldShomareHesabCodeDaramadId
 --                     ORDER BY tblTakhfif.fldId desc                 
                     
	--END 
	if(@fldTakhfifMaliyatValue is not null and @fldTakhfifAmuzeshValue is null)
	begin
	set @fldTakhfifAmuzeshValue=0
	end

	SELECT @fldShomareHesabId=fldShomareHesadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@fldShomareHesabCodeDaramadId
	UPDATE [Drd].[tblCodhayeDaramadiElamAvarez]
	SET   [fldUserId] = @fldUserId, [fldDate] =getdate()
	,fldTakhfifAsliValue=CAST((@fldTakhfifAsliValue/fldTedad) AS BIGINT),fldTakhfifAvarezValue=@fldTakhfifAvarezValue,fldTakhfifMaliyatValue=@fldTakhfifMaliyatValue,fldTakhfifAmuzeshParvareshValue=@fldTakhfifAmuzeshValue
	WHERE  [fldID] = @fldID
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
	IF EXISTS(SELECT * FROM Drd.tblMablaghTakhfif WHERE fldCodeDaramadElamAvarezId=@fldID AND fldType=2)
	UPDATE Drd.tblMablaghTakhfif
	SET fldTakhfifAsli=@fldTakhfifAsliValue,fldTakhfifMaliyat=ISNULL(@fldTakhfifMaliyatValue,0),fldTakhfifAvarez=ISNULL(@fldTakhfifAvarezValue,0),fldTakhfifAmuzeshParvareshValu=isnull(@fldTakhfifAmuzeshValue,0)
	WHERE fldCodeDaramadElamAvarezId=@fldID
	IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @flag=1
		END
	ELSE 
	BEGIN
	 select @fldMablaghID =ISNULL(max(fldId),0)+1 from [Drd].[tblMablaghTakhfif] 
	INSERT INTO Drd.tblMablaghTakhfif
	        ( fldId ,fldTakhfifAsli ,fldTakhfifMaliyat ,fldTakhfifAvarez , fldCodeDaramadElamAvarezId ,fldType ,fldUserId ,fldDesc ,fldDate,fldTakhfifAmuzeshParvareshValu)
	
	 SELECT @fldMablaghID,@fldTakhfifAsliValue,ISNULL(@fldTakhfifMaliyatValue,0),ISNULL(@fldTakhfifAvarezValue,0),@fldID,2,@fldUserId,'',GETDATE(),isnull(@fldTakhfifAmuzeshValue,0)
	 end

		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @flag=1
		END
	end
	COMMIT TRAN
GO
