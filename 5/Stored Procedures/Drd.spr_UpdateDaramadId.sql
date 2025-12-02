SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_UpdateDaramadId] (@Childe int ,@Parent INT,@UserId int)
as
DECLARE @hid NVARCHAR(20),@hid1 HIERARCHYID,@last HIERARCHYID,@hidChilde HIERARCHYID,@hid2 HIERARCHYID
SELECT @hid1=fldDaramadId FROM Drd.tblCodhayeDaramd WHERE fldid=@Parent
SELECT @hid2=fldDaramadId FROM Drd.tblCodhayeDaramd WHERE fldid=@Childe
SELECT @last=MAX(fldDaramadId) FROM Drd.tblCodhayeDaramd WHERE fldDaramadId.GetAncestor(1)=@hid1--بزرگترین فرزندی که یک جد بالاتر آن  با ورودی  برابر باشد 
	SELECT @hidChilde=@hid1.GetDescendant(@last,NULL) --جدیدترین فرزند یک جد را میدهد

SET  @hid=@hid2.ToString() 
UPDATE Drd.tblCodhayeDaramd SET fldDaramadId=@hidChilde WHERE fldId=@Childe
UPDATE Drd.tblCodhayeDaramd SET fldDaramadId= fldDaramadId.GetReparentedValue(@hid2,@hidChilde) FROM Drd.tblCodhayeDaramd WHERE fldDaramadId.ToString() LIKE (@hid+'%')
	
GO
