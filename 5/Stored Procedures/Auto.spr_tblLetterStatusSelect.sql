SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblLetterStatusSelect] 
    @fieldname as nvarchar(50),
	@Value nvarchar(50),
	@OrganId int,
	@h as int
AS 
begin
    if(@h=0) set @h=2147483647
    set @Value=com.fn_TextNormalizeSelect(@Value)
    if (@fieldname=N'fldId')
		SELECT     TOP (@h) tblLetterStatus.fldID, tblLetterStatus.fldName,(tblLetterStatus.fldDate) AS fldDate,tblLetterStatus.fldUserID, tblLetterStatus.fldDesc,
		fldOrganId ,fldIP 
                      
		FROM         tblLetterStatus 
		WHERE  tblLetterStatus.fldID like @Value and fldOrganId=@OrganId
		
	if (@fieldname=N'fldName')
		SELECT     TOP (@h) tblLetterStatus.fldID, tblLetterStatus.fldName,(tblLetterStatus.fldDate) AS fldDate,tblLetterStatus.fldUserID, tblLetterStatus.fldDesc,
		fldOrganId ,fldIP             
		FROM         tblLetterStatus 
		
		WHERE  fldName like @Value and fldOrganId=@OrganId
		
	
		
	
	if (@fieldname=N'fldDesc')
		SELECT     TOP (@h) tblLetterStatus.fldID, tblLetterStatus.fldName,(tblLetterStatus.fldDate) AS fldDate,tblLetterStatus.fldUserID, tblLetterStatus.fldDesc,
		fldOrganId ,fldIP             
		FROM         tblLetterStatus
		WHERE fldDesc like @Value and fldOrganId=@OrganId
		



	if (@fieldname=N'fldOrganId')	
	SELECT     TOP (@h) tblLetterStatus.fldID, tblLetterStatus.fldName,(tblLetterStatus.fldDate) AS fldDate,tblLetterStatus.fldUserID, tblLetterStatus.fldDesc,
		fldOrganId ,fldIP             
		FROM         tblLetterStatus
		where  fldOrganId=@OrganId

	if (@fieldname=N'')	
	SELECT     TOP (@h) tblLetterStatus.fldID, tblLetterStatus.fldName,(tblLetterStatus.fldDate) AS fldDate,tblLetterStatus.fldUserID, tblLetterStatus.fldDesc,
		fldOrganId ,fldIP             
		FROM         tblLetterStatus
		where  fldOrganId=@OrganId
End

GO
