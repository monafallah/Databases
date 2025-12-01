CREATE TABLE [Cnt].[tblContactGroupHistory]
(
[fldId] [int] NOT NULL,
[fldNameGroup] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NULL,
[StartTime] [datetime2] NOT NULL,
[EndTime] [datetime2] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ix_tblContactGroupHistory] ON [Cnt].[tblContactGroupHistory] ([EndTime], [StartTime]) ON [PRIMARY]
GO
CREATE TABLE [Cnt].[tblContactGroup]
(
[fldId] [int] NOT NULL,
[fldNameGroup] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NULL,
[StartTime] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL CONSTRAINT [DF__tblContac__Start__2E1CA799] DEFAULT (getutcdate()),
[EndTime] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL CONSTRAINT [DF__tblContac__EndTi__2F10CBD2] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')),
PERIOD FOR SYSTEM_TIME (StartTime, EndTime),
CONSTRAINT [PK_tblContactGroup] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [Cnt].[tblContactGroupHistory])
)
GO
ALTER TABLE [Cnt].[tblContactGroup] ADD CONSTRAINT [FK_tblContactGroup_tblInputInfo] FOREIGN KEY ([fldInputId]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
ALTER TABLE [Cnt].[tblContactGroup] ADD CONSTRAINT [FK_tblContactGroup_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [dbo].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'گروه تماس با ما', 'SCHEMA', N'Cnt', 'TABLE', N'tblContactGroup', NULL, NULL
GO
EXEC sp_addextendedproperty N'PersianName', N'گروه های تماس با ما', 'SCHEMA', N'Cnt', 'TABLE', N'tblContactGroup', NULL, NULL
GO
