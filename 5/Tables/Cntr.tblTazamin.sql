CREATE TABLE [Cntr].[tblTazamin]
(
[fldId] [int] NOT NULL,
[fldContractId] [int] NOT NULL,
[fldWarrantyTypeId] [int] NOT NULL,
[fldTypeTamdid] [bit] NOT NULL,
[fldSepamNum] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikh] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMablagh] [bigint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTazamin_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTazamin_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblTazamin] ADD CONSTRAINT [PK_tblTazamin] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblTazamin] ADD CONSTRAINT [FK_tblTazamin_tblContracts] FOREIGN KEY ([fldContractId]) REFERENCES [Cntr].[tblContracts] ([fldId])
GO
ALTER TABLE [Cntr].[tblTazamin] ADD CONSTRAINT [FK_tblTazamin_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Cntr].[tblTazamin] ADD CONSTRAINT [FK_tblTazamin_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Cntr].[tblTazamin] ADD CONSTRAINT [FK_tblTazamin_tblWarrantyType] FOREIGN KEY ([fldWarrantyTypeId]) REFERENCES [Com].[tblWarrantyType] ([fldId])
GO
