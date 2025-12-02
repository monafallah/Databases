CREATE TABLE [Pay].[tblMonasebat]
(
[fldId] [tinyint] NOT NULL,
[fldNameMonasebat] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMonasebatTypeId] [tinyint] NOT NULL,
[fldMonth] [tinyint] NOT NULL,
[fldDay] [tinyint] NOT NULL,
[fldDateType] [bit] NOT NULL,
[fldHoliday] [bit] NOT NULL,
[fldMazaya] [bit] NOT NULL,
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMonasebat_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMonasebat] ADD CONSTRAINT [PK_tblMonasebat] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMonasebat] ADD CONSTRAINT [FK_tblMonasebat_tblMonasebatType] FOREIGN KEY ([fldMonasebatTypeId]) REFERENCES [Pay].[tblMonasebatType] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ و زمان', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebat', 'COLUMN', N'fldDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نوع تاریخ', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebat', 'COLUMN', N'fldDateType'
GO
EXEC sp_addextendedproperty N'MS_Description', N'روز', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebat', 'COLUMN', N'fldDay'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد یکتا', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebat', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آی پی ثبت کننده', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebat', 'COLUMN', N'fldIP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ماه', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebat', 'COLUMN', N'fldMonth'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ماه', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebat', 'COLUMN', N'fldNameMonasebat'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربر ثبت کننده', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebat', 'COLUMN', N'fldUserId'
GO
