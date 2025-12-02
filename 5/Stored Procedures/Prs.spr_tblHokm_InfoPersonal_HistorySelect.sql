SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHokm_InfoPersonal_HistorySelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
		set @Value= Com.fn_TextNormalize (@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldPersonalHokmId], [fldStatusEsargari], [fldCodePosti], [fldAddress], [fldMadrakTahsili], [fldReshteTahsili], [fldRasteShoghli], [fldReshteShoghli], [fldOrganizationalPosts], [fldTabaghe], [fldShomareMojavezEstekhdam], [fldTarikhMojavezEstekhdam], [fldMahleKhedmat], [fldUserId], [fldDate], [fldDesc] ,fldMadrakid
	FROM   [Prs].[tblHokm_InfoPersonal_History] 
	WHERE  fldId = @Value

		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldPersonalHokmId], [fldStatusEsargari], [fldCodePosti], [fldAddress], [fldMadrakTahsili], [fldReshteTahsili], [fldRasteShoghli], [fldReshteShoghli], [fldOrganizationalPosts], [fldTabaghe], [fldShomareMojavezEstekhdam], [fldTarikhMojavezEstekhdam], [fldMahleKhedmat], [fldUserId], [fldDate], [fldDesc] ,fldMadrakid
	FROM   [Prs].[tblHokm_InfoPersonal_History] 
	WHERE  fldDesc LIKE @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldPersonalHokmId], [fldStatusEsargari], [fldCodePosti], [fldAddress], [fldMadrakTahsili], [fldReshteTahsili], [fldRasteShoghli], [fldReshteShoghli], [fldOrganizationalPosts], [fldTabaghe], [fldShomareMojavezEstekhdam], [fldTarikhMojavezEstekhdam], [fldMahleKhedmat], [fldUserId], [fldDate], [fldDesc] ,fldMadrakid
	FROM   [Prs].[tblHokm_InfoPersonal_History] 

	COMMIT
GO
