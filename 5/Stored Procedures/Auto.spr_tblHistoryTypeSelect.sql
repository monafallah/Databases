SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Auto].[spr_tblHistoryTypeSelect] 
    @fieldname as nvarchar(50),
	@Value nvarchar(50),
	@OrganId int,
	@h as int
	
AS 
begin
    if(@h=0) set @h=2147483647
    set @Value= com.fn_TextNormalizeSelect(@Value)
    if (@fieldname=N'fldId')
		SELECT     TOP (@h) tblHistoryType.fldId, tblHistoryType.fldName,(tblHistoryType.fldDate) AS fldDate, tblHistoryType.fldUserID, 
                  fldOrganId,fldIP,fldDesc
FROM         tblHistoryType
WHERE     (tblHistoryType.fldID LIKE @Value) and fldOrganId =@OrganId
		
	if (@fieldname=N'fldName')
		SELECT     TOP (@h) tblHistoryType.fldId, tblHistoryType.fldName,(tblHistoryType.fldDate) AS fldDate, tblHistoryType.fldUserID, 
                  fldOrganId,fldIP,fldDesc
FROM         tblHistoryType
		WHERE  fldName like @Value and fldOrganId =@OrganId
		

	if (@fieldname=N'fldDesc')
		SELECT     TOP (@h) tblHistoryType.fldId, tblHistoryType.fldName,(tblHistoryType.fldDate) AS fldDate, tblHistoryType.fldUserID, 
                  fldOrganId,fldIP,fldDesc
FROM         tblHistoryType
		WHERE  fldDesc like @Value and fldOrganId =@OrganId
		
		
	if (@fieldname=N'fldOrganId')
		SELECT     TOP (@h) tblHistoryType.fldId, tblHistoryType.fldName,(tblHistoryType.fldDate) AS fldDate, tblHistoryType.fldUserID, 
                  fldOrganId,fldIP,fldDesc
FROM         tblHistoryType
where  fldOrganId =@OrganId 
		
	if (@fieldname=N'')
		SELECT     TOP (@h) tblHistoryType.fldId, tblHistoryType.fldName,(tblHistoryType.fldDate) AS fldDate, tblHistoryType.fldUserID, 
                  fldOrganId,fldIP,fldDesc
FROM         tblHistoryType
where  fldOrganId =@OrganId 
End

GO
