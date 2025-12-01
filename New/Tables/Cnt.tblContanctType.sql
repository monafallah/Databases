CREATE TABLE [Cnt].[tblContanctTypeHistory]
(
[fldId] [tinyint] NOT NULL,
[fldType] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIconId] [int] NOT NULL,
[fldFormul] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldFormulId] [int] NULL,
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NULL,
[StartTime] [datetime2] NOT NULL,
[EndTime] [datetime2] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ix_tblContanctTypeHistory] ON [Cnt].[tblContanctTypeHistory] ([EndTime], [StartTime]) ON [PRIMARY]
GO
CREATE TABLE [Cnt].[tblContanctType]
(
[fldId] [tinyint] NOT NULL,
[fldType] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIconId] [int] NOT NULL,
[fldFormul] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldFormulId] [int] NULL,
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NULL,
[StartTime] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL CONSTRAINT [DF__tblContan__Start__014A0122] DEFAULT (getutcdate()),
[EndTime] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL CONSTRAINT [DF__tblContan__EndTi__023E255B] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')),
PERIOD FOR SYSTEM_TIME (StartTime, EndTime),
CONSTRAINT [PK_tblContanctType] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [Cnt].[tblContanctTypeHistory])
)
GO
ALTER TABLE [Cnt].[tblContanctType] ADD CONSTRAINT [FK_tblContanctType_tblComputationFormula] FOREIGN KEY ([fldFormulId]) REFERENCES [dbo].[tblComputationFormula] ([fldId])
GO
ALTER TABLE [Cnt].[tblContanctType] ADD CONSTRAINT [FK_tblContanctType_tblFile] FOREIGN KEY ([fldIconId]) REFERENCES [dbo].[tblFile] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'نوع تماس با ما', 'SCHEMA', N'Cnt', 'TABLE', N'tblContanctType', NULL, NULL
GO
EXEC sp_addextendedproperty N'PersianName', N'نوع تماس با ما', 'SCHEMA', N'Cnt', 'TABLE', N'tblContanctType', NULL, NULL
GO
