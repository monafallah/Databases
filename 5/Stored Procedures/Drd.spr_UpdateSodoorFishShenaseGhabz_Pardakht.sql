SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [Drd].[spr_UpdateSodoorFishShenaseGhabz_Pardakht]
    @fishId int ,
    @fldShenaseGhabz nvarchar(13),
    @fldShenasePardakht nvarchar(13),
    @UserId INT,
	@fldBarcode nvarchar(26)
    
AS 
	UPDATE [Drd].[tblSodoorFish]
	SET    fldShenaseGhabz = @fldShenaseGhabz,fldShenasePardakht=@fldShenasePardakht,fldUserId=@UserId ,fldBarcode=@fldBarcode
	,fldDate=GETDATE()
	WHERE  fldId = @fishId 
	
GO
