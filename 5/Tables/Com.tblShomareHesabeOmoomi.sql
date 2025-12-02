CREATE TABLE [Com].[tblShomareHesabeOmoomi]
(
[fldId] [int] NOT NULL,
[fldShobeId] [int] NOT NULL,
[fldAshkhasId] [int] NOT NULL,
[fldShomareHesab] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShomareSheba] [nvarchar] (27) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldBankId] AS ([com].[fn_BankIdForShobe]([fldShobeId])),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE Persian_100_CI_AI NOT NULL CONSTRAINT [DF_tblShomareHesab_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblShomareHesab_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblShomareHesabeOmoomi] ADD CONSTRAINT [CK_tblShomareHesabeDaramad_1] CHECK ((len([fldShomareHesab])>=(2)))
GO
ALTER TABLE [Com].[tblShomareHesabeOmoomi] ADD CONSTRAINT [CK_tblShomareHesabeOmoomi_1] CHECK (([fldshomaresheba] IS NULL OR [Com].[fn_CheckShomareSheba]([fldShomaresheba])=(1)))
GO
ALTER TABLE [Com].[tblShomareHesabeOmoomi] ADD CONSTRAINT [PK_tblShomareHesabeDaramad] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblShomareHesabeOmoomi] ADD CONSTRAINT [FK_tblShomareHesab_tblSHobe] FOREIGN KEY ([fldShobeId]) REFERENCES [Com].[tblSHobe] ([fldId])
GO
ALTER TABLE [Com].[tblShomareHesabeOmoomi] ADD CONSTRAINT [FK_tblShomareHesab_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Com].[tblShomareHesabeOmoomi] ADD CONSTRAINT [FK_tblShomareHesabeDaramad_tblAshkhas] FOREIGN KEY ([fldAshkhasId]) REFERENCES [Com].[tblAshkhas] ([fldId])
GO
