CREATE TABLE [Cntr].[tblContracts]
(
[fldId] [int] NOT NULL,
[fldContractTypeId] [int] NOT NULL,
[fldNaghshOrgan] [bit] NOT NULL,
[fldTarikh] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShomare] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldSubject] [nvarchar] (150) COLLATE Persian_100_CI_AI NOT NULL,
[fldTarikhEblagh] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShomareEblagh] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAshkhasId] [int] NOT NULL,
[fldMablagh] [bigint] NOT NULL,
[fldSuplyMaterialsType] [tinyint] NOT NULL,
[fldStartDate] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldEndDate] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMandePardakhtNashode] [bigint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblContracts_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblContracts_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblContracts] ADD CONSTRAINT [PK_tblContracts] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblContracts] ADD CONSTRAINT [FK_tblContracts_tblAshkhas] FOREIGN KEY ([fldAshkhasId]) REFERENCES [Com].[tblAshkhas] ([fldId])
GO
ALTER TABLE [Cntr].[tblContracts] ADD CONSTRAINT [FK_tblContracts_tblContractType] FOREIGN KEY ([fldContractTypeId]) REFERENCES [Cntr].[tblContractType] ([fldId])
GO
ALTER TABLE [Cntr].[tblContracts] ADD CONSTRAINT [FK_tblContracts_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Cntr].[tblContracts] ADD CONSTRAINT [FK_tblContracts_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
