CREATE TABLE [ACC].[tbltemp]
(
[fldId] [int] NOT NULL,
[fldTempCodeId] [sys].[hierarchyid] NOT NULL,
[fldLevelId] AS ([fldTempCodeId].[GetLevel]()),
[fldStrhid] AS ([fldTempCodeId].[ToString]()),
[fldItemId] [int] NULL,
[fldName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPCod] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldMahiyatId] [int] NULL,
[fldCode] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTempNameId] [int] NULL,
[fldLevelsAccountTypId] [int] NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tbltemp_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tbltemp_fldDate] DEFAULT (getdate()),
[fldIp] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldTypeHesabId] [tinyint] NOT NULL,
[fldCodeBudget] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldAddChildNode] [bit] NULL,
[fldMahiyat_GardeshId] [int] NULL
) ON [PRIMARY]
GO
