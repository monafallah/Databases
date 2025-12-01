SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROC [dbo].[prs_UserPassUpdate](@id INT,@pass NVARCHAR(50),@UserId INT)
AS
begin tran
UPDATE dbo.tblUser SET fldPassword=@pass,flddate=getdate() WHERE fldID=@id
commit

GO
