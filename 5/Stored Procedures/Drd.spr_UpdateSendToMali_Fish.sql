SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_UpdateSendToMali_Fish](@FieldName NVARCHAR(50),@flag BIT,@Id INT)
AS
IF(@FieldName='SendToMali')
UPDATE Drd.tblSodoorFish
SET fldSendToMaliFlag=@flag,fldDateSendToMali=GETDATE()
WHERE fldid=@Id

IF(@FieldName='FishSent')
UPDATE Drd.tblSodoorFish
SET fldFishSentFlag=@flag,fldDateFishSent=GETDATE()
WHERE fldid=@Id
GO
