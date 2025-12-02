CREATE TABLE [Pay].[tblMonasebatType]
(
[fldId] [tinyint] NOT NULL,
[fldName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIP] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMonasebatType_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMonasebatType_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMonasebatType] ADD CONSTRAINT [PK_tblMonasebatType] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMonasebatType] ADD CONSTRAINT [FK_tblMonasebatType_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ و زمان', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatType', 'COLUMN', N'fldDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatType', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد یکتا', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatType', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آی پی ثبت کننده', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatType', 'COLUMN', N'fldIP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ماه', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatType', 'COLUMN', N'fldName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربر ثبت کننده', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatType', 'COLUMN', N'fldUserId'
GO
