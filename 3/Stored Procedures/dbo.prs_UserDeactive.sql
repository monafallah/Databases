SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [dbo].[prs_UserDeactive](@username NVARCHAR(50))
AS

UPDATE dbo.tblUser
SET fldActive_Deactive=0
WHERE fldUserName=@username
GO
