CREATE TABLE [dbo].[tblPermission]
(
[fldID] [int] NOT NULL,
[fldUserGroupID] [int] NOT NULL,
[fldApplicationPartID] [int] NOT NULL,
[fldInpuId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPermission_fldDesc] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblPermission] ADD CONSTRAINT [PK_tblPermission] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblPermission] ON [dbo].[tblPermission] ([fldApplicationPartID], [fldUserGroupID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblPermission] ADD CONSTRAINT [FK_tblPermission_tblApplicationPart] FOREIGN KEY ([fldApplicationPartID]) REFERENCES [dbo].[tblApplicationPart] ([fldID])
GO
ALTER TABLE [dbo].[tblPermission] ADD CONSTRAINT [FK_tblPermission_tblInputInfo] FOREIGN KEY ([fldInpuId]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
ALTER TABLE [dbo].[tblPermission] ADD CONSTRAINT [FK_tblPermission_tblUserGroup] FOREIGN KEY ([fldUserGroupID]) REFERENCES [dbo].[tblUserGroup] ([fldID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'دسترسی ها', 'SCHEMA', N'dbo', 'TABLE', N'tblPermission', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی آیتم برنامه', 'SCHEMA', N'dbo', 'TABLE', N'tblPermission', 'COLUMN', N'fldApplicationPartID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblPermission', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون آیدی', 'SCHEMA', N'dbo', 'TABLE', N'tblPermission', 'COLUMN', N'fldID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی گروه کاربری', 'SCHEMA', N'dbo', 'TABLE', N'tblPermission', 'COLUMN', N'fldUserGroupID'
GO
