CREATE TYPE [ACC].[DocumentDetailUpdate] AS TABLE
(
[fldBedehkar] [bigint] NULL,
[fldBestankar] [bigint] NULL,
[fldCaseId] [int] NULL,
[fldCaseTypeId] [int] NULL,
[fldCenterCoId] [int] NULL,
[fldCodingId] [int] NULL,
[fldDescription] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldDocument_HedearId] [int] NULL,
[fldId] [int] NOT NULL,
[fldOrder] [smallint] NULL,
[fldSourceId] [int] NULL
)
GO
