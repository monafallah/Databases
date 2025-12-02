CREATE TABLE [Auto].[tblLetterTabagheBandi]
(
[fldId] [int] NOT NULL,
[fldTabagheBandiId] [int] NOT NULL,
[fldLetterId] [bigint] NULL,
[fldMessageId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblLetterTabagheBandi_fldDesc] DEFAULT (''),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblLetterTabagheBandi_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterTabagheBandi] ADD CONSTRAINT [PK_tblLetterTabagheBandi] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterTabagheBandi] ADD CONSTRAINT [FK_tblLetterTabagheBandi_tblLetter] FOREIGN KEY ([fldLetterId]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblLetterTabagheBandi] ADD CONSTRAINT [FK_tblLetterTabagheBandi_tblMessage] FOREIGN KEY ([fldMessageId]) REFERENCES [Auto].[tblMessage] ([fldId])
GO
ALTER TABLE [Auto].[tblLetterTabagheBandi] ADD CONSTRAINT [FK_tblLetterTabagheBandi_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblLetterTabagheBandi] ADD CONSTRAINT [FK_tblLetterTabagheBandi_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
