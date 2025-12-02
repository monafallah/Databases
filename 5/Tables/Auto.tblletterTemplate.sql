CREATE TABLE [Auto].[tblletterTemplate]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIsBackGround] [bit] NOT NULL,
[fldFileId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblletterTemplate_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblletterTemplate_fldDate] DEFAULT (getdate()),
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFormat] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldLetterFileId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblletterTemplate] ADD CONSTRAINT [PK_tblletterTemplate] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblletterTemplate] ADD CONSTRAINT [FK_tblletterTemplate_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [Auto].[tblletterTemplate] ADD CONSTRAINT [FK_tblletterTemplate_tblFile1] FOREIGN KEY ([fldLetterFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [Auto].[tblletterTemplate] ADD CONSTRAINT [FK_tblletterTemplate_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblletterTemplate] ADD CONSTRAINT [FK_tblletterTemplate_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
