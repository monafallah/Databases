CREATE TABLE [Auto].[tblContentFile]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldLetterText] [varbinary] (max) NOT NULL,
[fldLetterId] [bigint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblContentFile_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblContentFile_fldDate] DEFAULT (getdate()),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblContentFile] ADD CONSTRAINT [PK_tblContentFile] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblContentFile] ADD CONSTRAINT [FK_tblContentFile_tblLetter] FOREIGN KEY ([fldLetterId]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblContentFile] ADD CONSTRAINT [FK_tblContentFile_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblContentFile] ADD CONSTRAINT [FK_tblContentFile_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
CREATE FULLTEXT INDEX ON [Auto].[tblContentFile] KEY INDEX [PK_tblContentFile] ON [ContentFile]
GO
ALTER FULLTEXT INDEX ON [Auto].[tblContentFile] ADD ([fldLetterText] TYPE COLUMN [fldType] LANGUAGE 1033)
GO
