CREATE TABLE [Pay].[tblMoteghayerhayeHoghoghiItems]
(
[fldId] [int] NOT NULL,
[fldMoteghayerhayeHoghoghiId] [int] NOT NULL,
[fldItemEstekhdamId] [int] NOT NULL,
[fldType] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghiItems_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMoteghayerhayeHoghoghiItems] ADD CONSTRAINT [PK_tblMoteghayerhayeHoghoghiItems] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMoteghayerhayeHoghoghiItems] ADD CONSTRAINT [FK_tblMoteghayerhayeHoghoghiItems_tblItems_Estekhdam] FOREIGN KEY ([fldItemEstekhdamId]) REFERENCES [Com].[tblItems_Estekhdam] ([fldId])
GO
ALTER TABLE [Pay].[tblMoteghayerhayeHoghoghiItems] ADD CONSTRAINT [FK_tblMoteghayerhayeHoghoghiItems_tblMoteghayerhayeHoghoghi] FOREIGN KEY ([fldMoteghayerhayeHoghoghiId]) REFERENCES [Pay].[tblMoteghayerhayeHoghoghi] ([fldId])
GO
