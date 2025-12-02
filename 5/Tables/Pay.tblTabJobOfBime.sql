CREATE TABLE [Pay].[tblTabJobOfBime]
(
[fldJobCode] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldJobDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblTabJobOfBime] ADD CONSTRAINT [PK_tblTabJobOfBime] PRIMARY KEY CLUSTERED ([fldJobCode]) ON [PayRoll]
GO
