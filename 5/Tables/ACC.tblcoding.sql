CREATE TABLE [ACC].[tblcoding]
(
[fldId] [int] NOT NULL,
[fldCodeId] [sys].[hierarchyid] NOT NULL,
[fldLevelId] AS ([fldCodeId].[GetLevel]()),
[fldStrhid] AS ([fldCodeId].[ToString]()),
[fldHeaderCodId] [int] NULL,
[fldPCod] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldTempCodingId] [int] NULL,
[fldTitle] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldCode] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAccountLevelId] [int] NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL,
[fldIp] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldMahiyatId] [int] NULL,
[fldTypeHesabId] [tinyint] NOT NULL,
[fldDaramadCode] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldMahiyat_GardeshId] [int] NULL
) ON [PRIMARY]
GO
