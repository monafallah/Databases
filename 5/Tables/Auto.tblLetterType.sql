CREATE TABLE [Auto].[tblLetterType]
(
[fldID] [int] NOT NULL,
[fldLetterType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganID] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblLetterType_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblLetterType_fldDesc] DEFAULT (''),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterType] ADD CONSTRAINT [PK_tblLetterType] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterType] ADD CONSTRAINT [FK_tblLetterType_tblOrganization] FOREIGN KEY ([fldOrganID]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblLetterType] ADD CONSTRAINT [FK_tblLetterType_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
