SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [Drd].[spr_UpdateSharhecodeDaramd]
@id int,
@fldSharhCodDaramd nvarchar(MAX),
@fldUserId int

AS 
	BEGIN TRAN
	UPDATE [Drd].[tblShomareHesabCodeDaramad]
	SET    fldSharhCodDaramd=@fldSharhCodDaramd , [fldUserId] = @fldUserId
	WHERE  [fldId] = @Id 
	COMMIT TRAN
GO
