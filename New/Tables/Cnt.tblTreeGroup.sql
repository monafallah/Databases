CREATE TABLE [Cnt].[tblTreeGroupHistory]
(
[fldId] [int] NOT NULL,
[fldGroupId] [int] NOT NULL,
[fldPId] [int] NULL,
[fldInputId] [int] NOT NULL,
[StartTime] [datetime2] NOT NULL,
[EndTime] [datetime2] NOT NULL,
[fldTitle] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTreeGroupHistory_fldTitle] DEFAULT ('')
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ix_tblTreeGroupHistory] ON [Cnt].[tblTreeGroupHistory] ([EndTime], [StartTime]) ON [PRIMARY]
GO
CREATE TABLE [Cnt].[tblTreeGroup]
(
[fldId] [int] NOT NULL,
[fldGroupId] [int] NOT NULL,
[fldPId] [int] NULL,
[fldInputId] [int] NOT NULL,
[StartTime] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL CONSTRAINT [DF__tblTreeGr__Start__31ED387D] DEFAULT (getutcdate()),
[EndTime] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL CONSTRAINT [DF__tblTreeGr__EndTi__32E15CB6] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')),
[fldTitle] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTreeGroup_fldTitle] DEFAULT (''),
PERIOD FOR SYSTEM_TIME (StartTime, EndTime),
CONSTRAINT [PK_tblTreeGroup] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [Cnt].[tblTreeGroupHistory])
)
GO
ALTER TABLE [Cnt].[tblTreeGroup] ADD CONSTRAINT [FK_tblTreeGroup_tblInputInfo] FOREIGN KEY ([fldInputId]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
ALTER TABLE [Cnt].[tblTreeGroup] ADD CONSTRAINT [FK_tblTreeGroup_tblTreeGroup] FOREIGN KEY ([fldPId]) REFERENCES [Cnt].[tblTreeGroup] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'ساختار درختی گروه', 'SCHEMA', N'Cnt', 'TABLE', N'tblTreeGroup', NULL, NULL
GO
EXEC sp_addextendedproperty N'PersianName', N'ساختار درختی گروه', 'SCHEMA', N'Cnt', 'TABLE', N'tblTreeGroup', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی گروه', 'SCHEMA', N'Cnt', 'TABLE', N'tblTreeGroup', 'COLUMN', N'fldGroupId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی', 'SCHEMA', N'Cnt', 'TABLE', N'tblTreeGroup', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی ریشه', 'SCHEMA', N'Cnt', 'TABLE', N'tblTreeGroup', 'COLUMN', N'fldPId'
GO
