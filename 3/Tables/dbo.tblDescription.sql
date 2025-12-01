CREATE TABLE [dbo].[tblDescriptionHistory]
(
[fldId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StartTime] [datetime2] NOT NULL,
[EndTime] [datetime2] NOT NULL
) ON [PRIMARY]
WITH
(
DATA_COMPRESSION = PAGE
)
GO
CREATE CLUSTERED INDEX [ix_tblDescriptionHistory] ON [dbo].[tblDescriptionHistory] ([EndTime], [StartTime]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE TABLE [dbo].[tblDescription]
(
[fldId] [int] NOT NULL IDENTITY(1, 1),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StartTime] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL CONSTRAINT [DF__tblDescri__Start__2F9ADBB7] DEFAULT (getutcdate()),
[EndTime] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL CONSTRAINT [DF__tblDescri__EndTi__308EFFF0] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')),
PERIOD FOR SYSTEM_TIME (StartTime, EndTime),
CONSTRAINT [PK_tblDescription] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[tblDescriptionHistory])
)
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblDescription', NULL, NULL
GO
