CREATE TABLE [dbo].[tblCityHistory]
(
[fldId] [int] NOT NULL,
[fldNameCity] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldStateId] [tinyint] NOT NULL,
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NOT NULL,
[StartTime] [datetime2] NOT NULL,
[EndTime] [datetime2] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ix_tblCityHistory] ON [dbo].[tblCityHistory] ([EndTime], [StartTime]) ON [PRIMARY]
GO
CREATE TABLE [dbo].[tblCity]
(
[fldId] [int] NOT NULL,
[fldNameCity] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldStateId] [tinyint] NOT NULL,
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NOT NULL,
[StartTime] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL CONSTRAINT [DF__tblCity__StartTi__4668671F] DEFAULT (getutcdate()),
[EndTime] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL CONSTRAINT [DF__tblCity__EndTime__475C8B58] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')),
PERIOD FOR SYSTEM_TIME (StartTime, EndTime),
CONSTRAINT [PK_tblCity] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[tblCityHistory])
)
GO
ALTER TABLE [dbo].[tblCity] ADD CONSTRAINT [FK_tblCity_tblInputInfo] FOREIGN KEY ([fldInputId]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
ALTER TABLE [dbo].[tblCity] ADD CONSTRAINT [FK_tblCity_tblState] FOREIGN KEY ([fldStateId]) REFERENCES [dbo].[tblState] ([fldId])
GO
EXEC sp_addextendedproperty N'PersianName', N'شهر', 'SCHEMA', N'dbo', 'TABLE', N'tblCity', NULL, NULL
GO
