CREATE TABLE [Drd].[tblExternalFish]
(
[fldId] [int] NOT NULL,
[fldNameCompany] [nvarchar] (350) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFishKhareji_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFishKhareji_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblExternalFish] ADD CONSTRAINT [PK_tblFishKhareji] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblExternalFish] ADD CONSTRAINT [IX_tblFishKhareji] UNIQUE NONCLUSTERED ([fldNameCompany]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblExternalFish] ADD CONSTRAINT [FK_tblExternalFish_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
