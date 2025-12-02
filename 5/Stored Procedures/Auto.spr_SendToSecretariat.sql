SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Auto].[spr_SendToSecretariat] 
	@fieldname as nvarchar(50),
	@Value nvarchar(50),
	@h as int
AS
if(@h=0) set @h=21474836
set @Value=com.fn_TextNormalize(@Value)
declare  @tarikh nvarchar(10)=dbo.Fn_AssembelyMiladiToShamsi(GETDATE())
if (@fieldname=N'fldId')
	SELECT   top(@h)  tblEmployee.fldName COLLATE Latin1_General_CS_AS + ' ' + tblEmployee.fldFamily COLLATE Latin1_General_CS_AS + '(' + tblOrganizationalPostsEjraee.fldTitle + ')' AS fldStaffName, tblSecretariat.fldID AS SecretariatId, NULL AS PID, 
                      tblCommision.fldID AS CommisionId
	FROM         tblCommision INNER JOIN
                      com.tblAshkhas ON tblCommision.fldAshkhasID = tblAshkhas.fldID INNER JOIN
					  com.tblEmployee on fldHaghighiId=tblEmployee.fldid inner join 
                      com.tblOrganizationalPostsEjraee ON tblCommision.fldOrganizPostEjraeeID = tblOrganizationalPostsEjraee.fldID INNER JOIN
                      auto.tblSecretariat ON tblOrganizationalPostsEjraee.fldChartOrganId = tblSecretariat.fldChartOrganEjraeeId
     WHERE  tblSecretariat.fldID like @value   and fldEndDate>=@tarikh
     
GO
