CREATE TABLE [dbo].[tblTimeLimit_User]
(
[fldId] [int] NOT NULL,
[fldAppId] [int] NOT NULL,
[fldTimeLimit] [smallint] NOT NULL CONSTRAINT [DF_tblTimeLimit_User_fldTimeLimit] DEFAULT ((0)),
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblTimeLimit_User] ADD CONSTRAINT [PK_tblTimeLimit_User] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblTimeLimit_User] ADD CONSTRAINT [FK_tblTimeLimit_User_tblApplicationPart] FOREIGN KEY ([fldAppId]) REFERENCES [dbo].[tblApplicationPart] ([fldID])
GO
ALTER TABLE [dbo].[tblTimeLimit_User] ADD CONSTRAINT [FK_tblTimeLimit_User_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [dbo].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'محدودیت زمانی کاربر', 'SCHEMA', N'dbo', 'TABLE', N'tblTimeLimit_User', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی آیتم برنامه', 'SCHEMA', N'dbo', 'TABLE', N'tblTimeLimit_User', 'COLUMN', N'fldAppId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی', 'SCHEMA', N'dbo', 'TABLE', N'tblTimeLimit_User', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'مدت زمان محدودیت', 'SCHEMA', N'dbo', 'TABLE', N'tblTimeLimit_User', 'COLUMN', N'fldTimeLimit'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی کاربر', 'SCHEMA', N'dbo', 'TABLE', N'tblTimeLimit_User', 'COLUMN', N'fldUserId'
GO
