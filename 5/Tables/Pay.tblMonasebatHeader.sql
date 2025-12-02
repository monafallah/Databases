CREATE TABLE [Pay].[tblMonasebatHeader]
(
[fldId] [int] NOT NULL,
[fldActiveDate] [int] NOT NULL,
[fldDeactiveDate] [int] NULL,
[fldActive] [bit] NOT NULL,
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMonasebatHeader_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMonasebatHeader] ADD CONSTRAINT [PK_tblMonasebatHeader] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMonasebatHeader] ADD CONSTRAINT [IX_tblMonasebatHeader] UNIQUE NONCLUSTERED ([fldActiveDate]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMonasebatHeader] ADD CONSTRAINT [FK_tblMonasebatHeader_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ و زمان', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatHeader', 'COLUMN', N'fldDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد یکتا', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatHeader', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آی پی ثبت کننده', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatHeader', 'COLUMN', N'fldIP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربر ثبت کننده', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatHeader', 'COLUMN', N'fldUserId'
GO
