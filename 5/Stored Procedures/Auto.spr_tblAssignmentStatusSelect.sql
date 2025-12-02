SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblAssignmentStatusSelect] 
    @fieldname as nvarchar(50),
	@Value nvarchar(50),
	@organId int,
	@h as int
AS 
begin
      if(@h=0) set @h=2147483647
      set @Value= com.fn_TextNormalizeSelect(@Value)
      if (@fieldname=N'fldId')
		SELECT     TOP (@h) tblAssignmentStatus.fldID, tblAssignmentStatus.fldName, fldDate, tblAssignmentStatus.fldUserID, tblAssignmentStatus.fldDesc, 
                  fldOrganId ,fldIP
		FROM         tblAssignmentStatus 
		WHERE     (tblAssignmentStatus.fldID LIKE @Value)  and fldOrganId =@organId
		
	 if (@fieldname=N'fldName')
		SELECT     TOP (@h) tblAssignmentStatus.fldID, tblAssignmentStatus.fldName, fldDate, tblAssignmentStatus.fldUserID, tblAssignmentStatus.fldDesc, 
                  fldOrganId ,fldIP
		FROM         tblAssignmentStatus 
		WHERE   fldName LIKE @Value   and fldOrganId =@organId
		
	
	 if (@fieldname=N'fldUserID')
		SELECT     TOP (@h) tblAssignmentStatus.fldID, tblAssignmentStatus.fldName, fldDate, tblAssignmentStatus.fldUserID, tblAssignmentStatus.fldDesc, 
                  fldOrganId ,fldIP
		FROM         tblAssignmentStatus 
		WHERE     (tblAssignmentStatus.fldUserID LIKE @Value) and fldOrganId =@organId
	  
	  if (@fieldname=N'fldDesc')
		SELECT     TOP (@h) tblAssignmentStatus.fldID, tblAssignmentStatus.fldName, fldDate, tblAssignmentStatus.fldUserID, tblAssignmentStatus.fldDesc, 
                  fldOrganId ,fldIP
		FROM         tblAssignmentStatus 
		WHERE    flddesc LIKE @Value  and fldOrganId =@organId
		
	 
		
	 if (@fieldname=N'')
		SELECT     TOP (@h) tblAssignmentStatus.fldID, tblAssignmentStatus.fldName, fldDate, tblAssignmentStatus.fldUserID, tblAssignmentStatus.fldDesc, 
                  fldOrganId ,fldIP
		FROM         tblAssignmentStatus 
		where   fldOrganId =@organId

				
	 if (@fieldname=N'fldOrganId')
		SELECT     TOP (@h) tblAssignmentStatus.fldID, tblAssignmentStatus.fldName, fldDate, tblAssignmentStatus.fldUserID, tblAssignmentStatus.fldDesc, 
                  fldOrganId ,fldIP
		FROM         tblAssignmentStatus 
		where   fldOrganId =@organId
End

GO
