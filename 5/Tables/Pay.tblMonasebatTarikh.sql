CREATE TABLE [Pay].[tblMonasebatTarikh]
(
[fldId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldMonth] [tinyint] NOT NULL,
[fldDay] [tinyint] NOT NULL,
[fldMonasebatId] [tinyint] NOT NULL,
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMonasebatTarikh_fldDate_1] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMonasebatTarikh] ADD CONSTRAINT [PK_tblMonasebatTarikh_1] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMonasebatTarikh] ADD CONSTRAINT [FK_tblMonasebatTarikh_tblMonasebatTarikh1] FOREIGN KEY ([fldMonasebatId]) REFERENCES [Pay].[tblMonasebat] ([fldId])
GO
ALTER TABLE [Pay].[tblMonasebatTarikh] ADD CONSTRAINT [FK_tblMonasebatTarikh_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ و زمان', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatTarikh', 'COLUMN', N'fldDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد یکتا', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatTarikh', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آی پی ثبت کننده', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatTarikh', 'COLUMN', N'fldIP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربر ثبت کننده', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatTarikh', 'COLUMN', N'fldUserId'
GO
