CREATE TABLE [dbo].[tblInputInfo]
(
[fldId] [int] NOT NULL,
[fldDateTime] [datetime] NOT NULL,
[fldIP] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMACAddress] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldLoginType] [tinyint] NOT NULL CONSTRAINT [DF_tblInputInfo_fldLoginType] DEFAULT ((1)),
[fldUserID] [int] NOT NULL CONSTRAINT [DF_tblInputInfo_fldUserID] DEFAULT ((1)),
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblInputInfo_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblInputInfo_fldDate] DEFAULT (getdate()),
[fldBrowserType] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldKey] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldAppType] [tinyint] NOT NULL,
[fldUserSecondId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblInputInfo] ADD CONSTRAINT [PK_tblInputInfo] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblInputInfo] ADD CONSTRAINT [FK_tblInputInfo_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [dbo].[tblUser] ([fldId])
GO
ALTER TABLE [dbo].[tblInputInfo] ADD CONSTRAINT [FK_tblInputInfo_tblUser1] FOREIGN KEY ([fldUserSecondId]) REFERENCES [dbo].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'ورود و خروج', 'SCHEMA', N'dbo', 'TABLE', N'tblInputInfo', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون نوع آپلیکشن ', 'SCHEMA', N'dbo', 'TABLE', N'tblInputInfo', 'COLUMN', N'fldAppType'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون نوع بروزر ', 'SCHEMA', N'dbo', 'TABLE', N'tblInputInfo', 'COLUMN', N'fldBrowserType'
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ و زمان', 'SCHEMA', N'dbo', 'TABLE', N'tblInputInfo', 'COLUMN', N'fldDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ و زمان', 'SCHEMA', N'dbo', 'TABLE', N'tblInputInfo', 'COLUMN', N'fldDateTime'
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblInputInfo', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد', 'SCHEMA', N'dbo', 'TABLE', N'tblInputInfo', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آی پی سیستم', 'SCHEMA', N'dbo', 'TABLE', N'tblInputInfo', 'COLUMN', N'fldIP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون کلید ', 'SCHEMA', N'dbo', 'TABLE', N'tblInputInfo', 'COLUMN', N'fldKey'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ورود/خروج', 'SCHEMA', N'dbo', 'TABLE', N'tblInputInfo', 'COLUMN', N'fldLoginType'
GO
EXEC sp_addextendedproperty N'MS_Description', N'مک ادرس', 'SCHEMA', N'dbo', 'TABLE', N'tblInputInfo', 'COLUMN', N'fldMACAddress'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربر', 'SCHEMA', N'dbo', 'TABLE', N'tblInputInfo', 'COLUMN', N'fldUserID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کاربر در نقش', 'SCHEMA', N'dbo', 'TABLE', N'tblInputInfo', 'COLUMN', N'fldUserSecondId'
GO
