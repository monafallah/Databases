CREATE TABLE [Prs].[Prs_tblPersonalInfo]
(
[fldId] [int] NOT NULL,
[fldEmployeeId] [int] NOT NULL,
[fldEsargariId] [int] NOT NULL,
[fldSharhEsargari] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldSh_Personali] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganPostId] [int] NOT NULL,
[fldRasteShoghli] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldReshteShoghli] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldTarikhEstekhdam] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTabaghe] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldSh_MojavezEstekhdam] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldTarikhMajavezEstekhdam] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblPersonalInfo_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblPersonalInfo_fldDate] DEFAULT (getdate()),
[fldOrganPostEjraeeId] [int] NULL
) ON [Personeli]
GO
ALTER TABLE [Prs].[Prs_tblPersonalInfo] ADD CONSTRAINT [PK_tblPersonalInfo] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
CREATE NONCLUSTERED INDEX [IX_Prs_tblPersonalInfo] ON [Prs].[Prs_tblPersonalInfo] ([fldSh_Personali]) ON [PRIMARY]
GO
ALTER TABLE [Prs].[Prs_tblPersonalInfo] ADD CONSTRAINT [FK_Prs_tblPersonalInfo_tblEmployee] FOREIGN KEY ([fldEmployeeId]) REFERENCES [Com].[tblEmployee] ([fldId])
GO
ALTER TABLE [Prs].[Prs_tblPersonalInfo] ADD CONSTRAINT [FK_Prs_tblPersonalInfo_tblOrganizationalPosts] FOREIGN KEY ([fldOrganPostId]) REFERENCES [Com].[tblOrganizationalPosts] ([fldId])
GO
ALTER TABLE [Prs].[Prs_tblPersonalInfo] ADD CONSTRAINT [FK_Prs_tblPersonalInfo_tblOrganizationalPostsEjraee] FOREIGN KEY ([fldOrganPostEjraeeId]) REFERENCES [Com].[tblOrganizationalPostsEjraee] ([fldId])
GO
ALTER TABLE [Prs].[Prs_tblPersonalInfo] ADD CONSTRAINT [FK_Prs_tblPersonalInfo_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Prs].[Prs_tblPersonalInfo] ADD CONSTRAINT [FK_tblPersonalInfo_tblVaziyatEsargari] FOREIGN KEY ([fldEsargariId]) REFERENCES [Prs].[tblVaziyatEsargari] ([fldId])
GO
