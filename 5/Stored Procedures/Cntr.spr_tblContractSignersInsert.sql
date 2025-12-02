SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblContractSignersInsert] 
  
    @fldContractId int,
    @fldCompanyPostId smallint,
    @fldEmpolyId int,
    @fldPostEjraeeId int,
    @fldUserId int,
    @fldOrganId int,
    @fldIP varchar(15),
    @fldDesc nvarchar(150)
AS 

	
	BEGIN TRAN
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Cntr].[tblContractSigners] 

	INSERT INTO [Cntr].[tblContractSigners] ([fldId], [fldContractId], [fldCompanyPostId], [fldEmpolyId], [fldPostEjraeeId], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate])
	SELECT @fldId, @fldContractId, @fldCompanyPostId, @fldEmpolyId, @fldPostEjraeeId, @fldUserId, @fldOrganId, @fldIP, @fldDesc, getdate()
	if(@@Error<>0)
        rollback       
	COMMIT
GO
