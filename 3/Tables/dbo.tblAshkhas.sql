CREATE TABLE [dbo].[tblAshkhasHistory]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFamily] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFatherName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldCodeMeli] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldEmail] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldMobile] [varchar] (19) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldFileId] [int] NULL,
[fldSh_Shenasname] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldCodeMahalTavalod] [int] NULL,
[fldCodeMahalSodoor] [int] NULL,
[fldJensiyat] [bit] NULL,
[fldTarikhTavalod] [int] NULL,
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NOT NULL,
[StartTime] [datetime2] NOT NULL,
[EndTime] [datetime2] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ix_tblAshkhasHistory] ON [dbo].[tblAshkhasHistory] ([EndTime], [StartTime]) ON [PRIMARY]
GO
CREATE TABLE [dbo].[tblAshkhas]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFamily] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFatherName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldCodeMeli] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldEmail] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldMobile] [varchar] (19) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_tblAshkhas_fldDesc] DEFAULT (''),
[fldFileId] [int] NULL,
[fldSh_Shenasname] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldCodeMahalTavalod] [int] NULL,
[fldCodeMahalSodoor] [int] NULL,
[fldJensiyat] [bit] NULL,
[fldTarikhTavalod] [int] NULL,
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NOT NULL,
[StartTime] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL CONSTRAINT [DF__tblAshkha__Start__394E6323] DEFAULT (getutcdate()),
[EndTime] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL CONSTRAINT [DF__tblAshkha__EndTi__3A42875C] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')),
PERIOD FOR SYSTEM_TIME (StartTime, EndTime),
CONSTRAINT [PK_tblAshkhas] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[tblAshkhasHistory])
)
GO
ALTER TABLE [dbo].[tblAshkhas] ADD CONSTRAINT [CK_Email] CHECK (([dbo].[IsValidEmailRFC]([fldEmail])=(1)))
GO
ALTER TABLE [dbo].[tblAshkhas] ADD CONSTRAINT [CK_Mobile] CHECK (([dbo].[IsValidIranianMobile]([fldMobile])=(1)))
GO
ALTER TABLE [dbo].[tblAshkhas] ADD CONSTRAINT [CK_NationalCode] CHECK (([dbo].[ValidateNationalCode]([fldCodemeli])=(1)))
GO
ALTER TABLE [dbo].[tblAshkhas] ADD CONSTRAINT [IX_tblAshkhas] UNIQUE NONCLUSTERED ([fldCodeMeli]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblAshkhas] ADD CONSTRAINT [FK_tblAshkhas_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [dbo].[tblFile] ([fldId])
GO
ALTER TABLE [dbo].[tblAshkhas] ADD CONSTRAINT [FK_tblAshkhas_tblInputInfo] FOREIGN KEY ([fldInputId]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'اشخاص', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', NULL, NULL
GO
EXEC sp_addextendedproperty N'PersianName', N'اشخاص', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد محل صدور', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', 'COLUMN', N'fldCodeMahalSodoor'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد محل تولد', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', 'COLUMN', N'fldCodeMahalTavalod'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد ملی', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', 'COLUMN', N'fldCodeMeli'
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ایمیل', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', 'COLUMN', N'fldEmail'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نام خانوادگی', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', 'COLUMN', N'fldFamily'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نام پدر', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', 'COLUMN', N'fldFatherName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد فایل', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', 'COLUMN', N'fldFileId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'جنسیت', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', 'COLUMN', N'fldJensiyat'
GO
EXEC sp_addextendedproperty N'MS_Description', N'موبایل', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', 'COLUMN', N'fldMobile'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نام', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', 'COLUMN', N'fldName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'شماره شناسنامه', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', 'COLUMN', N'fldSh_Shenasname'
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ تولد', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', 'COLUMN', N'fldTarikhTavalod'
GO
EXEC sp_addextendedproperty N'MS_Description', N'فیلد مربوط به ویرایش', 'SCHEMA', N'dbo', 'TABLE', N'tblAshkhas', 'COLUMN', N'fldTimeStamp'
GO
