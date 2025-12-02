CREATE TABLE [Com].[tblCaseBills]
(
[fldId] [int] NOT NULL,
[fldBillsTypeId] [int] NOT NULL,
[fldFileNum] [int] NOT NULL,
[fldCentercoId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldOrganChartId] [int] NOT NULL,
[fldAshkhasId] [int] NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFileBills_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFileBills_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblCaseBills] ADD CONSTRAINT [PK_tblFileBills] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblCaseBills] ON [Com].[tblCaseBills] ([fldFileNum]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblCaseBills] ADD CONSTRAINT [FK_tblCaseBills_tblAshkhas] FOREIGN KEY ([fldAshkhasId]) REFERENCES [Com].[tblAshkhas] ([fldId])
GO
ALTER TABLE [Com].[tblCaseBills] ADD CONSTRAINT [FK_tblCaseBills_tblBillsType] FOREIGN KEY ([fldBillsTypeId]) REFERENCES [Com].[tblBillsType] ([fldId])
GO
ALTER TABLE [Com].[tblCaseBills] ADD CONSTRAINT [FK_tblCaseBills_tblCenterCost] FOREIGN KEY ([fldCentercoId]) REFERENCES [ACC].[tblCenterCost] ([fldId])
GO
ALTER TABLE [Com].[tblCaseBills] ADD CONSTRAINT [FK_tblCaseBills_tblChartOrgan] FOREIGN KEY ([fldOrganChartId]) REFERENCES [Com].[tblChartOrgan] ([fldId])
GO
ALTER TABLE [Com].[tblCaseBills] ADD CONSTRAINT [FK_tblCaseBills_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Com].[tblCaseBills] ADD CONSTRAINT [FK_tblCaseBills_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
