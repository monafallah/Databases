CREATE TABLE [dbo].[tblStateHistory]
(
[fldId] [tinyint] NOT NULL,
[fldNameState] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldCountryId] [smallint] NOT NULL,
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NOT NULL,
[StartTime] [datetime2] NOT NULL,
[EndTime] [datetime2] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ix_tblStateHistory] ON [dbo].[tblStateHistory] ([EndTime], [StartTime]) ON [PRIMARY]
GO
CREATE TABLE [dbo].[tblState]
(
[fldId] [tinyint] NOT NULL,
[fldNameState] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldCountryId] [smallint] NOT NULL,
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NOT NULL,
[StartTime] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL CONSTRAINT [DF__tblState__StartT__4944D3CA] DEFAULT (getutcdate()),
[EndTime] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL CONSTRAINT [DF__tblState__EndTim__4A38F803] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')),
PERIOD FOR SYSTEM_TIME (StartTime, EndTime),
CONSTRAINT [PK_tblState] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[tblStateHistory])
)
GO
ALTER TABLE [dbo].[tblState] ADD CONSTRAINT [FK_tblState_tblCountry] FOREIGN KEY ([fldCountryId]) REFERENCES [dbo].[tblCountry] ([fldId])
GO
ALTER TABLE [dbo].[tblState] ADD CONSTRAINT [FK_tblState_tblInputInfo] FOREIGN KEY ([fldInputId]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
EXEC sp_addextendedproperty N'PersianName', N'استان', 'SCHEMA', N'dbo', 'TABLE', N'tblState', NULL, NULL
GO
