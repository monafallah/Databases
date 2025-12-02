CREATE TABLE [Drd].[tblParametreSabet]
(
[fldId] [int] NOT NULL,
[fldShomareHesabCodeDaramadId] [int] NOT NULL,
[fldNameParametreFa] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldNameParametreEn] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldNoe] [bit] NOT NULL,
[fldNoeField] [tinyint] NOT NULL,
[fldFormulId] [int] NULL,
[fldVaziyat] [bit] NOT NULL,
[fldComboBaxId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblParametreSabet_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblParametreSabet_fldDate] DEFAULT (getdate()),
[fldTypeParametr] [bit] NOT NULL CONSTRAINT [DF_tblParametreSabet_fldTypeParametr] DEFAULT ((1)),
[fldDescCopy] [nchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblParametreSabet_fldDescCopy] DEFAULT ('')
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblParametreSabet] ADD CONSTRAINT [PK_tblParametreSabet_1] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblParametreSabet] ADD CONSTRAINT [IX_tblParametreSabet_1] UNIQUE NONCLUSTERED ([fldShomareHesabCodeDaramadId], [fldNameParametreEn]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblParametreSabet] ADD CONSTRAINT [IX_tblParametreSabet] UNIQUE NONCLUSTERED ([fldShomareHesabCodeDaramadId], [fldNameParametreFa]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblParametreSabet] ADD CONSTRAINT [FK_tblParametreSabet_tblComboBox] FOREIGN KEY ([fldComboBaxId]) REFERENCES [Drd].[tblComboBox] ([fldId])
GO
ALTER TABLE [Drd].[tblParametreSabet] ADD CONSTRAINT [FK_tblParametreSabet_tblComputationFormula] FOREIGN KEY ([fldFormulId]) REFERENCES [Com].[tblComputationFormula] ([fldId])
GO
ALTER TABLE [Drd].[tblParametreSabet] ADD CONSTRAINT [FK_tblParametreSabet_tblShomareHesabCodeDaramad] FOREIGN KEY ([fldShomareHesabCodeDaramadId]) REFERENCES [Drd].[tblShomareHesabCodeDaramad] ([fldId])
GO
ALTER TABLE [Drd].[tblParametreSabet] ADD CONSTRAINT [FK_tblParametreSabet_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
