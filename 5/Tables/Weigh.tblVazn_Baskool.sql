CREATE TABLE [Weigh].[tblVazn_Baskool]
(
[fldId] [int] NOT NULL,
[fldPluqeId] [int] NOT NULL,
[fldRananadeId] [int] NOT NULL,
[fldNoeMasrafId] [tinyint] NULL,
[fldAshkhasId] [int] NULL,
[fldChartOrganEjraeeId] [int] NULL,
[fldLoadingPlaceId] [int] NULL,
[fldDateTazin] [datetime] NOT NULL,
[fldKalaId] [int] NULL,
[fldVaznKol] [decimal] (15, 3) NULL,
[fldVaznKhals] [decimal] (15, 3) NULL,
[fldRemittanceId] [int] NULL,
[fldTarikhVaznKhali] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldBaskoolId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblVazn_Baskool_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblVazn_Baskool_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIsPor] [bit] NOT NULL,
[fldTypeKhodroId] [int] NULL,
[fldIsPrint] [bit] NOT NULL CONSTRAINT [DF_tblVazn_Baskool_fldIsPrint] DEFAULT ((0)),
[fldEbtal] [bit] NOT NULL CONSTRAINT [DF_tblVazn_Baskool_fldEbtal] DEFAULT ((0)),
[fldTedad] [int] NULL,
[fldTypeMohasebe] [bit] NOT NULL CONSTRAINT [DF_tblVazn_Baskool_fldTypeMohasebe] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblVazn_Baskool] ADD CONSTRAINT [PK_tblVazn_Baskool] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblVazn_Baskool] ADD CONSTRAINT [FK_tblVazn_Baskool_tblAshkhas] FOREIGN KEY ([fldAshkhasId]) REFERENCES [Com].[tblAshkhas] ([fldId])
GO
ALTER TABLE [Weigh].[tblVazn_Baskool] ADD CONSTRAINT [FK_tblVazn_Baskool_tblChartOrganEjraee] FOREIGN KEY ([fldChartOrganEjraeeId]) REFERENCES [Com].[tblChartOrganEjraee] ([fldId])
GO
ALTER TABLE [Weigh].[tblVazn_Baskool] ADD CONSTRAINT [FK_tblVazn_Baskool_tblEmployee] FOREIGN KEY ([fldRananadeId]) REFERENCES [Com].[tblEmployee] ([fldId])
GO
ALTER TABLE [Weigh].[tblVazn_Baskool] ADD CONSTRAINT [FK_tblVazn_Baskool_tblKala] FOREIGN KEY ([fldKalaId]) REFERENCES [Com].[tblKala] ([fldId])
GO
ALTER TABLE [Weigh].[tblVazn_Baskool] ADD CONSTRAINT [FK_tblVazn_Baskool_tblLoadingPlace] FOREIGN KEY ([fldLoadingPlaceId]) REFERENCES [Weigh].[tblLoadingPlace] ([fldId])
GO
ALTER TABLE [Weigh].[tblVazn_Baskool] ADD CONSTRAINT [FK_tblVazn_Baskool_tblNoeMasraf] FOREIGN KEY ([fldNoeMasrafId]) REFERENCES [Weigh].[tblNoeMasraf] ([fldId])
GO
ALTER TABLE [Weigh].[tblVazn_Baskool] ADD CONSTRAINT [FK_tblVazn_Baskool_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Weigh].[tblVazn_Baskool] ADD CONSTRAINT [FK_tblVazn_Baskool_tblPlaque] FOREIGN KEY ([fldPluqeId]) REFERENCES [Com].[tblPlaque] ([fldId])
GO
ALTER TABLE [Weigh].[tblVazn_Baskool] ADD CONSTRAINT [FK_tblVazn_Baskool_tblRemittance_Header] FOREIGN KEY ([fldRemittanceId]) REFERENCES [Weigh].[tblRemittance_Header] ([fldId])
GO
ALTER TABLE [Weigh].[tblVazn_Baskool] ADD CONSTRAINT [FK_tblVazn_Baskool_tblTypeKhodro] FOREIGN KEY ([fldTypeKhodroId]) REFERENCES [Com].[tblTypeKhodro] ([fldId])
GO
ALTER TABLE [Weigh].[tblVazn_Baskool] ADD CONSTRAINT [FK_tblVazn_Baskool_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Weigh].[tblVazn_Baskool] ADD CONSTRAINT [FK_tblVazn_Baskool_tblWeighbridge] FOREIGN KEY ([fldBaskoolId]) REFERENCES [Weigh].[tblWeighbridge] ([fldId])
GO
