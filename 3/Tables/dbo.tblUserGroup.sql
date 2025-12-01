CREATE TABLE [dbo].[tblUserGroupHistory]
(
[fldID] [int] NOT NULL,
[fldTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL,
[fldInputID] [int] NOT NULL,
[fldUserType] [tinyint] NOT NULL,
[fldTimeStamp] [timestamp] NOT NULL,
[StartTime] [datetime2] NOT NULL,
[EndTime] [datetime2] NOT NULL,
[fldOrder] [int] NULL
) ON [PRIMARY]
WITH
(
DATA_COMPRESSION = PAGE
)
GO
CREATE CLUSTERED INDEX [ix_tblUserGroupHistory] ON [dbo].[tblUserGroupHistory] ([EndTime], [StartTime]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE TABLE [dbo].[tblUserGroup]
(
[fldID] [int] NOT NULL,
[fldTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblUserGroup_fldTitle] DEFAULT (''),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblUserGroup_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblUserGroup_fldDate] DEFAULT (getdate()),
[fldInputID] [int] NOT NULL,
[fldUserType] [tinyint] NOT NULL,
[fldTimeStamp] [timestamp] NOT NULL,
[StartTime] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL CONSTRAINT [DF__tblUserGr__Start__6A7BAA63] DEFAULT (getutcdate()),
[EndTime] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL CONSTRAINT [DF__tblUserGr__EndTi__6B6FCE9C] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')),
[fldOrder] [int] NULL,
PERIOD FOR SYSTEM_TIME (StartTime, EndTime),
CONSTRAINT [PK_tblUserGroup] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[tblUserGroupHistory])
)
GO
ALTER TABLE [dbo].[tblUserGroup] ADD CONSTRAINT [IX_tblUserGroup] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblUserGroup] ADD CONSTRAINT [FK_tblUserGroup_tblInputInfo] FOREIGN KEY ([fldInputID]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
ALTER TABLE [dbo].[tblUserGroup] ADD CONSTRAINT [FK_tblUserGroup_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [dbo].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'گروه کاربر', 'SCHEMA', N'dbo', 'TABLE', N'tblUserGroup', NULL, NULL
GO
EXEC sp_addextendedproperty N'PersianName', N'گروه کاربری', 'SCHEMA', N'dbo', 'TABLE', N'tblUserGroup', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ و زمان ', 'SCHEMA', N'dbo', 'TABLE', N'tblUserGroup', 'COLUMN', N'fldDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblUserGroup', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون آیدی', 'SCHEMA', N'dbo', 'TABLE', N'tblUserGroup', 'COLUMN', N'fldID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون ورود و خروج', 'SCHEMA', N'dbo', 'TABLE', N'tblUserGroup', 'COLUMN', N'fldInputID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ترتیب', 'SCHEMA', N'dbo', 'TABLE', N'tblUserGroup', 'COLUMN', N'fldOrder'
GO
EXEC sp_addextendedproperty N'MS_Description', N'فیلد مربوط به ویرایش', 'SCHEMA', N'dbo', 'TABLE', N'tblUserGroup', 'COLUMN', N'fldTimeStamp'
GO
EXEC sp_addextendedproperty N'MS_Description', N'عنوان گروه کاربری', 'SCHEMA', N'dbo', 'TABLE', N'tblUserGroup', 'COLUMN', N'fldTitle'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربر', 'SCHEMA', N'dbo', 'TABLE', N'tblUserGroup', 'COLUMN', N'fldUserID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نوع کاربری', 'SCHEMA', N'dbo', 'TABLE', N'tblUserGroup', 'COLUMN', N'fldUserType'
GO
