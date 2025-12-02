SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMap_HeaderInsert] 
   
    @fldSalMada smallint,
    @fldSalMaghsad smallint,
    @fldMarja nvarchar(15),
	 @fldMaghsadId int,
    @fldCodeDaramadMabda nvarchar(50),
  
	@fldUserId int,
	@fldOrganId int
AS 
	 
	begin try
	BEGIN TRAN
	declare @fldid int,@dId int
	select @fldid=isnull(max(fldId),0)+1  FROM   [Drd].[tblMap_Header] 
	INSERT INTO [Drd].[tblMap_Header] ([fldId], [fldSalMada], [fldSalMaghsad], [fldMarja], [fldDate],fldUserId)
	SELECT @fldId, @fldSalMada, @fldSalMaghsad, @fldMarja, getdate(),@fldUserId
	
	select @dId=isnull(max(fldId),0)+1  FROM   [Drd].[tblMap_Detail] 
	INSERT INTO [Drd].[tblMap_Detail] ([fldId], [fldHeaderId], [fldMaghsadId], [fldCodeDaramadMabda], [fldDate], [fldOrganId], [fldUserId])
	SELECT @dId, @fldid, @fldMaghsadId, @fldCodeDaramadMabda, getdate(), @fldOrganId, @fldUserId
	
	select '' ErrorMsg

	commit 
	end try

	begin catch 

	
		rollback
		
		select ERROR_MESSAGE() ErrorMsg		
               
	end catch
GO
