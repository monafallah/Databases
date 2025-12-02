CREATE TABLE [Arch].[tblFileMojaz]
(
[fldId] [int] NOT NULL,
[fldArchiveTreeId] [int] NOT NULL,
[fldFormatFileId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFileMojaz_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFileMojaz_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblFileMojaz] ADD CONSTRAINT [PK_tblFileMojaz] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblFileMojaz] ADD CONSTRAINT [IX_tblFileMojaz] UNIQUE NONCLUSTERED ([fldArchiveTreeId], [fldFormatFileId]) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblFileMojaz] ADD CONSTRAINT [FK_tblFileMojaz_tblArchiveTree] FOREIGN KEY ([fldArchiveTreeId]) REFERENCES [Arch].[tblArchiveTree] ([fldId])
GO
ALTER TABLE [Arch].[tblFileMojaz] ADD CONSTRAINT [FK_tblFileMojaz_tblFormatFile] FOREIGN KEY ([fldFormatFileId]) REFERENCES [Arch].[tblFormatFile] ([fldId])
GO
ALTER TABLE [Arch].[tblFileMojaz] ADD CONSTRAINT [FK_tblFileMojaz_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
