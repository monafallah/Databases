CREATE TABLE [Drd].[tblFactor]
(
[fldId] [int] NOT NULL,
[fldFishId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFactor_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFactor_fldDate] DEFAULT (getdate()),
[fldTarikh] AS ([dbo].[Fn_AssembelyMiladiToShamsi]([fldDate]))
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblFactor] ADD CONSTRAINT [PK_tblFactor] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblFactor] ADD CONSTRAINT [IX_tblFactor] UNIQUE NONCLUSTERED ([fldFishId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblFactor] ADD CONSTRAINT [FK_tblFactor_tblSodoorFish] FOREIGN KEY ([fldFishId]) REFERENCES [Drd].[tblSodoorFish] ([fldId])
GO
ALTER TABLE [Drd].[tblFactor] ADD CONSTRAINT [FK_tblFactor_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
