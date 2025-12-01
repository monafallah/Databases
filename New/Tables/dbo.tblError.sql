CREATE TABLE [dbo].[tblError]
(
[fldId] [int] NOT NULL,
[fldMatn] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikh] [date] NOT NULL,
[fldUserId] [int] NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblError_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblError_fldDate] DEFAULT (getdate()),
[fldInputID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblError] ADD CONSTRAINT [PK_tblError] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblError] ON [dbo].[tblError] ([fldUserId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblError] ADD CONSTRAINT [FK_tblError_tblInputInfo] FOREIGN KEY ([fldInputID]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
ALTER TABLE [dbo].[tblError] ADD CONSTRAINT [FK_tblError_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [dbo].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'خطا ها', 'SCHEMA', N'dbo', 'TABLE', N'tblError', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ و زمان', 'SCHEMA', N'dbo', 'TABLE', N'tblError', 'COLUMN', N'fldDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblError', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد', 'SCHEMA', N'dbo', 'TABLE', N'tblError', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون ورود و خروج', 'SCHEMA', N'dbo', 'TABLE', N'tblError', 'COLUMN', N'fldInputID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'متن', 'SCHEMA', N'dbo', 'TABLE', N'tblError', 'COLUMN', N'fldMatn'
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ', 'SCHEMA', N'dbo', 'TABLE', N'tblError', 'COLUMN', N'fldTarikh'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربر', 'SCHEMA', N'dbo', 'TABLE', N'tblError', 'COLUMN', N'fldUserId'
GO
