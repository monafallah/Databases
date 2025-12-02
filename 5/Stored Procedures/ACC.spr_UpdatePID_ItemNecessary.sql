SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_UpdatePID_ItemNecessary]
@Child INT,@Parent INT,@fldUserId INT 

AS 
BEGIN tran
DECLARE @hid NVARCHAR(20),@hid1 HIERARCHYID,@last HIERARCHYID,@hidChilde HIERARCHYID,@hid2 HIERARCHYID
SELECT @hid1=fldItemId FROM ACC.tblItemNecessary WHERE fldid=@Parent
SELECT @hid2=fldItemId FROM ACC.tblItemNecessary WHERE fldid=@Child
SELECT @last=MAX(fldItemId) FROM ACC.tblItemNecessary WHERE fldItemId.GetAncestor(1)=@hid1--بزرگترین فرزندی که یک جد بالاتر آن  با ورودی  برابر باشد 
	SELECT @hidChilde=@hid1.GetDescendant(@last,NULL) --جدیدترین فرزند یک جد را میدهد

SET  @hid=@hid2.ToString() 
UPDATE ACC.tblItemNecessary SET fldItemId=@hidChilde WHERE fldId=@Child
UPDATE ACC.tblItemNecessary SET fldItemId= fldItemId.GetReparentedValue(@hid2,@hidChilde) FROM ACC.tblItemNecessary WHERE fldItemId.ToString() LIKE (@hid+'%')

--UPDATE ACC.tblItemNecessary SET fldPID=@parnd ,fldUserId=@fldUserId WHERE fldId=@child

commit


GO
