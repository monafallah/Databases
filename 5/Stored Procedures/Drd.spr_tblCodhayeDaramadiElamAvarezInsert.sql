SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCodhayeDaramadiElamAvarezInsert] 
    @fldID  int output,
    @fldElamAvarezId int,
    @fldSharheCodeDaramad nvarchar(MAX),
    @fldShomareHesabCodeDaramadId int,
    @fldTedad INT,
    @fldAsliValue bigint,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	--DECLARE @fldID  int
	set @fldSharheCodeDaramad=com.fn_TextNormalize(@fldSharheCodeDaramad)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @IdTakhfif INT,@flag BIT=0,@Tarikh1 NVARCHAR(10) ,@fldShomareHesabId INT,@Tarikh NVARCHAR(10),@Maliyat bigINT=0,@Avarez bigINT=0,@fldTakhfifAsliValue bigINT=NULL,@fldTakhfifAvarezValue bigINT=NULL,@fldTakhfifMaliyatValue bigINT=NULL
	,@daradTakhfif decimal(5,2)=NULL,@fldTakhfifAmuzeshParvareshValue bigint=NULL,@Amuzesh bigint=0
	SET @Tarikh=dbo.Fn_AssembelyMiladiToShamsi(GETDATE())
	SELECT @Tarikh1=dbo.Fn_AssembelyMiladiToShamsi(fldDate) FROM Drd.tblElamAvarez WHERE fldId=@fldElamAvarezId
	IF EXISTS (SELECT * FROM Drd.tblCodhayeDaramd WHERE fldId IN(SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@fldShomareHesabCodeDaramadId) AND fldMashmooleArzesheAfzoode=1 )
	BEGIN
		SELECT TOP(1) @Maliyat=((fldDarsadeMaliyat*(@fldAsliValue*@fldTedad))/100.0)FROM Com.tblMaliyatArzesheAfzoode WHERE @Tarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldId DESC
		SELECT TOP(1) @Avarez=((fldDarsadeAvarez*(@fldAsliValue*@fldTedad))/100.0)FROM Com.tblMaliyatArzesheAfzoode WHERE @Tarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldId DESC
	end

	IF EXISTS (SELECT * FROM Drd.tblCodhayeDaramd WHERE fldId IN(SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@fldShomareHesabCodeDaramadId) AND fldAmuzeshParvaresh=1 )
	BEGIN
		SELECT TOP(1) @Amuzesh=((fldDarsadAmuzeshParvaresh*(@fldAsliValue*@fldTedad))/100.0)FROM Com.tblMaliyatArzesheAfzoode WHERE @Tarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldId DESC
		
	end

	IF EXISTS(SELECT  TOP(1)   * FROM         Drd.tblTakhfif INNER JOIN
                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
                      WHERE @Tarikh1 BETWEEN fldAzTarikh AND fldTaTarikh  AND fldShCodeDaramad=@fldShomareHesabCodeDaramadId AND fldTakhfifKoli IS NOT NULL
                      ORDER BY tblTakhfif.fldId desc)
    BEGIN
		
		SELECT  TOP(1) @daradTakhfif=fldTakhfifKoli,  @fldTakhfifAsliValue=cast((cast(@fldAsliValue as bigint)*cast(@fldtedad as bigint))-(((cast(@fldAsliValue as bigint)*cast(@fldtedad as bigint))*fldTakhfifKoli)/100.0)as bigint)--, 
						--@fldTakhfifMaliyatValue=@Maliyat-((@Maliyat*fldTakhfifKoli)/100.0)	,														
						--@fldTakhfifAvarezValue=@Avarez-((@Avarez*fldTakhfifKoli)/100.0)
						FROM         Drd.tblTakhfif INNER JOIN
                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
                      WHERE @Tarikh1 BETWEEN fldAzTarikh AND fldTaTarikh  AND fldShCodeDaramad=@fldShomareHesabCodeDaramadId
                      ORDER BY tblTakhfif.fldId desc  
			IF EXISTS (SELECT * FROM Drd.tblCodhayeDaramd WHERE fldId IN(SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@fldShomareHesabCodeDaramadId) AND fldMashmooleArzesheAfzoode=1 )
			BEGIN
				SELECT TOP(1) @fldTakhfifMaliyatValue=((fldDarsadeMaliyat*(@fldTakhfifAsliValue))/100.0)FROM Com.tblMaliyatArzesheAfzoode WHERE @Tarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldId DESC
				SELECT TOP(1) @fldTakhfifAvarezValue=((fldDarsadeAvarez*(@fldTakhfifAsliValue))/100.0)FROM Com.tblMaliyatArzesheAfzoode WHERE @Tarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldId DESC
				
			end		  
			IF EXISTS (SELECT * FROM Drd.tblCodhayeDaramd WHERE fldId IN(SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@fldShomareHesabCodeDaramadId) AND fldAmuzeshParvaresh=1 )
			BEGIN
				SELECT TOP(1) @fldTakhfifAmuzeshParvareshValue=((fldDarsadAmuzeshParvaresh*(@fldTakhfifAsliValue))/100.0)FROM Com.tblMaliyatArzesheAfzoode WHERE @Tarikh BETWEEN fldFromDate AND fldEndDate ORDER BY fldId DESC
				
				
			end	
					                 
                     
	END 
	if(@fldTakhfifMaliyatValue is not null and @fldTakhfifAmuzeshParvareshValue is null)
	begin
	set @fldTakhfifAmuzeshParvareshValue=0
	end

	SELECT @fldShomareHesabId=fldShomareHesadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@fldShomareHesabCodeDaramadId
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblCodhayeDaramadiElamAvarez] 
	INSERT INTO [Drd].[tblCodhayeDaramadiElamAvarez] ([fldID], [fldElamAvarezId], [fldSharheCodeDaramad], [fldShomareHesabCodeDaramadId], [fldAsliValue], [fldAvarezValue], [fldMaliyatValue], [fldUserId], [fldDesc], [fldDate],fldShomareHesabId,fldTedad,fldTakhfifAsliValue,fldTakhfifAvarezValue,fldTakhfifMaliyatValue,fldSumAsli,fldDarsadTakhfif,fldAmuzeshParvareshValue,fldTakhfifAmuzeshParvareshValue)
	SELECT @fldID, @fldElamAvarezId, @fldSharheCodeDaramad, @fldShomareHesabCodeDaramadId, @fldAsliValue, @Avarez,@Maliyat,@fldUserId,@fldDesc ,GETDATE(),@fldShomareHesabId,@fldTedad,@fldTakhfifAsliValue,@fldTakhfifAvarezValue,@fldTakhfifMaliyatValue,@fldAsliValue*@fldTedad,@daradTakhfif,@Amuzesh,@fldTakhfifAmuzeshParvareshValue
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1	
	end
	IF(@flag=0)
	BEGIN
		IF EXISTS(SELECT  TOP(1)   * FROM         Drd.tblTakhfif INNER JOIN
                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
                      WHERE @Tarikh1 BETWEEN fldAzTarikh AND fldTaTarikh  AND fldShCodeDaramad=@fldShomareHesabCodeDaramadId AND fldTakhfifKoli IS NOT NULL
                      ORDER BY tblTakhfif.fldId desc)
		begin
		select @IdTakhfif =ISNULL(max(fldId),0)+1 from [Drd].[tblMablaghTakhfif] 
		INSERT INTO [Drd].[tblMablaghTakhfif]([fldId], [fldTakhfifAsli], [fldTakhfifMaliyat], [fldTakhfifAvarez], [fldCodeDaramadElamAvarezId], [fldType], [fldUserId], [fldDesc], [fldDate] ,fldTakhfifAmuzeshParvareshValu)
		SELECT @IdTakhfif,@fldTakhfifAsliValue,@fldTakhfifMaliyatValue,@fldTakhfifAvarezValue,@fldID,1,@fldUserId,@fldDesc,GETDATE(),isnull(@fldTakhfifAmuzeshParvareshValue,0)
		IF (@@ERROR<>0)
		BEGIN
			ROLLBACK
			
		end
		end
	end
	COMMIT
GO
