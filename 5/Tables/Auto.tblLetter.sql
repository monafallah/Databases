CREATE TABLE [Auto].[tblLetter]
(
[fldID] [bigint] NOT NULL,
[fldYear] [int] NOT NULL CONSTRAINT [DF_tblLetter_fldYear] DEFAULT ((1392)),
[fldOrderId] [bigint] NOT NULL CONSTRAINT [DF_tblLetter_fldOrderId] DEFAULT ((1)),
[fldSubject] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldLetterNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldLetterDate] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldCreatedDate] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldKeywords] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldLetterStatusID] [int] NULL,
[fldComisionID] [int] NOT NULL,
[fldImmediacyID] [int] NOT NULL,
[fldSecurityTypeID] [int] NOT NULL,
[fldLetterTypeID] [int] NOT NULL,
[fldSignType] [tinyint] NOT NULL CONSTRAINT [DF_tblLetter_fldSignType] DEFAULT ((0)),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblLetter_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblLetter_fldDesc] DEFAULT (''),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMatnLetter] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblLetter_fldMatnLetter] DEFAULT (''),
[fldLetterTemplateId] [int] NULL,
[fldContentFileID] [int] NULL,
[fldFont] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetter] ADD CONSTRAINT [PK_tblLetter] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetter] ADD CONSTRAINT [IX_tblLetter] UNIQUE NONCLUSTERED ([fldOrderId], [fldYear]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetter] ADD CONSTRAINT [FK_tblLetter_tblCommision] FOREIGN KEY ([fldComisionID]) REFERENCES [Auto].[tblCommision] ([fldID])
GO
ALTER TABLE [Auto].[tblLetter] ADD CONSTRAINT [FK_tblLetter_tblContentFile] FOREIGN KEY ([fldContentFileID]) REFERENCES [Auto].[tblContentFile] ([fldId])
GO
ALTER TABLE [Auto].[tblLetter] ADD CONSTRAINT [FK_tblLetter_tblImmediacy] FOREIGN KEY ([fldImmediacyID]) REFERENCES [Auto].[tblImmediacy] ([fldID])
GO
ALTER TABLE [Auto].[tblLetter] ADD CONSTRAINT [FK_tblLetter_tblLetterStatus] FOREIGN KEY ([fldLetterStatusID]) REFERENCES [Auto].[tblLetterStatus] ([fldId])
GO
ALTER TABLE [Auto].[tblLetter] ADD CONSTRAINT [FK_tblLetter_tblletterTemplate] FOREIGN KEY ([fldLetterTemplateId]) REFERENCES [Auto].[tblletterTemplate] ([fldId])
GO
ALTER TABLE [Auto].[tblLetter] ADD CONSTRAINT [FK_tblLetter_tblLetterType] FOREIGN KEY ([fldLetterTypeID]) REFERENCES [Auto].[tblLetterType] ([fldID])
GO
ALTER TABLE [Auto].[tblLetter] ADD CONSTRAINT [FK_tblLetter_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblLetter] ADD CONSTRAINT [FK_tblLetter_tblSecurityType] FOREIGN KEY ([fldSecurityTypeID]) REFERENCES [Auto].[tblSecurityType] ([fldID])
GO
ALTER TABLE [Auto].[tblLetter] ADD CONSTRAINT [FK_tblLetter_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
