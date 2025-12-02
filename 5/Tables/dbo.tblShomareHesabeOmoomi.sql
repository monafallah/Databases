CREATE TABLE [dbo].[tblShomareHesabeOmoomi]
(
[fldId] [int] NOT NULL,
[fldShobeId] [int] NOT NULL,
[fldAshkhasId] [int] NOT NULL,
[fldShomareHesab] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShomareSheba] [varchar] (26) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldShomareCard] [char] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblShomareHesab_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblShomareHesab_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblShomareHesabeOmoomi] ADD CONSTRAINT [CK_tblShomareHesabeDaramad_1] CHECK ((len([fldShomareHesab])>=(2)))
GO
ALTER TABLE [dbo].[tblShomareHesabeOmoomi] ADD CONSTRAINT [PK_tblShomareHesabeDaramad] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
