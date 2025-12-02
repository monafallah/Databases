CREATE TABLE [Auto].[tblLetterActions]
(
[fldId] [int] NOT NULL,
[fldLetterId] [bigint] NOT NULL,
[fldTarikhAnjam] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTimeAnjam] [nvarchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldLetterActionTypeId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblLetterActions_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblLetterActions_fldDate] DEFAULT (getdate()),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterActions] ADD CONSTRAINT [PK_tblLetterActions] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterActions] ADD CONSTRAINT [FK_tblLetterActions_tblLetter] FOREIGN KEY ([fldLetterId]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblLetterActions] ADD CONSTRAINT [FK_tblLetterActions_tblLetterActionType] FOREIGN KEY ([fldLetterActionTypeId]) REFERENCES [Auto].[tblLetterActionType] ([fldId])
GO
ALTER TABLE [Auto].[tblLetterActions] ADD CONSTRAINT [FK_tblLetterActions_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblLetterActions] ADD CONSTRAINT [FK_tblLetterActions_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
