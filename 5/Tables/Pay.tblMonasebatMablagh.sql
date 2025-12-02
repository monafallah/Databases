CREATE TABLE [Pay].[tblMonasebatMablagh]
(
[fldId] [int] NOT NULL,
[fldHeaderId] [int] NOT NULL,
[fldMonasebatId] [tinyint] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldTypeNesbatId] [tinyint] NOT NULL,
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMonasebatMablagh_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMonasebatMablagh] ADD CONSTRAINT [PK_tblMonasebatMablagh] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMonasebatMablagh] ADD CONSTRAINT [IX_tblMonasebatMablagh] UNIQUE NONCLUSTERED ([fldHeaderId], [fldMonasebatId], [fldTypeNesbatId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMonasebatMablagh] ADD CONSTRAINT [FK_tblMonasebatMablagh_tblMonasebat] FOREIGN KEY ([fldMonasebatId]) REFERENCES [Pay].[tblMonasebat] ([fldId])
GO
ALTER TABLE [Pay].[tblMonasebatMablagh] ADD CONSTRAINT [FK_tblMonasebatMablagh_tblTypeNesbat] FOREIGN KEY ([fldTypeNesbatId]) REFERENCES [Pay].[tblTypeNesbat] ([fldId])
GO
ALTER TABLE [Pay].[tblMonasebatMablagh] ADD CONSTRAINT [FK_tblMonasebatMablagh_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ و زمان', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatMablagh', 'COLUMN', N'fldDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد یکتا', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatMablagh', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آی پی ثبت کننده', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatMablagh', 'COLUMN', N'fldIP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربر ثبت کننده', 'SCHEMA', N'Pay', 'TABLE', N'tblMonasebatMablagh', 'COLUMN', N'fldUserId'
GO
