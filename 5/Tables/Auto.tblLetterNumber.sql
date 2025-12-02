CREATE TABLE [Auto].[tblLetterNumber]
(
[fldID] [int] NOT NULL,
[fldLetterID] [bigint] NOT NULL,
[fldYear] [int] NOT NULL,
[fldNumber] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblLetterNumber_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblLetterNumber_fldDesc] DEFAULT (''),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterNumber] ADD CONSTRAINT [PK_tblLetterNumber] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterNumber] ADD CONSTRAINT [FK_tblLetterNumber_tblLetter] FOREIGN KEY ([fldLetterID]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblLetterNumber] ADD CONSTRAINT [FK_tblLetterNumber_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblLetterNumber] ADD CONSTRAINT [FK_tblLetterNumber_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
