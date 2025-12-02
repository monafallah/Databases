CREATE TABLE [chk].[tblSodorCheck]
(
[fldId] [int] NOT NULL,
[fldIdDasteCheck] [int] NOT NULL,
[fldTarikhVosol] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAshkhasId] [int] NOT NULL,
[fldCodeSerialCheck] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldBabat] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldBabatFlag] [bit] NOT NULL,
[fldMablagh] [bigint] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSodorCheck_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblSodorCheck_fldDate] DEFAULT (getdate()),
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL
) ON [Check] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [chk].[tblSodorCheck] ADD CONSTRAINT [PK_tblSodorCheck] PRIMARY KEY CLUSTERED ([fldId]) ON [Check]
GO
ALTER TABLE [chk].[tblSodorCheck] ADD CONSTRAINT [FK_tblSodorCheck_tblAshkhas] FOREIGN KEY ([fldAshkhasId]) REFERENCES [Com].[tblAshkhas] ([fldId])
GO
ALTER TABLE [chk].[tblSodorCheck] ADD CONSTRAINT [FK_tblSodorCheck_tblDasteCheck] FOREIGN KEY ([fldIdDasteCheck]) REFERENCES [chk].[tblDasteCheck] ([fldId])
GO
ALTER TABLE [chk].[tblSodorCheck] ADD CONSTRAINT [FK_tblSodorCheck_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [chk].[tblSodorCheck] ADD CONSTRAINT [FK_tblSodorCheck_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
