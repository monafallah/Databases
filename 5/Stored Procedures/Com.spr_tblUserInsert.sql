SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblUserInsert] 
  @fldID INT OUT,
    @fldEmployId int,
    @fldUserName nvarchar(100),
    @fldPassword nvarchar(100),
    @fldActive_Deactive bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	--BEGIN TRY
	DECLARE @id INT
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	BEGIN TRAN
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblUser] 
	INSERT INTO [Com].[tblUser] ([fldId], [fldEmployId], [fldUserName], [fldPassword], [fldActive_Deactive],  [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldEmployId, @fldUserName, @fldPassword, @fldActive_Deactive,  @fldUserId, @fldDesc, GETDATE()

	COMMIT
	--END TRY
	--BEGIN CATCH
	
	--IF @@TRANCOUNT>0
	--BEGIN
 --   PRINT ('rollback')
 --   ROLLBACK
 --	end
	
	--END catch
GO
