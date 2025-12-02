CREATE TABLE [Auto].[tblLetterArchive]
(
[fldId] [int] NOT NULL,
[fldLetterId] [bigint] NULL,
[fldMessageId] [int] NULL,
[fldArchiveID] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblLetterArchive_fldDate] DEFAULT (getdate()),
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblLetterArchive_fldDesc] DEFAULT (''),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterArchive] ADD CONSTRAINT [PK_tblLetterArchive] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterArchive] ADD CONSTRAINT [FK_tblLetterArchive_tblArchive] FOREIGN KEY ([fldArchiveID]) REFERENCES [Auto].[tblArchive] ([fldId])
GO
ALTER TABLE [Auto].[tblLetterArchive] ADD CONSTRAINT [FK_tblLetterArchive_tblLetter] FOREIGN KEY ([fldLetterId]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblLetterArchive] ADD CONSTRAINT [FK_tblLetterArchive_tblMessage] FOREIGN KEY ([fldMessageId]) REFERENCES [Auto].[tblMessage] ([fldId])
GO
ALTER TABLE [Auto].[tblLetterArchive] ADD CONSTRAINT [FK_tblLetterArchive_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblLetterArchive] ADD CONSTRAINT [FK_tblLetterArchive_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
