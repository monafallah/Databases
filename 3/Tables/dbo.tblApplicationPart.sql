CREATE TABLE [dbo].[tblApplicationPart]
(
[fldID] [int] NOT NULL,
[fldTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblApplicationPart_fldTitle] DEFAULT (''),
[fldPID] [int] NULL,
[fldClassName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldMethodName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldFileId] [int] NULL,
[fldUserType] [tinyint] NULL,
[fldTimeLimit] [bit] NULL CONSTRAINT [DF_tblApplicationPart_fldTimeLimit] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblApplicationPart] ADD CONSTRAINT [PK_tblApplicationPart] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblApplicationPart] ADD CONSTRAINT [FK_tblApplicationPart_tblApplicationPart1] FOREIGN KEY ([fldPID]) REFERENCES [dbo].[tblApplicationPart] ([fldID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیتم های برنامه', 'SCHEMA', N'dbo', 'TABLE', N'tblApplicationPart', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'نام کلاس', 'SCHEMA', N'dbo', 'TABLE', N'tblApplicationPart', 'COLUMN', N'fldClassName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد آیکون', 'SCHEMA', N'dbo', 'TABLE', N'tblApplicationPart', 'COLUMN', N'fldFileId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد', 'SCHEMA', N'dbo', 'TABLE', N'tblApplicationPart', 'COLUMN', N'fldID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نام متد', 'SCHEMA', N'dbo', 'TABLE', N'tblApplicationPart', 'COLUMN', N'fldMethodName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نود ریشه', 'SCHEMA', N'dbo', 'TABLE', N'tblApplicationPart', 'COLUMN', N'fldPID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'محدویت زمانی', 'SCHEMA', N'dbo', 'TABLE', N'tblApplicationPart', 'COLUMN', N'fldTimeLimit'
GO
EXEC sp_addextendedproperty N'MS_Description', N'عنوان', 'SCHEMA', N'dbo', 'TABLE', N'tblApplicationPart', 'COLUMN', N'fldTitle'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نوع کاربر', 'SCHEMA', N'dbo', 'TABLE', N'tblApplicationPart', 'COLUMN', N'fldUserType'
GO
