CREATE TABLE [BUD].[tblCodingLevel]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFiscalBudjeId] [int] NOT NULL,
[fldArghamNum] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCodingLevel_fldDesc] DEFAULT (''),
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCodingLevel_fldDate] DEFAULT (getdate()),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblCodingLevel] ADD CONSTRAINT [PK_tblCodingLevel] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblCodingLevel] ADD CONSTRAINT [FK_tblCodingLevel_tblFiscalYear] FOREIGN KEY ([fldFiscalBudjeId]) REFERENCES [ACC].[tblFiscalYear] ([fldId])
GO
ALTER TABLE [BUD].[tblCodingLevel] ADD CONSTRAINT [FK_tblCodingLevel_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [BUD].[tblCodingLevel] ADD CONSTRAINT [FK_tblCodingLevel_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
