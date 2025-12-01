SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_UserFirsLoginUpdate](@id INT,@TorF BIT)
AS
begin tran 
UPDATE dbo.tblUser SET fldFirstLogin=@TorF WHERE fldID=@id
if(@@ERROR<>0)
	rollback 
	commit

GO
