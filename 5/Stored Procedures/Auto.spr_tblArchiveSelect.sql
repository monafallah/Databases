SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create PROC [Auto].[spr_tblArchiveSelect] 
    @fieldname as nvarchar(50),
	@Value nvarchar(50),
	@organId int,
	@h as int
	
AS 
begin
      if(@h=0) set @h=2147483647
      set @Value= com.fn_TextNormalizeSelect(@Value)
      if (@fieldname=N'fldId')
		SELECT     TOP (@h) tblArchive.fldID, tblArchive.fldName, tblArchive.fldPID,tblArchive.fldDate ,tblArchive.fldUserID, tblArchive.fldDesc,fldOrganId,fldIP
		FROM         tblArchive 
		WHERE  tblArchive.fldID like @Value and fldOrganId=@organId
		
	 if (@fieldname=N'fldName')
		SELECT     TOP (@h) tblArchive.fldID, tblArchive.fldName, tblArchive.fldPID,tblArchive.fldDate ,tblArchive.fldUserID, tblArchive.fldDesc,fldOrganId,fldIP
		FROM         tblArchive 
		WHERE  fldName like @Value and fldOrganId=@organId
		
	 if (@fieldname=N'fldPID')
	 begin
		if (@value <>0)
		SELECT     TOP (@h) tblArchive.fldID, tblArchive.fldName, tblArchive.fldPID,tblArchive.fldDate ,tblArchive.fldUserID, tblArchive.fldDesc,fldOrganId,fldIP
		FROM         tblArchive 
		WHERE  tblArchive.fldPID like @Value and fldOrganId=@organId
		else 
		SELECT     TOP (@h) tblArchive.fldID, tblArchive.fldName, tblArchive.fldPID,tblArchive.fldDate ,tblArchive.fldUserID, tblArchive.fldDesc,fldOrganId,fldIP
		FROM         tblArchive 
		WHERE  tblArchive.fldPID  is null and fldOrganId=@organId
	end
		
	 if (@fieldname=N'fldUserID')
		SELECT     TOP (@h) tblArchive.fldID, tblArchive.fldName, tblArchive.fldPID,tblArchive.fldDate ,tblArchive.fldUserID, tblArchive.fldDesc,fldOrganId,fldIP
		FROM         tblArchive 
		WHERE  tblArchive.fldUserID like @Value
		
	 if (@fieldname=N'fldDesc')
		SELECT     TOP (@h) tblArchive.fldID, tblArchive.fldName, tblArchive.fldPID,tblArchive.fldDate ,tblArchive.fldUserID, tblArchive.fldDesc,fldOrganId,fldIP
		FROM         tblArchive 
		WHERE fldDesc like @Value and fldOrganId=@organId
		
	
		
	if (@fieldname=N'')
		SELECT     TOP (@h) tblArchive.fldID, tblArchive.fldName, tblArchive.fldPID,tblArchive.fldDate ,tblArchive.fldUserID, tblArchive.fldDesc,fldOrganId,fldIP
		FROM         tblArchive 
		 where  fldOrganId=@organId 

	if (@fieldname=N'fldOrganId')
		SELECT     TOP (@h) tblArchive.fldID, tblArchive.fldName, tblArchive.fldPID,tblArchive.fldDate ,tblArchive.fldUserID, tblArchive.fldDesc,fldOrganId,fldIP
		FROM         tblArchive 
		 where  fldOrganId=@organId 
End

GO
