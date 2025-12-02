CREATE TABLE [Auto].[tblMergeField_LetterTemplate]
(
[fldId] [int] NOT NULL,
[fldLetterTamplateId] [int] NOT NULL,
[fldMergeFieldId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMergeField_LetterTemplate_fldDesc] DEFAULT (''),
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMergeField_LetterTemplate_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblMergeField_LetterTemplate] ADD CONSTRAINT [PK_tblMergeField_LetterTemplate] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblMergeField_LetterTemplate] ADD CONSTRAINT [FK_tblMergeField_LetterTemplate_tblletterTemplate] FOREIGN KEY ([fldLetterTamplateId]) REFERENCES [Auto].[tblletterTemplate] ([fldId])
GO
ALTER TABLE [Auto].[tblMergeField_LetterTemplate] ADD CONSTRAINT [FK_tblMergeField_LetterTemplate_tblMergeFieldTypes] FOREIGN KEY ([fldMergeFieldId]) REFERENCES [Auto].[tblMergeFieldTypes] ([fldId])
GO
ALTER TABLE [Auto].[tblMergeField_LetterTemplate] ADD CONSTRAINT [FK_tblMergeField_LetterTemplate_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblMergeField_LetterTemplate] ADD CONSTRAINT [FK_tblMergeField_LetterTemplate_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
