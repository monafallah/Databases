SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr.Anbar_TarifNashode]
@fldGroupId int 

AS
 BEGIN TRAN
 DECLARE @temp TABLE (anabrId int,anabrTreeId int)
 INSERT @temp
 
 SELECT      fldAnbarId, fldAnbarTreeId
FROM         Str.tblAnbarTree INNER JOIN
                      Str.tblAnbar_Tree ON Str.tblAnbarTree.fldId = Str.tblAnbar_Tree.fldAnbarTreeId
                      WHERE fldGroupId=@fldGroupId
                      
                       
SELECT fldId AS AnbarId,fldName FROM  STR.tblanbar WHERE fldId NOT IN (SELECT anabrId FROM @temp )


commit
GO
