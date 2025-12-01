CREATE TABLE [dbo].[tblFile]
(
[fldId] [int] NOT NULL,
[fldFile] [varbinary] (max) NOT NULL,
[fldPasvand] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFile_fldDesc] DEFAULT (''),
[fldFileName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldSize] [decimal] (8, 3) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblFile] ADD CONSTRAINT [PK_tblFile] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'فایل ها', 'SCHEMA', N'dbo', 'TABLE', N'tblFile', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblFile', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'فایل', 'SCHEMA', N'dbo', 'TABLE', N'tblFile', 'COLUMN', N'fldFile'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نام فایل ', 'SCHEMA', N'dbo', 'TABLE', N'tblFile', 'COLUMN', N'fldFileName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد', 'SCHEMA', N'dbo', 'TABLE', N'tblFile', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'پسوند', 'SCHEMA', N'dbo', 'TABLE', N'tblFile', 'COLUMN', N'fldPasvand'
GO
EXEC sp_addextendedproperty N'MS_Description', N'سایز فایل', 'SCHEMA', N'dbo', 'TABLE', N'tblFile', 'COLUMN', N'fldSize'
GO
