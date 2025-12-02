CREATE TABLE [dbo].[Content]
(
[id] [uniqueidentifier] NOT NULL,
[content] [varbinary] (max) NULL,
[extension] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Content] ADD CONSTRAINT [PK_content] PRIMARY KEY CLUSTERED ([id]) ON [PRIMARY]
GO
CREATE FULLTEXT INDEX ON [dbo].[Content] KEY INDEX [PK_content] ON [FTC] WITH STOPLIST OFF
GO
ALTER FULLTEXT INDEX ON [dbo].[Content] ADD ([content] TYPE COLUMN [extension] LANGUAGE 1033)
GO
