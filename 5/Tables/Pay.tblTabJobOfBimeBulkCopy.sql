CREATE TABLE [Pay].[tblTabJobOfBimeBulkCopy]
(
[fldJobCode] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldJobDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblTabJobOfBimeBulkCopy] ADD CONSTRAINT [PK_tblTabJobOfBimeBulkCopy] PRIMARY KEY CLUSTERED ([fldJobCode]) ON [PayRoll]
GO
