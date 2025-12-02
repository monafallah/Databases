CREATE TABLE [Auto].[tblMessageAttachment]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMessageId] [int] NOT NULL,
[fldFileId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMessageAttachment_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMessageAttachment_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL,
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblMessageAttachment] ADD CONSTRAINT [PK_tblMessageAttachment] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblMessageAttachment] ADD CONSTRAINT [FK_tblMessageAttachment_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [Auto].[tblMessageAttachment] ADD CONSTRAINT [FK_tblMessageAttachment_tblMessage] FOREIGN KEY ([fldMessageId]) REFERENCES [Auto].[tblMessage] ([fldId])
GO
ALTER TABLE [Auto].[tblMessageAttachment] ADD CONSTRAINT [FK_tblMessageAttachment_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblMessageAttachment] ADD CONSTRAINT [FK_tblMessageAttachment_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
