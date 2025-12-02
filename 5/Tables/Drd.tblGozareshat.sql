CREATE TABLE [Drd].[tblGozareshat]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [Daramad]
GO
ALTER TABLE [Drd].[tblGozareshat] ADD CONSTRAINT [PK_tblGozareshat] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblGozareshat] ADD CONSTRAINT [FK_tblGozareshat_tblGozareshat] FOREIGN KEY ([fldId]) REFERENCES [Drd].[tblGozareshat] ([fldId])
GO
