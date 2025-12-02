CREATE TABLE [Com].[tblShomareHesabOmoomi_Detail]
(
[fldId] [int] NOT NULL,
[fldShomareHesabId] [int] NOT NULL,
[fldTypeHesab] [bit] NOT NULL,
[fldShomareKart] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblShomareHesabOmoomi_Detail_fldDate] DEFAULT (getdate()),
[fldHesabTypeId] [tinyint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblShomareHesabOmoomi_Detail] ADD CONSTRAINT [PK_tblShomareHesabOmoomi_Detail] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblShomareHesabOmoomi_Detail] ADD CONSTRAINT [FK_tblShomareHesabOmoomi_Detail_tblShomareHesabeOmoomi] FOREIGN KEY ([fldShomareHesabId]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
ALTER TABLE [Com].[tblShomareHesabOmoomi_Detail] ADD CONSTRAINT [FK_tblShomareHesabOmoomi_Detail_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
