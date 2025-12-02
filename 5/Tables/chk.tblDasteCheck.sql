CREATE TABLE [chk].[tblDasteCheck]
(
[fldId] [int] NOT NULL,
[fldIdOlgoCheck] [int] NOT NULL,
[fldIdShomareHesab] [int] NOT NULL,
[fldMoshakhaseDasteCheck] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTedadBarg] [tinyint] NOT NULL,
[fldShoroeSeriyal] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserID] [int] NOT NULL CONSTRAINT [DF_tblDasteCheck_fldUserID] DEFAULT ((1)),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblDasteCheck_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblDasteCheck_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL
) ON [Check] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [chk].[tblDasteCheck] ADD CONSTRAINT [PK_tblDasteCheck] PRIMARY KEY CLUSTERED ([fldId]) ON [Check]
GO
ALTER TABLE [chk].[tblDasteCheck] ADD CONSTRAINT [FK_tblDasteCheck_tblOlgoCheck] FOREIGN KEY ([fldIdOlgoCheck]) REFERENCES [chk].[tblOlgoCheck] ([fldId])
GO
ALTER TABLE [chk].[tblDasteCheck] ADD CONSTRAINT [FK_tblDasteCheck_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [chk].[tblDasteCheck] ADD CONSTRAINT [FK_tblDasteCheck_tblShomareHesabeOmoomi] FOREIGN KEY ([fldIdShomareHesab]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
ALTER TABLE [chk].[tblDasteCheck] ADD CONSTRAINT [FK_tblDasteCheck_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
