SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_MahaleKhedmat](@PersonalId int)
RETURNS NVARCHAR(150)
AS
BEGIN
DECLARE @Name NVARCHAR(150)=''
SELECT  @Name=Com.fn_stringDecode(tblOrganization.fldName)+'_'+ tblChartOrgan.fldTitle                   
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId INNER JOIN
                      Com.tblOrganization ON Com.tblChartOrgan.fldOrganId = Com.tblOrganization.fldId
                       WHERE Prs_tblPersonalInfo.fldId =@PersonalId
RETURN @Name
END
GO
