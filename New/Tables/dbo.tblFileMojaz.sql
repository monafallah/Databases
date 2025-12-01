CREATE TABLE [dbo].[tblFileMojaz]
(
[fldId] [int] NOT NULL,
[fldArchiveTreeId] [int] NOT NULL,
[fldFormatFileId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFileMojaz_fldDesc] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblFileMojaz] ADD CONSTRAINT [PK_tblFileMojaz] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblFileMojaz] ADD CONSTRAINT [FK_tblFileMojaz_tblFormatFile] FOREIGN KEY ([fldFormatFileId]) REFERENCES [dbo].[tblFormatFile] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'فایل مجاز', 'SCHEMA', N'dbo', 'TABLE', N'tblFileMojaz', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد آرشیو درختی', 'SCHEMA', N'dbo', 'TABLE', N'tblFileMojaz', 'COLUMN', N'fldArchiveTreeId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblFileMojaz', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد فایل فرمت ', 'SCHEMA', N'dbo', 'TABLE', N'tblFileMojaz', 'COLUMN', N'fldFormatFileId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون ای دی', 'SCHEMA', N'dbo', 'TABLE', N'tblFileMojaz', 'COLUMN', N'fldId'
GO
