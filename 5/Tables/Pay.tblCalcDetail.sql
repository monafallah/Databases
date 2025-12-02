CREATE TABLE [Pay].[tblCalcDetail]
(
[fldId] [int] NOT NULL IDENTITY(1, 1),
[fldHeaderId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldUserId] [int] NULL,
[fldDate] [smalldatetime] NULL,
[fldTypeEstekhdamId] [int] NULL,
[fldCostCenterId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblCalcDetail] ADD CONSTRAINT [PK_tblCalcDetail] PRIMARY KEY NONCLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblCalcDetail] ADD CONSTRAINT [FK_tblCalcDetail_tblCalcHeader] FOREIGN KEY ([fldTypeEstekhdamId]) REFERENCES [Com].[tblTypeEstekhdam] ([fldId]) ON DELETE CASCADE
GO
ALTER TABLE [Pay].[tblCalcDetail] ADD CONSTRAINT [FK_tblCalcDetail_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
