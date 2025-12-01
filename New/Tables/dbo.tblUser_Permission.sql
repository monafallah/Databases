CREATE TABLE [dbo].[tblUser_Permission]
(
[fldId] [int] NOT NULL,
[fldUserSelectId] [int] NOT NULL,
[fldAppId] [int] NOT NULL,
[fldIsAccept] [bit] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblUser_Permission_fldDesc] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblUser_Permission] ADD CONSTRAINT [PK_tblUser_Permission] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblUser_Permission] ADD CONSTRAINT [FK_tblUser_Permission_tblApplicationPart] FOREIGN KEY ([fldAppId]) REFERENCES [dbo].[tblApplicationPart] ([fldID])
GO
ALTER TABLE [dbo].[tblUser_Permission] ADD CONSTRAINT [FK_tblUser_Permission_tblUser] FOREIGN KEY ([fldUserSelectId]) REFERENCES [dbo].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'دسترسی خاص', 'SCHEMA', N'dbo', 'TABLE', N'tblUser_Permission', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد آیتم های برنامه', 'SCHEMA', N'dbo', 'TABLE', N'tblUser_Permission', 'COLUMN', N'fldAppId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblUser_Permission', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد', 'SCHEMA', N'dbo', 'TABLE', N'tblUser_Permission', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'پذیرفتن / رد کردن', 'SCHEMA', N'dbo', 'TABLE', N'tblUser_Permission', 'COLUMN', N'fldIsAccept'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربر انتخاب شده', 'SCHEMA', N'dbo', 'TABLE', N'tblUser_Permission', 'COLUMN', N'fldUserSelectId'
GO
