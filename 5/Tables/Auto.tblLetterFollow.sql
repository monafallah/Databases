CREATE TABLE [Auto].[tblLetterFollow]
(
[fldId] [int] NOT NULL,
[fldLetterText] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldLetterId] [bigint] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblLetterFollow_fldDate] DEFAULT (getdate()),
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblLetterFollow_fldDesc] DEFAULT (''),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterFollow] ADD CONSTRAINT [PK_tblLetterFollow] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterFollow] ADD CONSTRAINT [FK_tblLetterFollow_tblLetter] FOREIGN KEY ([fldLetterId]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblLetterFollow] ADD CONSTRAINT [FK_tblLetterFollow_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblLetterFollow] ADD CONSTRAINT [FK_tblLetterFollow_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
