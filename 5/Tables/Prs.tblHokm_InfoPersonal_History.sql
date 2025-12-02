CREATE TABLE [Prs].[tblHokm_InfoPersonal_History]
(
[fldId] [int] NOT NULL,
[fldPersonalHokmId] [int] NOT NULL,
[fldStatusEsargari] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldCodePosti] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAddress] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldMadrakTahsili] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldReshteTahsili] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldRasteShoghli] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldReshteShoghli] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldOrganizationalPosts] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTabaghe] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShomareMojavezEstekhdam] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldTarikhMojavezEstekhdam] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldMahleKhedmat] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblHokm_InfoPersonal_History_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblHokm_InfoPersonal_History_fldDesc] DEFAULT (''),
[fldMadrakId] [int] NULL,
[fldPostEjraee] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [Personeli]
GO
ALTER TABLE [Prs].[tblHokm_InfoPersonal_History] ADD CONSTRAINT [PK_tblHokm_InfoPersonal_History] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
CREATE NONCLUSTERED INDEX [IxPersonalHokmId>] ON [Prs].[tblHokm_InfoPersonal_History] ([fldPersonalHokmId]) INCLUDE ([fldStatusEsargari], [fldCodePosti], [fldAddress], [fldMadrakTahsili], [fldReshteTahsili], [fldRasteShoghli], [fldReshteShoghli], [fldOrganizationalPosts], [fldTabaghe], [fldShomareMojavezEstekhdam], [fldTarikhMojavezEstekhdam], [fldMadrakId], [fldPostEjraee]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblHokm_InfoPersonal_History] ADD CONSTRAINT [FK_tblHokm_InfoPersonal_History_PersonalHokm] FOREIGN KEY ([fldPersonalHokmId]) REFERENCES [Prs].[tblPersonalHokm] ([fldId])
GO
ALTER TABLE [Prs].[tblHokm_InfoPersonal_History] ADD CONSTRAINT [FK_tblHokm_InfoPersonal_History_tblMadrakTahsili] FOREIGN KEY ([fldMadrakId]) REFERENCES [Com].[tblMadrakTahsili] ([fldId])
GO
ALTER TABLE [Prs].[tblHokm_InfoPersonal_History] ADD CONSTRAINT [FK_tblHokm_InfoPersonal_History_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
