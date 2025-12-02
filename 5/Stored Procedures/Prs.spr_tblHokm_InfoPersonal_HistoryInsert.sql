SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHokm_InfoPersonal_HistoryInsert] 

    @fldPersonalHokmId int,
    @fldStatusEsargari nvarchar(MAX),
    @fldCodePosti nvarchar(10),
    @fldAddress nvarchar(MAX),
    @fldMadrakTahsili nvarchar(100),
    @fldReshteTahsili nvarchar(100),
    @fldRasteShoghli nvarchar(MAX),
    @fldReshteShoghli nvarchar(MAX),
    @fldOrganizationalPosts nvarchar(150),
    @fldTabaghe nvarchar(50),
    @fldShomareMojavezEstekhdam nvarchar(50),
    @fldTarikhMojavezEstekhdam nvarchar(10),
    @fldMahleKhedmat nvarchar(200),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldMadrakid int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblHokm_InfoPersonal_History] 
	INSERT INTO [Prs].[tblHokm_InfoPersonal_History] ([fldId], [fldPersonalHokmId], [fldStatusEsargari], [fldCodePosti], [fldAddress], [fldMadrakTahsili], [fldReshteTahsili], [fldRasteShoghli], [fldReshteShoghli], [fldOrganizationalPosts], [fldTabaghe], [fldShomareMojavezEstekhdam], [fldTarikhMojavezEstekhdam], [fldMahleKhedmat], [fldUserId], [fldDate], [fldDesc],fldMadrakid)
	SELECT @fldId, @fldPersonalHokmId, @fldStatusEsargari, @fldCodePosti, @fldAddress, @fldMadrakTahsili, @fldReshteTahsili, @fldRasteShoghli, @fldReshteShoghli, @fldOrganizationalPosts, @fldTabaghe, @fldShomareMojavezEstekhdam, @fldTarikhMojavezEstekhdam, @fldMahleKhedmat, @fldUserId, GETDATE(), @fldDesc,@fldMadrakid
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
