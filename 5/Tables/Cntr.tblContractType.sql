CREATE TABLE [Cntr].[tblContractType]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDarsadBimePeymankar] [decimal] (5, 2) NOT NULL,
[fldDarsadBimeKarfarma] [decimal] (5, 2) NOT NULL,
[fldDarsadAnjamKar] [decimal] (5, 2) NOT NULL,
[fldDarsadZemanatName] [decimal] (5, 2) NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblContractType_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblContractType_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblContractType] ADD CONSTRAINT [PK_tblContractType] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblContractType] ADD CONSTRAINT [IX_tblContractType] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblContractType] ADD CONSTRAINT [FK_tblContractType_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Cntr].[tblContractType] ADD CONSTRAINT [FK_tblContractType_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
