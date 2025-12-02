CREATE TABLE [Pay].[tblMoteghayerhayeHoghoghi_Detail]
(
[fldId] [int] NOT NULL,
[fldMoteghayerhayeHoghoghiId] [int] NOT NULL,
[fldItemEstekhdamId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_Detail_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_Detail_fldDesc] DEFAULT (''),
[fldMazayaMashmool] [bit] NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_Detail_fldMazayaMashmool] DEFAULT ((0))
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMoteghayerhayeHoghoghi_Detail] ADD CONSTRAINT [PK_tblMoteghayerhayeHoghoghi_Detail] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMoteghayerhayeHoghoghi_Detail] ADD CONSTRAINT [FK_tblMoteghayerhayeHoghoghi_Detail_Pay_tblMoteghayerhayeHoghoghi] FOREIGN KEY ([fldMoteghayerhayeHoghoghiId]) REFERENCES [Pay].[tblMoteghayerhayeHoghoghi] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Pay].[tblMoteghayerhayeHoghoghi_Detail] ADD CONSTRAINT [FK_tblMoteghayerhayeHoghoghi_Detail_tblItems_Estekhdam] FOREIGN KEY ([fldItemEstekhdamId]) REFERENCES [Com].[tblItems_Estekhdam] ([fldId])
GO
ALTER TABLE [Pay].[tblMoteghayerhayeHoghoghi_Detail] ADD CONSTRAINT [FK_tblMoteghayerhayeHoghoghi_Detail_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
