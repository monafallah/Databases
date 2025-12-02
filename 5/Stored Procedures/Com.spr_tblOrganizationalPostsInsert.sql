SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblOrganizationalPostsInsert] 

    @fldTitle nvarchar(300),
    @fldOrgPostCode nvarchar(50),
    @fldChartOrganId int,
    @fldPID int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblOrganizationalPosts] 
	INSERT INTO [Com].[tblOrganizationalPosts] ([fldId], [fldTitle], [fldOrgPostCode], [fldChartOrganId], [fldPID], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldTitle, @fldOrgPostCode, @fldChartOrganId, @fldPID, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
