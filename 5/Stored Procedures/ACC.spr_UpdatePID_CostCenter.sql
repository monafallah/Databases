SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create
 PROC [ACC].[spr_UpdatePID_CostCenter] (@Child int ,@Parent INT,@UserId int)
AS

UPDATE ACC.tblTreeCenterCost SET fldPId=@Parent,fldUserId=@UserId,fldDate=GETDATE() WHERE fldId=@Child
GO
