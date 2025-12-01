CREATE TABLE [dbo].[tblFileDesktop_User]
(
[fldId] [int] NOT NULL,
[fldThem] [varbinary] (max) NULL,
[fldPasvand] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldSize] [decimal] (5, 2) NOT NULL,
[fldFileName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblFileDesktop_User] ADD CONSTRAINT [PK_tblThemFile] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'فایل دسکتاپ', 'SCHEMA', N'dbo', 'TABLE', N'tblFileDesktop_User', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'نام فایل', 'SCHEMA', N'dbo', 'TABLE', N'tblFileDesktop_User', 'COLUMN', N'fldFileName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ایدی', 'SCHEMA', N'dbo', 'TABLE', N'tblFileDesktop_User', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'پسوند', 'SCHEMA', N'dbo', 'TABLE', N'tblFileDesktop_User', 'COLUMN', N'fldPasvand'
GO
EXEC sp_addextendedproperty N'MS_Description', N'سایز', 'SCHEMA', N'dbo', 'TABLE', N'tblFileDesktop_User', 'COLUMN', N'fldSize'
GO
EXEC sp_addextendedproperty N'MS_Description', N'عکس مورد نظر', 'SCHEMA', N'dbo', 'TABLE', N'tblFileDesktop_User', 'COLUMN', N'fldThem'
GO
