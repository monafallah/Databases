CREATE TABLE [Auto].[tblExternalLetterSender]
(
[fldID] [int] NOT NULL,
[fldLetterID] [bigint] NULL,
[fldMessageId] [int] NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblExternalLetterSender_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL,
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblExternalLetterSender_fldDesc] DEFAULT (''),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShakhsHoghoghiTitlesId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblExternalLetterSender] ADD CONSTRAINT [PK_tblExternalLetterSender] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblExternalLetterSender] ADD CONSTRAINT [FK_tblExternalLetterSender_tblExternalLetterSender1] FOREIGN KEY ([fldShakhsHoghoghiTitlesId]) REFERENCES [Auto].[tblAshkhaseHoghoghiTitles] ([fldId])
GO
ALTER TABLE [Auto].[tblExternalLetterSender] ADD CONSTRAINT [FK_tblExternalLetterSender_tblLetter] FOREIGN KEY ([fldLetterID]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblExternalLetterSender] ADD CONSTRAINT [FK_tblExternalLetterSender_tblMessage] FOREIGN KEY ([fldMessageId]) REFERENCES [Auto].[tblMessage] ([fldId])
GO
ALTER TABLE [Auto].[tblExternalLetterSender] ADD CONSTRAINT [FK_tblExternalLetterSender_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblExternalLetterSender] ADD CONSTRAINT [FK_tblExternalLetterSender_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
