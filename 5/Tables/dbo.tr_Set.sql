CREATE TABLE [dbo].[tr_Set]
(
[Id] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Member] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tr_Set] ADD CONSTRAINT [pk_st_DE59633C] PRIMARY KEY CLUSTERED ([Id], [Member]) ON [PRIMARY]
GO
