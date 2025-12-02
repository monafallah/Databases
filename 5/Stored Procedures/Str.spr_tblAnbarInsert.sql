SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblAnbarInsert] 
    
    
    @fldName nvarchar(100),
    @fldAddress nvarchar(MAX),
    @fldPhone varchar(11),
    @fldDesc nvarchar(MAX),
    @fldAnbarTreeId varchar(200),
    @fldIP varchar(16),
    @fldUserId int
AS 
	
	BEGIN TRAN
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Str].[tblAnbar] 
	INSERT INTO [Str].[tblAnbar] ([fldId],  [fldName], [fldAddress], [fldPhone], [fldDesc], [fldDate], [fldIP], [fldUserId])
	SELECT @fldId, @fldName, @fldAddress, @fldPhone, @fldDesc, GETDATE(), @fldIP, @fldUserId
	if (@@ERROR<>0)
		ROLLBACK
	if(@fldAnbarTreeId<>'')
	begin
		declare @temp table(id int)
		insert @temp
		select item from Com.Split(@fldAnbarTreeId,',')
		where Item<>''
		declare @fldTreeID int 
		select @fldTreeID =ISNULL(max(fldId),0) from [Str].[tblAnbar_Tree] 
		INSERT INTO [Str].[tblAnbar_Tree] ([fldId], [fldAnbarId], [fldAnbarTreeId], [fldDesc], [fldDate], [fldIP], [fldUserId])
		SELECT ROW_NUMBER() over(order by id)+ @fldTreeID, @fldID, id, @fldDesc,GETDATE(), @fldIP, @fldUserId from @temp
		if (@@ERROR<>0)
			ROLLBACK
	end
	COMMIT
GO
