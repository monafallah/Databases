SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_DeleteKoliElamAvarez](@IdElamAvarez INT,@userId INT)
AS
BEGIN TRAN
DECLARE @flag BIT=0
DELETE FROM Drd.tblSodoorFish_Detail WHERE fldFishId IN (SELECT fldId FROM Drd.tblSodoorFish WHERE fldElamAvarezId=@IdElamAvarez)
IF(@@ERROR<>0)
BEGIN
	ROLLBACK
	SET @flag=1
end
IF(@flag=0)
BEGIN
DELETE FROM Drd.tblSodoorFish WHERE fldElamAvarezId=@IdElamAvarez
	IF(@@ERROR<>0)
	BEGIN
	ROLLBACK
	SET @flag=1
	END
END
IF(@flag=0)
BEGIN
DELETE FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@IdElamAvarez
	IF(@@ERROR<>0)
	BEGIN
	ROLLBACK
	SET @flag=1
	END
END
IF(@flag=0)
BEGIN
DELETE FROM Drd.tblElamAvarez where fldId=@IdElamAvarez
	IF(@@ERROR<>0)
	BEGIN
	ROLLBACK
	SET @flag=1
	END
END
COMMIT
GO
