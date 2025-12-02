SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_CheckExistsCenterCo]
@fldID INT ,
@fldCostTreeId NVARCHAR(50)

AS
BEGIN 
DECLARE @Temp TABLE(id INT,GroupCenterID INT)

INSERT @Temp
select item,0 from Com.Split(@fldCostTreeId,',')
		where Item<>''
	update t set GroupCenterID=fldGroupCenterCoId
	from @temp t inner join ACC.tblTreeCenterCost on t.id=fldId
	
	IF EXISTS(SELECT * FROM ACC.tblCenterCost INNER JOIN ACC.tblTree_CenterCost ON tblTree_CenterCost.fldCenterCoId = ACC.tblCenterCost.fldId INNER JOIN 
	ACC.tblTreeCenterCost ON ACC.tblTreeCenterCost.fldId =  ACC.tblTree_CenterCost.fldCostTreeId INNER JOIN 
	@Temp AS t ON t.GroupCenterID=ACC.tblTreeCenterCost.fldGroupCenterCoId
	WHERE tblCentercost.fldId=@fldId)
		select 0 as fldCheck
	else
		select 1 as fldCheck
end
	
GO
