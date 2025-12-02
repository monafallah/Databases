SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC  [Str].[spr.kala_TarifNashode]
@fldGroupId int

 AS
 BEGIN TRAN
 declare @temp table(KalaTreeId int,KalaId int)
 DECLARE @fldKalaId int
	insert @temp
select fldKalaTreeId,fldKalaId from  str.tblKalaTree INNER JOIN 
Str.tblKala_Tree on str.tblKalaTree.fldId=str.tblKala_Tree.fldKalaTreeId  
	WHERE fldGroupId=@fldGroupId

select fldId AS kalaId,fldName from str.tblkala where fldid not in (select KalaId from @temp)

COMMIT
	
	
	
	
	
	
	 
GO
