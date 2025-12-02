CREATE TABLE [Auto].[tblLetterBox]
(
[fldID] [int] NOT NULL,
[fldLetterID] [bigint] NULL,
[fldMessageId] [int] NULL,
[fldBoxID] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblLetterBox_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblLetterBox_fldDesc] DEFAULT (''),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterBox] ADD CONSTRAINT [PK_tblLetterBox] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterBox] ADD CONSTRAINT [FK_tblLetterBox_tblBox] FOREIGN KEY ([fldBoxID]) REFERENCES [Auto].[tblBox] ([fldID])
GO
ALTER TABLE [Auto].[tblLetterBox] ADD CONSTRAINT [FK_tblLetterBox_tblLetter] FOREIGN KEY ([fldLetterID]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblLetterBox] ADD CONSTRAINT [FK_tblLetterBox_tblMessage] FOREIGN KEY ([fldMessageId]) REFERENCES [Auto].[tblMessage] ([fldId])
GO
ALTER TABLE [Auto].[tblLetterBox] ADD CONSTRAINT [FK_tblLetterBox_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblLetterBox] ADD CONSTRAINT [FK_tblLetterBox_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
