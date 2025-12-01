CREATE TABLE [dbo].[tblHelp]
(
[fldId] [int] NOT NULL,
[fldFormName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFilePdfId] [int] NULL,
[fldFileVideoId] [int] NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblHelp_fldDesc] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblHelp] ADD CONSTRAINT [PK_tblHelp] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblHelp] ADD CONSTRAINT [FK_tblHelp_tblFile] FOREIGN KEY ([fldFilePdfId]) REFERENCES [dbo].[tblFile] ([fldId])
GO
ALTER TABLE [dbo].[tblHelp] ADD CONSTRAINT [FK_tblHelp_tblFile1] FOREIGN KEY ([fldFileVideoId]) REFERENCES [dbo].[tblFile] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'راهنماها', 'SCHEMA', N'dbo', 'TABLE', N'tblHelp', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblHelp', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد فایل pdf', 'SCHEMA', N'dbo', 'TABLE', N'tblHelp', 'COLUMN', N'fldFilePdfId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد فایل ویدیو', 'SCHEMA', N'dbo', 'TABLE', N'tblHelp', 'COLUMN', N'fldFileVideoId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نام فرم', 'SCHEMA', N'dbo', 'TABLE', N'tblHelp', 'COLUMN', N'fldFormName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون ای دی', 'SCHEMA', N'dbo', 'TABLE', N'tblHelp', 'COLUMN', N'fldId'
GO
