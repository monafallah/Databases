CREATE TABLE [Arch].[tblProperties]
(
[fldId] [int] NOT NULL,
[fldNameFn] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldNameEn] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldType] [int] NOT NULL,
[fldFormulId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblProperties_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblProperties_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblProperties] ADD CONSTRAINT [PK_tblProperties_1] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblProperties] ADD CONSTRAINT [IX_tblProperties_2] UNIQUE NONCLUSTERED ([fldNameEn]) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblProperties] ADD CONSTRAINT [IX_tblProperties_1] UNIQUE NONCLUSTERED ([fldNameFn]) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblProperties] ADD CONSTRAINT [FK_tblProperties_tblComputationFormula] FOREIGN KEY ([fldFormulId]) REFERENCES [Com].[tblComputationFormula] ([fldId])
GO
ALTER TABLE [Arch].[tblProperties] ADD CONSTRAINT [FK_tblProperties_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
