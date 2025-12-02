CREATE TABLE [Pay].[tblReportType]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblReportType] ADD CONSTRAINT [PK_tblReportType] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
