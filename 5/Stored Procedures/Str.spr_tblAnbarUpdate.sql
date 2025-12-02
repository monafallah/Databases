SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblAnbarUpdate] 
    @fldId int,
    
    @fldName nvarchar(100),
    @fldAddress nvarchar(MAX),
    @fldPhone varchar(11),
    @fldDesc nvarchar(MAX),
    @fldAnbarTreeId varchar(200),
    @fldIP varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	UPDATE [Str].[tblAnbar]
	SET    [fldId] = @fldId,  [fldName] = @fldName, [fldAddress] = @fldAddress, [fldPhone] = @fldPhone, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
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
	COMMIT TRAN
GO
