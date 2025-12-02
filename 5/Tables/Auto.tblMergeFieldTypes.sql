CREATE TABLE [Auto].[tblMergeFieldTypes]
(
[fldId] [int] NOT NULL,
[fldFaName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldEnName] [varchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMarjFieldTypes_fldDate] DEFAULT (getdate()),
[fldType] [bit] NOT NULL CONSTRAINT [DF_tblMergeFieldTypes_fldType] DEFAULT ((0)),
[fldUserId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblMergeFieldTypes] ADD CONSTRAINT [PK_tblMarjFieldTypes] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblMergeFieldTypes] ADD CONSTRAINT [FK_tblMergeFieldTypes_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
