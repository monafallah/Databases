CREATE TABLE [Prs].[tblPersonalHokm]
(
[fldId] [int] NOT NULL,
[fldPrs_PersonalInfoId] [int] NOT NULL,
[fldTarikhEjra] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikhSodoor] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikhEtmam] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldAnvaeEstekhdamId] [int] NOT NULL,
[fldGroup] [tinyint] NOT NULL,
[fldMoreGroup] [tinyint] NOT NULL,
[fldShomarePostSazmani] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTedadFarzand] [tinyint] NOT NULL,
[fldTedadAfradTahteTakafol] [tinyint] NOT NULL,
[fldTypehokm] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShomareHokm] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldStatusHokm] [bit] NOT NULL,
[fldDescriptionHokm] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldCodeShoghl] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldStatusTaaholId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldFileId] [int] NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblPersonalHokm_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblPersonalHokm_fldDesc] DEFAULT (''),
[fldMashmooleBime] [int] NOT NULL CONSTRAINT [DF_tblPersonalHokm_fldMashmooleBime] DEFAULT ((0)),
[fldTatbigh1] [int] NOT NULL CONSTRAINT [DF_tblPersonalHokm_fldTatbighe1] DEFAULT ((0)),
[fldTatbigh2] [int] NOT NULL CONSTRAINT [DF_tblPersonalHokm_fldTatbighe2] DEFAULT ((0)),
[fldHasZaribeTadil] [bit] NOT NULL CONSTRAINT [DF_tblPersonalHokm_fldHasZaribeTadil] DEFAULT ((0)),
[fldZaribeSal1] [smallint] NOT NULL CONSTRAINT [DF_tblPersonalHokm_fldZaribeSale1] DEFAULT ((0)),
[fldZaribeSal2] [smallint] NOT NULL CONSTRAINT [DF_tblPersonalHokm_fldZaribeSale2] DEFAULT ((0)),
[fldSumItem] AS ([Prs].[fn_SumItemHokm]([fldId])),
[fldTarikhShoroo] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldHokmType] [tinyint] NOT NULL CONSTRAINT [DF_tblPersonalHokm_fldHokmType] DEFAULT ((1))
) ON [Personeli]
GO
ALTER TABLE [Prs].[tblPersonalHokm] ADD CONSTRAINT [PK_tblPersonalHokm] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
CREATE NONCLUSTERED INDEX [<Mohasebe>] ON [Prs].[tblPersonalHokm] ([fldPrs_PersonalInfoId], [fldStatusHokm], [fldTarikhEjra]) ON [Personeli]
GO
CREATE NONCLUSTERED INDEX [IX_tblPersonalHokm] ON [Prs].[tblPersonalHokm] ([fldTarikhEjra]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblPersonalHokm] ADD CONSTRAINT [FK_tblPersonalHokm_Prs_tblPersonalInfo] FOREIGN KEY ([fldPrs_PersonalInfoId]) REFERENCES [Prs].[Prs_tblPersonalInfo] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Prs].[tblPersonalHokm] ADD CONSTRAINT [FK_tblPersonalHokm_tblAnvaEstekhdam] FOREIGN KEY ([fldAnvaeEstekhdamId]) REFERENCES [Com].[tblAnvaEstekhdam] ([fldId])
GO
ALTER TABLE [Prs].[tblPersonalHokm] ADD CONSTRAINT [FK_tblPersonalHokm_tblStatusTaahol] FOREIGN KEY ([fldStatusTaaholId]) REFERENCES [Com].[tblStatusTaahol] ([fldId])
GO
ALTER TABLE [Prs].[tblPersonalHokm] ADD CONSTRAINT [FK_tblPersonalHokm_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
