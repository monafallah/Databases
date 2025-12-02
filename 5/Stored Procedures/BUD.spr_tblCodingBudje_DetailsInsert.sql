SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblCodingBudje_DetailsInsert] 
    @fldPID int,
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
	declare @fldCodeingBudjeId int,@fldCodingId HIERARCHYID,@Child HIERARCHYID ,@last HIERARCHYID--,@fldBudCode nvarchar(100)=''
	,@cod varchar(100)=''

	--if (@fldPID=0)
	--set @child= hierarchyid::GetRoot()
	--else
	--begin
		SELECT @fldCodingId=fldhierarchyidId,@cod=fldBudCode FROM [BUD].[tblCodingBudje_Details]  WHERE fldCodeingBudjeId=@fldPID
		SELECT @last=MAX(fldhierarchyidId) FROM[BUD].[tblCodingBudje_Details]  WHERE  fldhierarchyidId.GetAncestor(1)=@fldCodingId and fldHeaderId=@fldHeaderId--بزرگترین فرزندی که یک جد بالاتر آن  با ورودی  برابر باشد 
		SELECT @Child=@fldCodingId.GetDescendant(@last,NULL) 
	--end

	select @fldCodeingBudjeId=isnull(max(fldCodeingBudjeId),0)+1  FROM   [BUD].[tblCodingBudje_Details] 
	INSERT INTO [BUD].[tblCodingBudje_Details] ([fldCodeingBudjeId], [fldhierarchyidId], [fldHeaderId], [fldTitle], [fldCode], [fldOldId], [fldTarh_KhedmatTypeId], [fldEtebarTypeId], [fldMasrafTypeId], [fldDate], [fldIp], [fldUserId], [fldBudCode],fldCodeingLevelId)
	SELECT @fldCodeingBudjeId, @Child, @fldHeaderId, @fldTitle, SUBSTRING(@fldBudCode,len(@cod)+1,len(@fldBudCode)), nULL, @fldTarh_KhedmatTypeId, @fldEtebarTypeId, @fldMasrafTypeId, getdate(), @fldIp, @fldUserId, @fldBudCode,@fldCodeingLevelId
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
