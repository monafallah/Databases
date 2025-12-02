SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCodhayeDaramadiElamAvarezInsert_External] 
    @fldID INT OUT,
	@fldElamAvarezId int,
    @fldSharheCodeDaramad nvarchar(MAX),
    @fldShomareHesabCodeDaramadId int,
    @fldTedad INT,
    @fldAsliValue bigint,
	@fldMaliyatValue bigINT,
	@fldAvarezValue bigiNT,
	
    @fldUserId int,
    @fldDesc nvarchar(MAX)
	AS
	declare @fldShomareHesabId INT
	set @fldSharheCodeDaramad=com.fn_TextNormalize(@fldSharheCodeDaramad)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	SELECT @fldShomareHesabId=fldShomareHesadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@fldShomareHesabCodeDaramadId
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblCodhayeDaramadiElamAvarez] 
	INSERT INTO [Drd].[tblCodhayeDaramadiElamAvarez] ([fldID], [fldElamAvarezId], [fldSharheCodeDaramad], [fldShomareHesabCodeDaramadId], [fldAsliValue], [fldAvarezValue], [fldMaliyatValue], [fldUserId], [fldDesc], [fldDate],fldShomareHesabId,fldTedad,fldTakhfifAsliValue,fldTakhfifAvarezValue,fldTakhfifMaliyatValue,fldSumAsli,fldAmuzeshParvareshValue,fldTakhfifAmuzeshParvareshValue)
	SELECT @fldID, @fldElamAvarezId, @fldSharheCodeDaramad, @fldShomareHesabCodeDaramadId, @fldAsliValue, @fldAvarezValue,@fldMaliyatValue ,@fldUserId,@fldDesc ,GETDATE(),@fldShomareHesabId,@fldTedad,NULL,NULL,NULL,@fldAsliValue*@fldTedad,0,null
GO
