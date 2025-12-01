CREATE TABLE [dbo].[tblUser_Group]
(
[fldID] [int] NOT NULL,
[fldUserGroupID] [int] NOT NULL,
[fldUserSelectID] [int] NOT NULL,
[fldGrant] [bit] NOT NULL,
[fldWithGrant] [bit] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblUser_Group_fldDesc] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblUser_Group] ADD CONSTRAINT [PK_tblUser_Group] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblUser_Group] ADD CONSTRAINT [FK_tblUser_Group_tblUser] FOREIGN KEY ([fldUserSelectID]) REFERENCES [dbo].[tblUser] ([fldId])
GO
ALTER TABLE [dbo].[tblUser_Group] ADD CONSTRAINT [FK_tblUser_Group_tblUserGroup] FOREIGN KEY ([fldUserGroupID]) REFERENCES [dbo].[tblUserGroup] ([fldID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'گروه کاربری- کاربر انتخاب شده', 'SCHEMA', N'dbo', 'TABLE', N'tblUser_Group', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblUser_Group', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'مجوز دسترسی دادن', 'SCHEMA', N'dbo', 'TABLE', N'tblUser_Group', 'COLUMN', N'fldGrant'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد', 'SCHEMA', N'dbo', 'TABLE', N'tblUser_Group', 'COLUMN', N'fldID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد گروه کاربری', 'SCHEMA', N'dbo', 'TABLE', N'tblUser_Group', 'COLUMN', N'fldUserGroupID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربر انتخاب شده', 'SCHEMA', N'dbo', 'TABLE', N'tblUser_Group', 'COLUMN', N'fldUserSelectID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'مجوز دسترسی دادن', 'SCHEMA', N'dbo', 'TABLE', N'tblUser_Group', 'COLUMN', N'fldWithGrant'
GO
