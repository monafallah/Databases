CREATE TYPE [Com].[MasoulinDetail] AS TABLE
(
[fldId] [int] NOT NULL,
[fldEmployId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldMasuolinId] [int] NOT NULL,
[fldOrderId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
