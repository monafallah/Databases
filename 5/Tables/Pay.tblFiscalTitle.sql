CREATE TABLE [Pay].[tblFiscalTitle]
(
[fldId] [int] NOT NULL,
[fldFiscalHeaderId] [int] NOT NULL,
[fldItemEstekhdamId] [int] NOT NULL,
[fldAnvaEstekhdamId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFiscalTitle_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFiscalTitle_fldDesc] DEFAULT ('')
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblFiscalTitle] ADD CONSTRAINT [PK_tblFiscalTitle] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblFiscalTitle] ADD CONSTRAINT [IX_tblFiscalTitle] UNIQUE NONCLUSTERED ([fldFiscalHeaderId], [fldAnvaEstekhdamId], [fldItemEstekhdamId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblFiscalTitle] ADD CONSTRAINT [FK_tblFiscalTitle_Pay_tblFiscal_Header] FOREIGN KEY ([fldFiscalHeaderId]) REFERENCES [Pay].[tblFiscal_Header] ([fldId])
GO
ALTER TABLE [Pay].[tblFiscalTitle] ADD CONSTRAINT [FK_tblFiscalTitle_tblAnvaEstekhdam] FOREIGN KEY ([fldAnvaEstekhdamId]) REFERENCES [Com].[tblAnvaEstekhdam] ([fldId])
GO
ALTER TABLE [Pay].[tblFiscalTitle] ADD CONSTRAINT [FK_tblFiscalTitle_tblItems_Estekhdam] FOREIGN KEY ([fldItemEstekhdamId]) REFERENCES [Com].[tblItems_Estekhdam] ([fldId])
GO
ALTER TABLE [Pay].[tblFiscalTitle] ADD CONSTRAINT [FK_tblFiscalTitle_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
