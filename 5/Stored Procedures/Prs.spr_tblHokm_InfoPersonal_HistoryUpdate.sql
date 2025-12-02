SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHokm_InfoPersonal_HistoryUpdate] 
    @fldId int,
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
     @fldMadrakid INT
AS 
	BEGIN TRAN
	SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Prs].[tblHokm_InfoPersonal_History]
	SET    [fldId] = @fldId, [fldPersonalHokmId] = @fldPersonalHokmId, [fldStatusEsargari] = @fldStatusEsargari, [fldCodePosti] = @fldCodePosti, [fldAddress] = @fldAddress, [fldMadrakTahsili] = @fldMadrakTahsili, [fldReshteTahsili] = @fldReshteTahsili, [fldRasteShoghli] = @fldRasteShoghli, [fldReshteShoghli] = @fldReshteShoghli, [fldOrganizationalPosts] = @fldOrganizationalPosts, [fldTabaghe] = @fldTabaghe, [fldShomareMojavezEstekhdam] = @fldShomareMojavezEstekhdam, [fldTarikhMojavezEstekhdam] = @fldTarikhMojavezEstekhdam, [fldMahleKhedmat] = @fldMahleKhedmat, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc,fldMadrakid=@fldMadrakid
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
