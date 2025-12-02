CREATE TABLE [Auto].[tblExternalLetterReceiver]
(
[fldID] [int] NOT NULL,
[fldLetterID] [bigint] NULL,
[fldMessageId] [int] NULL,
[fldAshkhasHoghoghiId] [int] NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblExternalLetterReceiver_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblExternalLetterReceiver_fldDesc] DEFAULT (''),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldHoghoghiTitlesId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblExternalLetterReceiver] ADD CONSTRAINT [PK_tblExternalLetterReceiver] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblExternalLetterReceiver] ADD CONSTRAINT [FK_tblExternalLetterReceiver_tblAshkhaseHoghoghiTitles] FOREIGN KEY ([fldHoghoghiTitlesId]) REFERENCES [Auto].[tblAshkhaseHoghoghiTitles] ([fldId])
GO
ALTER TABLE [Auto].[tblExternalLetterReceiver] ADD CONSTRAINT [FK_tblExternalLetterReceiver_tblLetter] FOREIGN KEY ([fldLetterID]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblExternalLetterReceiver] ADD CONSTRAINT [FK_tblExternalLetterReceiver_tblMessage] FOREIGN KEY ([fldMessageId]) REFERENCES [Auto].[tblMessage] ([fldId])
GO
ALTER TABLE [Auto].[tblExternalLetterReceiver] ADD CONSTRAINT [FK_tblExternalLetterReceiver_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblExternalLetterReceiver] ADD CONSTRAINT [FK_tblExternalLetterReceiver_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
