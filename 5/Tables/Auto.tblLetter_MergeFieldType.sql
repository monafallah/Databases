CREATE TABLE [Auto].[tblLetter_MergeFieldType]
(
[fldId] [int] NOT NULL,
[fldLetterId] [bigint] NOT NULL,
[fldMergeTypeId] [int] NOT NULL,
[fldValue] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblLetterMergeFieldType_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblLetterMergeFieldType_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetter_MergeFieldType] ADD CONSTRAINT [PK_tblLetterMergeFieldType] PRIMARY KEY NONCLUSTERED ([fldId]) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_tblLetterMergeFieldType] ON [Auto].[tblLetter_MergeFieldType] ([fldLetterId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetter_MergeFieldType] ADD CONSTRAINT [FK_tblLetterMergeFieldType_tblLetter] FOREIGN KEY ([fldLetterId]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblLetter_MergeFieldType] ADD CONSTRAINT [FK_tblLetterMergeFieldType_tblMergeFieldTypes] FOREIGN KEY ([fldMergeTypeId]) REFERENCES [Auto].[tblMergeFieldTypes] ([fldId])
GO
ALTER TABLE [Auto].[tblLetter_MergeFieldType] ADD CONSTRAINT [FK_tblLetterMergeFieldType_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
