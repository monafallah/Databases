CREATE TABLE [Pay].[tblFiscal_Header]
(
[fldId] [int] NOT NULL,
[fldEffectiveDate] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDateOfIssue] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFiscal_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFiscal_fldDesc] DEFAULT ('')
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblFiscal_Header] ADD CONSTRAINT [PK_tblFiscal] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblFiscal_Header] ADD CONSTRAINT [IX_tblFiscal] UNIQUE NONCLUSTERED ([fldEffectiveDate], [fldDateOfIssue]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblFiscal_Header] ADD CONSTRAINT [FK_tblFiscal_Header_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
