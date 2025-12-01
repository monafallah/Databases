SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create FUNCTION [dbo].[fn_GetPersonalNameByUserId](@UserId INT)
returns table
as
RETURN (
	
	SELECT        fldName+N' '+ fldFamily as fldName_Family
	FROM            tblUser INNER JOIN
							 tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId
							 WHERE tblUser.fldId=@UserId
)
GO
