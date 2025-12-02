CREATE TABLE [Com].[tblComputationFormula]
(
[fldId] [int] NOT NULL,
[fldType] [bit] NULL,
[fldFormule] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganId] [int] NULL,
[fldLibrary] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAzTarikh] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_tblComputationFormula_fldAzTarikh] DEFAULT (''),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblComputationFormula_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblComputationFormula_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblComputationFormula] ADD CONSTRAINT [PK_tblComputationFormula] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblComputationFormula] ADD CONSTRAINT [FK_tblComputationFormula_tblComputationFormula] FOREIGN KEY ([fldId]) REFERENCES [Com].[tblComputationFormula] ([fldId])
GO
ALTER TABLE [Com].[tblComputationFormula] ADD CONSTRAINT [FK_tblComputationFormula_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Com].[tblComputationFormula] ADD CONSTRAINT [FK_tblComputationFormula_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
