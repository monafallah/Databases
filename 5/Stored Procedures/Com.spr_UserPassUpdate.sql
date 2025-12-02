SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_UserPassUpdate](@id INT,@pass NVARCHAR(50))
AS
UPDATE Com.tblUser SET fldPassword=@pass WHERE fldID=@id
GO
