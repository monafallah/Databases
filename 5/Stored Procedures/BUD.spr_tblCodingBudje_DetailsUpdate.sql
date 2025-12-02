SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblCodingBudje_DetailsUpdate] 
    @fldCodeingBudjeId int,
    @fldHeaderId int = NULL,
    @fldTitle nvarchar(200),
    @fldBudCode varchar(100),
    @fldTarh_KhedmatTypeId tinyint = NULL,
    @fldEtebarTypeId tinyint = NULL,
    @fldMasrafTypeId tinyint = NULL,
	@fldCodeingLevelId int,
    @fldIp varchar(16),
    @fldUserId int
AS 
	 
	
	BEGIN TRAN
	declare @fldCodingId HIERARCHYID,@code  varchar(100)=''

	select @code=pcode.fldBudCode from bud.tblCodingBudje_Details c
	cross apply (select d1.fldBudCode from bud.tblCodingBudje_Details d1 where d1.fldhierarchyidId=c.fldhierarchyidId.GetAncestor(1))pcode
	 where fldCodeingBudjeId=@fldCodeingBudjeId

	UPDATE [BUD].[tblCodingBudje_Details]
	SET  [fldHeaderId] = @fldHeaderId, [fldTitle] = @fldTitle, [fldCode] = SUBSTRING(@fldBudCode,len(@code),len(@fldBudCode)), [fldTarh_KhedmatTypeId] = @fldTarh_KhedmatTypeId, [fldEtebarTypeId] = @fldEtebarTypeId, [fldMasrafTypeId] = @fldMasrafTypeId, [fldDate] = getdate(), [fldIp] = @fldIp, [fldUserId] = @fldUserId, [fldBudCode] = @fldBudCode
	,fldCodeingLevelId=@fldCodeingLevelId
	WHERE  [fldCodeingBudjeId] = @fldCodeingBudjeId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
