CREATE TYPE [ACC].[TemplateCode] AS TABLE
(
[fldDaramadCode] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldId] [int] NOT NULL,
PRIMARY KEY CLUSTERED ([fldId])
)
GO
