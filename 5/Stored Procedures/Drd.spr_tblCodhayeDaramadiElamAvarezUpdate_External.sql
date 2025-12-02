SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblCodhayeDaramadiElamAvarezUpdate_External] 
    @fldID int,
    @fldElamAvarezId int,
    @fldSharheCodeDaramad nvarchar(MAX),
    @fldShomareHesabCodeDaramadId int,
    @fldAsliValue bigint,
    @fldAvarezValue bigint,
    @fldMaliyatValue bigint, 
	
    @fldTedad INT,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
  
AS 
	BEGIN TRAN
	DECLARE @shomareHesabId INT
	SELECT @shomareHesabId=fldShomareHesadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid=@fldShomareHesabCodeDaramadId
	UPDATE [Drd].[tblCodhayeDaramadiElamAvarez]
	SET    [fldID] = @fldID, [fldElamAvarezId] = @fldElamAvarezId, [fldSharheCodeDaramad] = @fldSharheCodeDaramad,
	 [fldShomareHesabCodeDaramadId] = @fldShomareHesabCodeDaramadId, [fldAsliValue] = @fldAsliValue, [fldAvarezValue] = @fldAvarezValue, [fldMaliyatValue] = @fldMaliyatValue, [fldUserId] = @fldUserId,
	 [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldShomareHesabId] = @shomareHesabId, [fldTedad] = @fldTedad
	WHERE  [fldID] = @fldID
	COMMIT TRAN
GO
