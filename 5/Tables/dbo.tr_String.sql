CREATE TABLE [dbo].[tr_String]
(
[Id] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Value] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tr_String] ADD CONSTRAINT [pk_strng_9912B79F] PRIMARY KEY CLUSTERED ([Id]) ON [PRIMARY]
GO
