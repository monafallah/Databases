CREATE TYPE [Weigh].[tblRemittance_Details] AS TABLE
(
[fldControlLimit] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldKalaId] [int] NOT NULL,
[fldMaxTon] [int] NOT NULL
)
GO
