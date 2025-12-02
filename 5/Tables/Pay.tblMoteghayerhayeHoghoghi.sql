CREATE TABLE [Pay].[tblMoteghayerhayeHoghoghi]
(
[fldId] [int] NOT NULL,
[fldTarikhEjra] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikhSodur] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAnvaeEstekhdamId] [int] NOT NULL,
[fldTypeBimeId] [int] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_fldTypeBimeId] DEFAULT ((1)),
[fldZaribEzafeKar] [int] NOT NULL,
[fldSaatKari] [decimal] (8, 4) NOT NULL,
[fldDarsadBimePersonal] [decimal] (8, 2) NOT NULL,
[fldDarsadbimeKarfarma] [decimal] (8, 2) NOT NULL,
[fldDarsadBimeBikari] [decimal] (8, 2) NOT NULL,
[fldDarsadBimeJanbazan] [decimal] (8, 4) NOT NULL,
[fldHaghDarmanKarmand] [decimal] (8, 4) NOT NULL,
[fldHaghDarmanKarfarma] [decimal] (8, 4) NOT NULL,
[fldHaghDarmanDolat] [decimal] (8, 4) NOT NULL,
[fldHaghDarmanMazad] [int] NOT NULL,
[fldHaghDarmanTahteTakaffol] [int] NOT NULL,
[fldDarsadBimeMashagheleZiyanAvar] [decimal] (8, 4) NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_fldDarsadBimeMashaghel] DEFAULT ((0)),
[fldMaxHaghDarman] [int] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_fldMaxHaghDarman] DEFAULT ((0)),
[fldZaribHoghoghiSal] [int] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_fldZaribHoghoghiSal] DEFAULT ((0)),
[fldHoghogh] [bit] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_fldHoghogh] DEFAULT ((0)),
[fldFoghShoghl] [bit] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_fldFoghShoghl] DEFAULT ((0)),
[fldTafavotTatbigh] [bit] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_fldTafavotTatbigh] DEFAULT ((0)),
[fldFoghVizhe] [bit] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_fldFoghVizhe] DEFAULT ((0)),
[fldHaghJazb] [bit] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_fldHaghJazb] DEFAULT ((0)),
[fldTadil] [bit] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_fldTadil] DEFAULT ((0)),
[fldBarJastegi] [bit] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_fldBarJastegi] DEFAULT ((0)),
[fldSanavat] [bit] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_fldSanavat] DEFAULT ((0)),
[fldFoghTalash] [bit] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_fldFoghVizhe1] DEFAULT ((0)),
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMoteghayerhayeHoghoghi_fldDesc] DEFAULT ('')
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMoteghayerhayeHoghoghi] ADD CONSTRAINT [PK_tblMoteghayerhayeHoghoghi] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMoteghayerhayeHoghoghi] ADD CONSTRAINT [IX_Pay_tblMoteghayerhayeHoghoghi] UNIQUE NONCLUSTERED ([fldTarikhEjra], [fldTarikhSodur], [fldAnvaeEstekhdamId], [fldTypeBimeId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMoteghayerhayeHoghoghi] ADD CONSTRAINT [FK_tblMoteghayerhayeHoghoghi_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
