SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblOrganizationalPostsUpdate] 
    @fldId int,
    @fldTitle nvarchar(300),
    @fldOrgPostCode nvarchar(50),
    @fldChartOrganId int,
    @fldPID int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Com].[tblOrganizationalPosts]
	SET    [fldId] = @fldId, [fldTitle] = @fldTitle, [fldOrgPostCode] = @fldOrgPostCode, [fldChartOrganId] = @fldChartOrganId, [fldPID] = @fldPID, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
