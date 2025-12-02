CREATE TABLE [Prs].[tblVaziyatEsargari]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMoafAsBime] [bit] NOT NULL CONSTRAINT [DF_Prs_tblVaziyatEsargari_fldMoafAsBime] DEFAULT ((0)),
[fldMoafAsBimeOmr] [bit] NULL CONSTRAINT [DF_tblVaziyatEsargari_fldMoafAsBime1] DEFAULT ((0)),
[fldMoafAsMaliyat] [bit] NOT NULL CONSTRAINT [DF_Prs_tblVaziyatEsargari_fldMoafAsMaliyat] DEFAULT ((0)),
[fldMoafAsBimeTakmili] [bit] NULL CONSTRAINT [DF_tblVaziyatEsargari_fldMoafAsMaliyat1] DEFAULT ((0)),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblVaziyatEsargari_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblVaziyatEsargari_fldDate] DEFAULT (getdate()),
[fldMaliyatEsargari] [tinyint] NULL,
[fldEsarBazneshastegi] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldNesbatBaz] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [Personeli]
GO
ALTER TABLE [Prs].[tblVaziyatEsargari] ADD CONSTRAINT [PK_tblVaziyatEsargari] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblVaziyatEsargari] ADD CONSTRAINT [FK_tblVaziyatEsargari_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
