CREATE TABLE [Cntr].[tblContract_Factor]
(
[fldId] [int] NOT NULL,
[fldContractId] [int] NOT NULL,
[fldFactorId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganID] [int] NOT NULL,
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblContract_Factor_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblContract_Factor_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblContract_Factor] ADD CONSTRAINT [PK_tblContract_Factor] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblContract_Factor] ADD CONSTRAINT [IX_tblContract_Factor] UNIQUE NONCLUSTERED ([fldFactorId], [fldContractId]) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblContract_Factor] ADD CONSTRAINT [FK_tblContract_Factor_tblContracts] FOREIGN KEY ([fldContractId]) REFERENCES [Cntr].[tblContracts] ([fldId])
GO
ALTER TABLE [Cntr].[tblContract_Factor] ADD CONSTRAINT [FK_tblContract_Factor_tblFactor] FOREIGN KEY ([fldFactorId]) REFERENCES [Cntr].[tblFactor] ([fldId])
GO
ALTER TABLE [Cntr].[tblContract_Factor] ADD CONSTRAINT [FK_tblContract_Factor_tblOrganization] FOREIGN KEY ([fldOrganID]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Cntr].[tblContract_Factor] ADD CONSTRAINT [FK_tblContract_Factor_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
