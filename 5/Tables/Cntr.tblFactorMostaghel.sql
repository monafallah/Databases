CREATE TABLE [Cntr].[tblFactorMostaghel]
(
[fldId] [int] NOT NULL,
[fldFactorId] [int] NOT NULL,
[fldAshkhasId] [int] NULL,
[fldBudjeCodingId] [int] NULL,
[fldTankhahGroupId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldOrganID] [int] NOT NULL,
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFactorMostaghel_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFactorMostaghel_fldDate] DEFAULT (getdate()),
[fldTarikhVariz] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldQRCode] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblFactorMostaghel] ADD CONSTRAINT [PK_tblFactorMostaghel] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblFactorMostaghel] ADD CONSTRAINT [FK_tblFactorMostaghel_tblAshkhas] FOREIGN KEY ([fldAshkhasId]) REFERENCES [Com].[tblAshkhas] ([fldId])
GO
ALTER TABLE [Cntr].[tblFactorMostaghel] ADD CONSTRAINT [FK_tblFactorMostaghel_tblCodingBudje_Details] FOREIGN KEY ([fldBudjeCodingId]) REFERENCES [BUD].[tblCodingBudje_Details] ([fldCodeingBudjeId])
GO
ALTER TABLE [Cntr].[tblFactorMostaghel] ADD CONSTRAINT [FK_tblFactorMostaghel_tblFactor] FOREIGN KEY ([fldFactorId]) REFERENCES [Cntr].[tblFactor] ([fldId])
GO
ALTER TABLE [Cntr].[tblFactorMostaghel] ADD CONSTRAINT [FK_tblFactorMostaghel_tblOrganization] FOREIGN KEY ([fldOrganID]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Cntr].[tblFactorMostaghel] ADD CONSTRAINT [FK_tblFactorMostaghel_tblTankhah_Group] FOREIGN KEY ([fldTankhahGroupId]) REFERENCES [Cntr].[tblTankhah_Group] ([fldId])
GO
ALTER TABLE [Cntr].[tblFactorMostaghel] ADD CONSTRAINT [FK_tblFactorMostaghel_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
