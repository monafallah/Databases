CREATE TABLE [Cnt].[tblContactHistory]
(
[fldId] [int] NOT NULL,
[fldTypeContactId] [tinyint] NOT NULL,
[fldValue] [nvarchar] (800) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldType] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NULL,
[StartTime] [datetime2] NOT NULL,
[EndTime] [datetime2] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ix_tblContactHistory] ON [Cnt].[tblContactHistory] ([EndTime], [StartTime]) ON [PRIMARY]
GO
CREATE TABLE [Cnt].[tblContact]
(
[fldId] [int] NOT NULL,
[fldTypeContactId] [tinyint] NOT NULL,
[fldValue] [nvarchar] (800) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldType] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NULL,
[StartTime] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL CONSTRAINT [DF__tblContac__Start__051A9206] DEFAULT (getutcdate()),
[EndTime] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL CONSTRAINT [DF__tblContac__EndTi__060EB63F] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')),
PERIOD FOR SYSTEM_TIME (StartTime, EndTime),
CONSTRAINT [PK_tblContact] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [Cnt].[tblContactHistory])
)
GO
ALTER TABLE [Cnt].[tblContact] ADD CONSTRAINT [FK_tblContact_tblContanctType] FOREIGN KEY ([fldTypeContactId]) REFERENCES [Cnt].[tblContanctType] ([fldId])
GO
ALTER TABLE [Cnt].[tblContact] ADD CONSTRAINT [FK_tblContact_tblInputInfo] FOREIGN KEY ([fldInputId]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
ALTER TABLE [Cnt].[tblContact] ADD CONSTRAINT [FK_tblContact_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [dbo].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'تماس با ما', 'SCHEMA', N'Cnt', 'TABLE', N'tblContact', NULL, NULL
GO
EXEC sp_addextendedproperty N'PersianName', N'تماس با ما', 'SCHEMA', N'Cnt', 'TABLE', N'tblContact', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی ', 'SCHEMA', N'Cnt', 'TABLE', N'tblContact', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'قیلد مربوط به ویرایش', 'SCHEMA', N'Cnt', 'TABLE', N'tblContact', 'COLUMN', N'fldTimeStamp'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نوع مقدار', 'SCHEMA', N'Cnt', 'TABLE', N'tblContact', 'COLUMN', N'fldType'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی نوع تماس', 'SCHEMA', N'Cnt', 'TABLE', N'tblContact', 'COLUMN', N'fldTypeContactId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربر', 'SCHEMA', N'Cnt', 'TABLE', N'tblContact', 'COLUMN', N'fldUserId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'مقدار', 'SCHEMA', N'Cnt', 'TABLE', N'tblContact', 'COLUMN', N'fldValue'
GO
