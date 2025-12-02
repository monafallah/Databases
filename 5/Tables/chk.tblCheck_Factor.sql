CREATE TABLE [chk].[tblCheck_Factor]
(
[fldId] [int] NOT NULL,
[fldCheckSadereId] [int] NOT NULL,
[fldFactorId] [int] NULL,
[fldContractId] [int] NULL,
[fldTankhahGroupId] [int] NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCheck_Factor_fldDate] DEFAULT (getdate()),
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [chk].[tblCheck_Factor] ADD CONSTRAINT [PK_tblCheck_Factor] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [chk].[tblCheck_Factor] ADD CONSTRAINT [FK_tblCheck_Factor_tblContracts] FOREIGN KEY ([fldContractId]) REFERENCES [Cntr].[tblContracts] ([fldId])
GO
ALTER TABLE [chk].[tblCheck_Factor] ADD CONSTRAINT [FK_tblCheck_Factor_tblFactor] FOREIGN KEY ([fldFactorId]) REFERENCES [Cntr].[tblFactor] ([fldId])
GO
ALTER TABLE [chk].[tblCheck_Factor] ADD CONSTRAINT [FK_tblCheck_Factor_tblSodorCheck] FOREIGN KEY ([fldCheckSadereId]) REFERENCES [chk].[tblSodorCheck] ([fldId])
GO
ALTER TABLE [chk].[tblCheck_Factor] ADD CONSTRAINT [FK_tblCheck_Factor_tblTankhah_Group] FOREIGN KEY ([fldTankhahGroupId]) REFERENCES [Cntr].[tblTankhah_Group] ([fldId])
GO
ALTER TABLE [chk].[tblCheck_Factor] ADD CONSTRAINT [FK_tblCheck_Factor_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
