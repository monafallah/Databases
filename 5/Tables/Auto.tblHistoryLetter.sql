CREATE TABLE [Auto].[tblHistoryLetter]
(
[fldId] [int] NOT NULL,
[fldCurrentLetter_Id] [bigint] NOT NULL,
[fldHistoryType_Id] [int] NOT NULL,
[fldHistoryLetter_Id] [bigint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_tblHistoryLetter_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblHistoryLetter_fldDate] DEFAULT (getdate()),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblHistoryLetter] ADD CONSTRAINT [PK_tblHistoryLetter_1] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblHistoryLetter] ADD CONSTRAINT [FK_tblHistoryLetter_tblHistoryType] FOREIGN KEY ([fldHistoryType_Id]) REFERENCES [Auto].[tblHistoryType] ([fldId])
GO
ALTER TABLE [Auto].[tblHistoryLetter] ADD CONSTRAINT [FK_tblHistoryLetter_tblLetter] FOREIGN KEY ([fldCurrentLetter_Id]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblHistoryLetter] ADD CONSTRAINT [FK_tblHistoryLetter_tblLetter1] FOREIGN KEY ([fldHistoryLetter_Id]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblHistoryLetter] ADD CONSTRAINT [FK_tblHistoryLetter_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblHistoryLetter] ADD CONSTRAINT [FK_tblHistoryLetter_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
