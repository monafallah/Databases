CREATE TABLE [dbo].[tblThemDesktop_User]
(
[fldId] [int] NOT NULL,
[fldFileDesktopId] [int] NULL,
[fldType] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblThemDesktop_fldDesc] DEFAULT (''),
[fldThem] [tinyint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblThemDesktop_User] ADD CONSTRAINT [PK_tblThemDesktop] PRIMARY KEY NONCLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblThemDesktop_User] ADD CONSTRAINT [IX_tblThemDesktop] UNIQUE CLUSTERED ([fldUserId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblThemDesktop_User] ADD CONSTRAINT [FK_tblThemDesktop_tblThemFile] FOREIGN KEY ([fldFileDesktopId]) REFERENCES [dbo].[tblFileDesktop_User] ([fldId])
GO
ALTER TABLE [dbo].[tblThemDesktop_User] ADD CONSTRAINT [FK_tblThemDesktop_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [dbo].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'عکس دسکتاپ', 'SCHEMA', N'dbo', 'TABLE', N'tblThemDesktop_User', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblThemDesktop_User', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی فایل', 'SCHEMA', N'dbo', 'TABLE', N'tblThemDesktop_User', 'COLUMN', N'fldFileDesktopId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی', 'SCHEMA', N'dbo', 'TABLE', N'tblThemDesktop_User', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'تم مورد نظر', 'SCHEMA', N'dbo', 'TABLE', N'tblThemDesktop_User', 'COLUMN', N'fldThem'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نوع', 'SCHEMA', N'dbo', 'TABLE', N'tblThemDesktop_User', 'COLUMN', N'fldType'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربر', 'SCHEMA', N'dbo', 'TABLE', N'tblThemDesktop_User', 'COLUMN', N'fldUserId'
GO
