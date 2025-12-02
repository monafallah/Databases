SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create
 PROC [ACC].[spr_UpdatePID_Cost_Tree] (@Cost_TreeId int,@Parent INT,@UserId int)
AS

UPDATE ACC.tblTree_CenterCost SET fldCostTreeId=@Parent,fldUserId=@UserId,fldDate=GETDATE() WHERE fldId=@Cost_TreeId
GO
