CREATE TABLE [Cnt].[tblContact_TreeGroupHistory]
(
[fldId] [int] NOT NULL,
[fldTreeGroupId] [int] NOT NULL,
[fldContactId] [int] NOT NULL,
[fldInputId] [int] NOT NULL,
[StartTime] [datetime2] NOT NULL,
[EndTime] [datetime2] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ix_tblContact_TreeGroupHistory] ON [Cnt].[tblContact_TreeGroupHistory] ([EndTime], [StartTime]) ON [PRIMARY]
GO
CREATE TABLE [Cnt].[tblContact_TreeGroup]
(
[fldId] [int] NOT NULL,
[fldTreeGroupId] [int] NOT NULL,
[fldContactId] [int] NOT NULL,
[fldInputId] [int] NOT NULL,
[StartTime] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL CONSTRAINT [DF__tblContac__Start__1333A733] DEFAULT (getutcdate()),
[EndTime] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL CONSTRAINT [DF__tblContac__EndTi__1427CB6C] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')),
PERIOD FOR SYSTEM_TIME (StartTime, EndTime),
CONSTRAINT [PK_tblContact_TreeGroup] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [Cnt].[tblContact_TreeGroupHistory])
)
GO
ALTER TABLE [Cnt].[tblContact_TreeGroup] ADD CONSTRAINT [FK_tblContact_TreeGroup_tblContact] FOREIGN KEY ([fldContactId]) REFERENCES [Cnt].[tblContact] ([fldId]) ON DELETE CASCADE
GO
ALTER TABLE [Cnt].[tblContact_TreeGroup] ADD CONSTRAINT [FK_tblContact_TreeGroup_tblInputInfo] FOREIGN KEY ([fldInputId]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
ALTER TABLE [Cnt].[tblContact_TreeGroup] ADD CONSTRAINT [FK_tblContact_TreeGroup_tblTreeGroup] FOREIGN KEY ([fldTreeGroupId]) REFERENCES [Cnt].[tblTreeGroup] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'ساختار درختی تماس با ما', 'SCHEMA', N'Cnt', 'TABLE', N'tblContact_TreeGroup', NULL, NULL
GO
EXEC sp_addextendedproperty N'PersianName', N'ساختار درختی تماس با ما', 'SCHEMA', N'Cnt', 'TABLE', N'tblContact_TreeGroup', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی تماس با ما', 'SCHEMA', N'Cnt', 'TABLE', N'tblContact_TreeGroup', 'COLUMN', N'fldContactId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی', 'SCHEMA', N'Cnt', 'TABLE', N'tblContact_TreeGroup', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی ساختار درختی گروه', 'SCHEMA', N'Cnt', 'TABLE', N'tblContact_TreeGroup', 'COLUMN', N'fldTreeGroupId'
GO
