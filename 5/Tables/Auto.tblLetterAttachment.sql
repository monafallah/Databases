CREATE TABLE [Auto].[tblLetterAttachment]
(
[fldId] [int] NOT NULL,
[fldLetterID] [bigint] NULL,
[fldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldContentFileID] [int] NULL,
[fldDate] [datetime] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldOrganId] [int] NOT NULL,
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterAttachment] ADD CONSTRAINT [PK_tblLetterAttachment] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterAttachment] ADD CONSTRAINT [FK_tblLetterAttachment_tblContentFile] FOREIGN KEY ([fldContentFileID]) REFERENCES [Auto].[tblContentFile] ([fldId])
GO
ALTER TABLE [Auto].[tblLetterAttachment] ADD CONSTRAINT [FK_tblLetterAttachment_tblLetter] FOREIGN KEY ([fldLetterID]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblLetterAttachment] ADD CONSTRAINT [FK_tblLetterAttachment_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblLetterAttachment] ADD CONSTRAINT [FK_tblLetterAttachment_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
