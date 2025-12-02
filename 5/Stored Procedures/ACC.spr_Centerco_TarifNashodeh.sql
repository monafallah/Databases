SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_Centerco_TarifNashodeh]
@fldGroupcenterCoId INT 

AS 
BEGIN TRAN 

DECLARE @Temp TABLE (CenterCoId INT, CostTreeId INT)

INSERT @Temp
  
  SELECT     fldCenterCoId, fldCostTreeId
FROM         ACC.tblTreeCenterCost INNER JOIN
                      ACC.tblTree_CenterCost ON ACC.tblTreeCenterCost.fldId = ACC.tblTree_CenterCost.fldCostTreeId
                      WHERE fldGroupcenterCoId=@fldGroupcenterCoId
    
    SELECT fldId AS fldCenterCoId,fldNameCenter FROM  ACC.tblCenterCost WHERE fldId NOT IN (SELECT costtreeId FROM @Temp)
    
    COMMIT
GO
