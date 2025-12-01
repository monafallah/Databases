SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblThemDesktop_UserInsert] 
   @FileDesktop varbinary (max),
   @pasvand varchar(5),
	@fileName nvarchar(150),
    @fldType tinyint,
    @fldUserId int,
    @fldDesc nvarchar(100),
	@fldThem tinyint,
	@inputid int
	

AS 

	begin try
	BEGIN TRAN
	/*fldtype=1 then پیش فرض
	fldtype=2 then بدون عکس
	fldtype=3 then انتخاب خودش */
	set @fileName=dbo.fn_TextNormalize(@fileName)
	set @fldDesc=dbo.fn_TextNormalize(@flddesc)
	declare @fldID int , @fldFileDesktopId int

	if exists(select * from tblThemDesktop_User where fldUserId=@fldUserId)
	begin
		select @fldFileDesktopId=fldFileDesktopId,@fldID=fldId from tblThemDesktop_User where fldUserId=@fldUserId
		if(@fldtype=3 and @fldFileDesktopId is not null)
		begin
			update tblFileDesktop_User 
			set fldThem=@FileDesktop,fldPasvand=@pasvand,fldFileName=@fileName,fldSize=cast(round((DATALENGTH(@FileDesktop)/1024.0)/1024.0,2) as decimal(8,2))
			where fldid=@fldFileDesktopId

			update tblThemDesktop_User
			set fldFileDesktopId=@fldFileDesktopId,fldThem=@fldThem ,fldtype=@fldType ,fldDesc=@fldDesc
			where fldUserId=@fldUserId

		end
		else if (@fldType=3 and @fldFileDesktopId is null)
		begin
			select @fldFileDesktopId =ISNULL(max(fldId),0)+1 from [dbo].[tblFileDesktop_User] 
			INSERT INTO [dbo].[tblFileDesktop_User] ([fldId], [fldThem], [fldPasvand], [fldSize], [fldFileName])
			SELECT @fldFileDesktopId, @FileDesktop, @Pasvand, cast(round((DATALENGTH(@FileDesktop)/1024.0)/1024.0,2) as decimal(8,2)), @fileName

			update tblThemDesktop_User
			set fldFileDesktopId=@fldFileDesktopId,fldThem=@fldThem ,fldtype=@fldType ,fldDesc=@fldDesc
			where fldUserId=@fldUserId

		end
		else 
		begin
			update tblThemDesktop_User
			set fldFileDesktopId=NULL ,fldThem=@fldThem,fldtype=@fldType ,fldDesc=@fldDesc
			where fldUserId=@fldUserId
				
				if(@fldFileDesktopId is not null)
				begin
					delete from tblFileDesktop_User
					where fldid=@fldFileDesktopId
					
				end
		end
	end
	else
	begin
		if(@fldType=3)
		begin
			select @fldFileDesktopId =ISNULL(max(fldId),0)+1 from [dbo].[tblFileDesktop_User] 
			INSERT INTO [dbo].[tblFileDesktop_User] ([fldId], [fldThem], [fldPasvand], [fldSize], [fldFileName])
			SELECT @fldFileDesktopId, @FileDesktop, @Pasvand, cast(round((DATALENGTH(@FileDesktop)/1024.0)/1024.0,2) as decimal(8,2)), @fileName
		
			select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblThemDesktop_User] 
			INSERT INTO [dbo].[tblThemDesktop_User] ([fldId], [fldFileDesktopId], [fldType], [fldUserId], [fldDesc],fldThem)
			SELECT @fldId, @fldFileDesktopId, @fldType, @fldUserId, @fldDesc,@fldThem
		
			
		end
		else
		begin
			select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblThemDesktop_User] 
				INSERT INTO [dbo].[tblThemDesktop_User] ([fldId], [fldFileDesktopId], [fldType], [fldUserId], [fldDesc],fldThem)
				SELECT @fldId, NULL, @fldType, @fldUserId, @fldDesc,@fldThem
				
				
		end
	end
	select 0 as ErrorCode,'' ErrorMsg
		commit
		end try
begin catch
		rollback
		select @@error as ErrorCode,ERROR_MESSAGE() ErrorMsg
end catch
GO
