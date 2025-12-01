SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create FUNCTION [dbo].[fn_PersonalNameByUserId](@UserId INT)
RETURNS NVARCHAR(100)
AS 
BEGIN
	DECLARE @Name NVARCHAR(100)=''


	SELECT       @Name= tblAshkhas .fldName+N' '+ tblAshkhas.fldFamily 
	FROM            tblUser INNER JOIN
							 tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId
							 WHERE tblUser.fldId=@UserId
	RETURN @Name
END
GO
