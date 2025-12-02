CREATE TYPE [Cntr].[InserDetailFactor] AS TABLE
(
[fldCodingDetailId] [int] NULL,
[fldid] [int] NULL,
[fldMablagh] [bigint] NULL,
[fldMablaghMaliyat] [bigint] NULL,
[fldSharhArtikl] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldTax] [bit] NULL
)
GO
