CREATE TABLE [Cntr].[tblTamdid]
(
[fldId] [int] NOT NULL,
[fldContractId] [int] NOT NULL,
[fldTamdidTypeId] [tinyint] NOT NULL,
[fldTarikhPayan] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMablaghAfzayeshi] [bigint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTamdid_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTamdid_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblTamdid] ADD CONSTRAINT [PK_tblTamdid] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblTamdid] ADD CONSTRAINT [FK_tblTamdid_tblContracts] FOREIGN KEY ([fldContractId]) REFERENCES [Cntr].[tblContracts] ([fldId])
GO
ALTER TABLE [Cntr].[tblTamdid] ADD CONSTRAINT [FK_tblTamdid_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Cntr].[tblTamdid] ADD CONSTRAINT [FK_tblTamdid_tblTamdidTypes] FOREIGN KEY ([fldTamdidTypeId]) REFERENCES [Cntr].[tblTamdidTypes] ([fldId])
GO
ALTER TABLE [Cntr].[tblTamdid] ADD CONSTRAINT [FK_tblTamdid_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
