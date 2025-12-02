SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [Auto].[spr_CheckTarikhForPostCommision](@aztarikh nvarchar(10),@tatarikh nvarchar(10),@OrganizationalPost int,@AshkhasID int)
as

 
SELECT    Auto.tblCommision.fldID FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  where fldAshkhasID=@AshkhasID and fldOrganizPostEjraeeID=@OrganizationalPost 
					  and ((fldStartDate between @aztarikh and @tatarikh )
						or (fldEndDate between @aztarikh and @tatarikh)
						or (@aztarikh between fldStartDate and fldEndDate)
						or (@tatarikh between fldStartDate and fldEndDate))
GO
