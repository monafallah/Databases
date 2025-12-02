CREATE TABLE [Prs].[tblMoteghayerhaAhkam]
(
[fldId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldType] [bit] NOT NULL,
[fldHagheOlad] [int] NOT NULL,
[fldHagheAeleMandi] [int] NOT NULL,
[fldKharoBar] [int] NOT NULL,
[fldMaskan] [int] NOT NULL,
[fldKharoBarMojarad] [int] NOT NULL,
[fldHadaghalDaryafti] [int] NOT NULL,
[fldHaghBon] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblMoteghayerhaAhkam_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblMoteghayerhaAhkam_fldDesc] DEFAULT (''),
[fldHadaghalTadil] [int] NOT NULL CONSTRAINT [DF_tblMoteghayerhaAhkam_fldHadaghalTadil] DEFAULT ((0))
) ON [Personeli]
GO
ALTER TABLE [Prs].[tblMoteghayerhaAhkam] ADD CONSTRAINT [PK_tblMoteghayerhaAhkam] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblMoteghayerhaAhkam] ADD CONSTRAINT [FK_tblMoteghayerhaAhkam_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
