CREATE TYPE [ACC].[tblRecorde_File] AS TABLE
(
[fldArchiveTreeId] [int] NULL,
[fldId] [int] NOT NULL,
[fldImage] [varbinary] (max) NOT NULL,
[fldIsBookMark] [bit] NULL,
[fldPasvand] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
