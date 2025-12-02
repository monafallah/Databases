CREATE TABLE [Auto].[tblContentFileTest]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldLetterText] [varbinary] (max) NOT NULL,
[fldLetterId] [bigint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL,
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblContentFileTest] ADD CONSTRAINT [PK_tblContentFiletest] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
CREATE FULLTEXT INDEX ON [Auto].[tblContentFileTest] KEY INDEX [PK_tblContentFiletest] ON [ContentFile]
GO
ALTER FULLTEXT INDEX ON [Auto].[tblContentFileTest] ADD ([fldLetterText] TYPE COLUMN [fldType] LANGUAGE 1033)
GO
