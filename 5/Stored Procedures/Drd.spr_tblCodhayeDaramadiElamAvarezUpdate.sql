SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCodhayeDaramadiElamAvarezUpdate] 
    @fldID int,
    @fldElamAvarezId int,
    @fldSharheCodeDaramad nvarchar(MAX),
    @fldShomareHesabCodeDaramadId int,
    @fldTedad int,
    @fldAsliValue bigint,
  
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0, @fldShomareHesabId INT ,@Tarikh NVARCHAR(10),@Maliyat bigINT=0,@Avarez bigINT=0,@fldTakhfifAsliValue bigINT=NULL,@fldTakhfifAvarezValue bigINT=NULL,@fldTakhfifMaliyatValue bigINT=NULL
	,@daradTakhfif decimal(5,2)=NULL,@Amuzesh bigint=0,@fldTakhfifAmuzeshValue bigINT=NULL
	set @fldSharheCodeDaramad=com.fn_TextNormalize(@fldSharheCodeDaramad)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	SET @Tarikh=dbo.Fn_AssembelyMiladiToShamsi(GETDATE())
IF EXISTS (SELECT * FROM Drd.tblCodhayeDaramd WHERE fldId IN(SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@fldShomareHesabCodeDaramadId) AND fldMashmooleArzesheAfzoode=1 )
	BEGIN
		SELECT TOP(1) @Maliyat=((fldDarsadeMaliyat*(@fldAsliValue*@fldTedad))/100)FROM Com.tblMaliyatArzesheAfzoode WHERE @Tarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldId DESC
		SELECT TOP(1) @Avarez=((fldDarsadeAvarez*(@fldAsliValue*@fldTedad))/100)FROM Com.tblMaliyatArzesheAfzoode WHERE @Tarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldId DESC
	end

	IF EXISTS (SELECT * FROM Drd.tblCodhayeDaramd WHERE fldId IN(SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@fldShomareHesabCodeDaramadId) AND fldAmuzeshParvaresh=1 )
	BEGIN
		SELECT TOP(1) @Amuzesh=((fldDarsadAmuzeshParvaresh*(@fldAsliValue*@fldTedad))/100)FROM Com.tblMaliyatArzesheAfzoode WHERE @Tarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldId DESC
		
	end

	IF EXISTS(SELECT  TOP(1)   * FROM         Drd.tblTakhfif INNER JOIN
                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
                      WHERE @Tarikh BETWEEN fldAzTarikh AND fldTaTarikh  AND fldShCodeDaramad=@fldShomareHesabCodeDaramadId
                      ORDER BY tblTakhfif.fldId desc)
    BEGIN
		
		SELECT  TOP(1) @daradTakhfif=fldTakhfifKoli,  @fldTakhfifAsliValue=@fldAsliValue-(((@fldAsliValue)*fldTakhfifKoli)/100), 
						@fldTakhfifMaliyatValue=@Maliyat-((@Maliyat*fldTakhfifKoli)/100)	,														
						@fldTakhfifAvarezValue=@Avarez-((@Avarez*fldTakhfifKoli)/100),
						@fldTakhfifAmuzeshValue=@Amuzesh-((@Amuzesh*fldTakhfifKoli)/100)
						FROM         Drd.tblTakhfif INNER JOIN
                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
                      WHERE @Tarikh BETWEEN fldAzTarikh AND fldTaTarikh  AND fldShCodeDaramad=@fldShomareHesabCodeDaramadId
                      ORDER BY tblTakhfif.fldId desc                 
                     
	END 
	if(@fldTakhfifMaliyatValue is not null and @fldTakhfifAmuzeshValue is null)
	begin
	set @fldTakhfifAmuzeshValue=0
	end

	SELECT @fldShomareHesabId=fldShomareHesadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@fldShomareHesabCodeDaramadId
	UPDATE [Drd].[tblCodhayeDaramadiElamAvarez]
	SET    [fldElamAvarezId] = @fldElamAvarezId, [fldSharheCodeDaramad] = @fldSharheCodeDaramad, [fldShomareHesabCodeDaramadId] = @fldShomareHesabCodeDaramadId, [fldAsliValue] = @fldAsliValue, [fldAvarezValue] = @Avarez, [fldMaliyatValue] = @Maliyat, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] =getdate(),fldShomareHesabId=@fldShomareHesabId,fldTedad=@fldTedad
	,fldTakhfifAsliValue=@fldTakhfifAsliValue,fldTakhfifAvarezValue=@fldTakhfifAvarezValue,fldTakhfifMaliyatValue=@fldTakhfifMaliyatValue,fldsumasli=isnull(cast(@fldTakhfifAsliValue as bigint),@fldAsliValue)*@fldTedad,fldDarsadTakhfif=@daradTakhfif
	,fldAmuzeshParvareshValue=@Amuzesh,fldTakhfifAmuzeshParvareshValue=@fldTakhfifAmuzeshValue
	WHERE  [fldID] = @fldID
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
	UPDATE Drd.tblMablaghTakhfif
	SET fldTakhfifAsli=@fldTakhfifAsliValue,fldTakhfifMaliyat=@fldTakhfifMaliyatValue,fldTakhfifAvarez=@fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValu=@fldTakhfifAmuzeshValue
	WHERE fldCodeDaramadElamAvarezId=@fldID
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	end
	COMMIT TRAN
GO
