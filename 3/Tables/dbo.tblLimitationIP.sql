CREATE TABLE [dbo].[tblLimitationIPHistory]
(
[fldId] [int] NOT NULL,
[fldUserLimId] [int] NOT NULL,
[fldIPValid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NULL,
[StartTime] [datetime2] NOT NULL,
[EndTime] [datetime2] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ix_tblLimitationIPHistory] ON [dbo].[tblLimitationIPHistory] ([EndTime], [StartTime]) ON [PRIMARY]
GO
CREATE TABLE [dbo].[tblLimitationIP]
(
[fldId] [int] NOT NULL,
[fldUserLimId] [int] NOT NULL,
[fldIPValid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblLimitationIP_fldDesc] DEFAULT (''),
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NULL,
[StartTime] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL CONSTRAINT [DF__tblLimita__Start__3B969E48] DEFAULT (getutcdate()),
[EndTime] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL CONSTRAINT [DF__tblLimita__EndTi__3C8AC281] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')),
PERIOD FOR SYSTEM_TIME (StartTime, EndTime),
CONSTRAINT [PK_tblLimitationIP] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[tblLimitationIPHistory])
)
GO
ALTER TABLE [dbo].[tblLimitationIP] ADD CONSTRAINT [IX_tblLimitationIP] UNIQUE NONCLUSTERED ([fldIPValid], [fldUserLimId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblLimitationIP] ADD CONSTRAINT [FK_tblLimitationIP_tblInputInfo] FOREIGN KEY ([fldInputId]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
ALTER TABLE [dbo].[tblLimitationIP] ADD CONSTRAINT [FK_tblLimitationIP_tblUser] FOREIGN KEY ([fldUserLimId]) REFERENCES [dbo].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'محدودیت آی پی', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationIP', NULL, NULL
GO
EXEC sp_addextendedproperty N'PersainName', N'محدودیت آی پی', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationIP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationIP', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون آی دی', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationIP', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ای پی ولید', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationIP', 'COLUMN', N'fldIPValid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربر محدود', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationIP', 'COLUMN', N'fldUserLimId'
GO
