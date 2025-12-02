CREATE TABLE [Drd].[tblShomareHesab_Formula]
(
[fldId] [int] NOT NULL,
[fldShomareHesab_CodeId] [int] NOT NULL,
[fldFormolsaz] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldFormulKoliId] [int] NULL,
[fldFormulMohasebatId] [int] NULL,
[fldTarikhEjra] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblShomareHesab_Formula_fldDate] DEFAULT (getdate()),
[fldUserId] [int] NOT NULL,
[fldActive] [bit] NOT NULL CONSTRAINT [DF_tblShomareHesab_Formula_fldActive] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblShomareHesab_Formula] ADD CONSTRAINT [PK_tblShomareHesab_Formula] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblShomareHesab_Formula] ADD CONSTRAINT [FK_tblShomareHesab_Formula_tblComputationFormula] FOREIGN KEY ([fldFormulKoliId]) REFERENCES [Com].[tblComputationFormula] ([fldId])
GO
ALTER TABLE [Drd].[tblShomareHesab_Formula] ADD CONSTRAINT [FK_tblShomareHesab_Formula_tblComputationFormula1] FOREIGN KEY ([fldFormulMohasebatId]) REFERENCES [Com].[tblComputationFormula] ([fldId])
GO
ALTER TABLE [Drd].[tblShomareHesab_Formula] ADD CONSTRAINT [FK_tblShomareHesab_Formula_tblShomareHesabCodeDaramad] FOREIGN KEY ([fldShomareHesab_CodeId]) REFERENCES [Drd].[tblShomareHesabCodeDaramad] ([fldId])
GO
ALTER TABLE [Drd].[tblShomareHesab_Formula] ADD CONSTRAINT [FK_tblShomareHesab_Formula_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
