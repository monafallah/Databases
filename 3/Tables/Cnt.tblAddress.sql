CREATE TABLE [Cnt].[tblAddressHistory]
(
[fldId] [int] NOT NULL,
[fldShahrId] [int] NOT NULL,
[fldContactId] [int] NOT NULL,
[fldLatitude] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldLongitude] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldInputId] [int] NOT NULL,
[StartTime] [datetime2] NOT NULL,
[EndTime] [datetime2] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ix_tblAddressHistory] ON [Cnt].[tblAddressHistory] ([EndTime], [StartTime]) ON [PRIMARY]
GO
CREATE TABLE [Cnt].[tblAddress]
(
[fldId] [int] NOT NULL,
[fldShahrId] [int] NOT NULL,
[fldContactId] [int] NOT NULL,
[fldLatitude] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldLongitude] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldInputId] [int] NOT NULL,
[StartTime] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL CONSTRAINT [DF__tblAddres__Start__60A82766] DEFAULT (getutcdate()),
[EndTime] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL CONSTRAINT [DF__tblAddres__EndTi__619C4B9F] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')),
PERIOD FOR SYSTEM_TIME (StartTime, EndTime),
CONSTRAINT [PK_tblAddress] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [Cnt].[tblAddressHistory])
)
GO
ALTER TABLE [Cnt].[tblAddress] ADD CONSTRAINT [FK_tblAddress_tblContact] FOREIGN KEY ([fldContactId]) REFERENCES [Cnt].[tblContact] ([fldId]) ON DELETE CASCADE
GO
ALTER TABLE [Cnt].[tblAddress] ADD CONSTRAINT [FK_tblAddress_tblInputInfo] FOREIGN KEY ([fldInputId]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'آدرس ها', 'SCHEMA', N'Cnt', 'TABLE', N'tblAddress', NULL, NULL
GO
EXEC sp_addextendedproperty N'PersianName', N'آدرس', 'SCHEMA', N'Cnt', 'TABLE', N'tblAddress', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی تماس با ما', 'SCHEMA', N'Cnt', 'TABLE', N'tblAddress', 'COLUMN', N'fldContactId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی', 'SCHEMA', N'Cnt', 'TABLE', N'tblAddress', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی شهر', 'SCHEMA', N'Cnt', 'TABLE', N'tblAddress', 'COLUMN', N'fldShahrId'
GO
