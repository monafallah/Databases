CREATE TABLE [dbo].[tblShahrHistory]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (150) COLLATE Persian_100_CI_AI NOT NULL,
[fldCountyId] [int] NOT NULL,
[fldLatitude] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldLongitude] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTimeStamp] [timestamp] NOT NULL,
[StartTime] [datetime2] NOT NULL,
[EndTime] [datetime2] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ix_tblShahrHistory] ON [dbo].[tblShahrHistory] ([EndTime], [StartTime]) ON [PRIMARY]
GO
CREATE TABLE [dbo].[tblShahr]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (150) COLLATE Persian_100_CI_AI NOT NULL,
[fldCountyId] [int] NOT NULL,
[fldLatitude] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldLongitude] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTimeStamp] [timestamp] NOT NULL,
[StartTime] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL CONSTRAINT [DF__tblShahr__StartT__63849411] DEFAULT (getutcdate()),
[EndTime] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL CONSTRAINT [DF__tblShahr__EndTim__6478B84A] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')),
PERIOD FOR SYSTEM_TIME (StartTime, EndTime),
CONSTRAINT [PK_tblShahr] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[tblShahrHistory])
)
GO
ALTER TABLE [dbo].[tblShahr] ADD CONSTRAINT [FK_tblShahr_tblCounty] FOREIGN KEY ([fldCountyId]) REFERENCES [dbo].[tblCounty] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'شهر', 'SCHEMA', N'dbo', 'TABLE', N'tblShahr', NULL, NULL
GO
EXEC sp_addextendedproperty N'PersianName', N'شهر', 'SCHEMA', N'dbo', 'TABLE', N'tblShahr', NULL, NULL
GO
