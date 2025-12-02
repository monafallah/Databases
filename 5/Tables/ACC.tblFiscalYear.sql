CREATE TABLE [ACC].[tblFiscalYear]
(
[fldId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFiscalYear_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFiscalYear_fldDate] DEFAULT (getdate()),
[fldIp] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblFiscalYear] ADD CONSTRAINT [PK_tblFiscalYear] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblFiscalYear] ADD CONSTRAINT [IX_tblFiscalYear] UNIQUE NONCLUSTERED ([fldOrganId], [fldYear]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblFiscalYear] ADD CONSTRAINT [FK_tblFiscalYear_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [ACC].[tblFiscalYear] ADD CONSTRAINT [FK_tblFiscalYear_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
