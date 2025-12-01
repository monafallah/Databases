CREATE TABLE [dbo].[tblLimitationTimeHistory]
(
[fldId] [int] NOT NULL,
[fldUserLimId] [int] NOT NULL,
[fldRoozHafte] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAzSaat] [int] NOT NULL,
[fldTaSaat] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NULL,
[StartTime] [datetime2] NOT NULL,
[EndTime] [datetime2] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ix_tblLimitationTimeHistory] ON [dbo].[tblLimitationTimeHistory] ([EndTime], [StartTime]) ON [PRIMARY]
GO
CREATE TABLE [dbo].[tblLimitationTime]
(
[fldId] [int] NOT NULL,
[fldUserLimId] [int] NOT NULL,
[fldRoozHafte] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAzSaat] [int] NOT NULL,
[fldTaSaat] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblLimitationTime_fldDesc] DEFAULT (''),
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NULL,
[StartTime] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL CONSTRAINT [DF__tblLimita__Start__38BA319D] DEFAULT (getutcdate()),
[EndTime] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL CONSTRAINT [DF__tblLimita__EndTi__39AE55D6] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')),
PERIOD FOR SYSTEM_TIME (StartTime, EndTime),
CONSTRAINT [PK_tblLimitationTime] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[tblLimitationTimeHistory])
)
GO
ALTER TABLE [dbo].[tblLimitationTime] ADD CONSTRAINT [FK_tblLimitationTime_tblInputInfo] FOREIGN KEY ([fldInputId]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
ALTER TABLE [dbo].[tblLimitationTime] ADD CONSTRAINT [FK_tblLimitationTime_tblUser] FOREIGN KEY ([fldUserLimId]) REFERENCES [dbo].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'محدودیت زمانی', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationTime', NULL, NULL
GO
EXEC sp_addextendedproperty N'PersianName', N'محدودیت زمانی', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationTime', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'از ساعت', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationTime', 'COLUMN', N'fldAzSaat'
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationTime', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون ای دی', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationTime', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'روز هفته', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationTime', 'COLUMN', N'fldRoozHafte'
GO
EXEC sp_addextendedproperty N'MS_Description', N'تا ساعت', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationTime', 'COLUMN', N'fldTaSaat'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربری محدود', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationTime', 'COLUMN', N'fldUserLimId'
GO
