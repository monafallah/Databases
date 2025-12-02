CREATE TABLE [Weigh].[tblBaskolDocument]
(
[fldId] [int] NOT NULL,
[fldTozinId] [int] NOT NULL,
[fldFileId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblBaskolDocument_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblBaskolDocument_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblBaskolDocument] ADD CONSTRAINT [PK_tblBaskolDocument] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblBaskolDocument] ADD CONSTRAINT [FK_tblBaskolDocument_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [Weigh].[tblBaskolDocument] ADD CONSTRAINT [FK_tblBaskolDocument_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Weigh].[tblBaskolDocument] ADD CONSTRAINT [FK_tblBaskolDocument_tblTozin] FOREIGN KEY ([fldTozinId]) REFERENCES [Weigh].[tblTozin] ([fldId])
GO
ALTER TABLE [Weigh].[tblBaskolDocument] ADD CONSTRAINT [FK_tblBaskolDocument_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
