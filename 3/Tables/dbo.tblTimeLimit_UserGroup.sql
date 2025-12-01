CREATE TABLE [dbo].[tblTimeLimit_UserGroup]
(
[fldId] [int] NOT NULL,
[fldAppId] [int] NOT NULL,
[fldTimeLimit] [smallint] NOT NULL,
[fldUserGroupId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblTimeLimit_UserGroup] ADD CONSTRAINT [PK_tblTimeLimit_UserGroup] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblTimeLimit_UserGroup] ADD CONSTRAINT [FK_tblTimeLimit_UserGroup_tblApplicationPart] FOREIGN KEY ([fldAppId]) REFERENCES [dbo].[tblApplicationPart] ([fldID])
GO
ALTER TABLE [dbo].[tblTimeLimit_UserGroup] ADD CONSTRAINT [FK_tblTimeLimit_UserGroup_tblUserGroup] FOREIGN KEY ([fldUserGroupId]) REFERENCES [dbo].[tblUserGroup] ([fldID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'محدودیت زمانی گروه کاربری', 'SCHEMA', N'dbo', 'TABLE', N'tblTimeLimit_UserGroup', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی آیتم های برنامه', 'SCHEMA', N'dbo', 'TABLE', N'tblTimeLimit_UserGroup', 'COLUMN', N'fldAppId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی', 'SCHEMA', N'dbo', 'TABLE', N'tblTimeLimit_UserGroup', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'زمان محدودیت ', 'SCHEMA', N'dbo', 'TABLE', N'tblTimeLimit_UserGroup', 'COLUMN', N'fldTimeLimit'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ایدی گروه کاربری', 'SCHEMA', N'dbo', 'TABLE', N'tblTimeLimit_UserGroup', 'COLUMN', N'fldUserGroupId'
GO
