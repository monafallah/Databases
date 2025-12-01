CREATE TABLE [dbo].[tblSetting]
(
[fldId] [int] NOT NULL CONSTRAINT [DF_tblSetting_fldId] DEFAULT ((1)),
[fldTitle] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFile] [varbinary] (max) NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSetting_fldDesc] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblSetting] ADD CONSTRAINT [PK_tblSetting] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'تنظیمات', 'SCHEMA', N'dbo', 'TABLE', N'tblSetting', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblSetting', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'فایل', 'SCHEMA', N'dbo', 'TABLE', N'tblSetting', 'COLUMN', N'fldFile'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد', 'SCHEMA', N'dbo', 'TABLE', N'tblSetting', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'عنوان', 'SCHEMA', N'dbo', 'TABLE', N'tblSetting', 'COLUMN', N'fldTitle'
GO
