CREATE TABLE [chk].[tblAghsatCheckAmani]
(
[fldId] [int] NOT NULL,
[fldMablagh] [bigint] NOT NULL,
[fldTarikh] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldNobat] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIdCheckHayeVarede] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblEhtiyatCheckAmani_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblEhtiyatCheckAmani_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [chk].[tblAghsatCheckAmani] ADD CONSTRAINT [PK_tblEhtiyatCheckAmani] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [chk].[tblAghsatCheckAmani] ADD CONSTRAINT [FK_tblAghsatCheckAmani_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [chk].[tblAghsatCheckAmani] ADD CONSTRAINT [FK_tblEhtiyatCheckAmani_tblCheckHayeVarede] FOREIGN KEY ([fldIdCheckHayeVarede]) REFERENCES [chk].[tblCheckHayeVarede] ([fldId])
GO
