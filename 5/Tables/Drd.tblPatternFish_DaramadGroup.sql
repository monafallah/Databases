CREATE TABLE [Drd].[tblPatternFish_DaramadGroup]
(
[fldId] [int] NOT NULL,
[fldPatternFishId] [int] NOT NULL,
[fldDaramadGroupId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblParametrFish_DaramadGroup_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblParametrFish_DaramadGroup_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPatternFish_DaramadGroup] ADD CONSTRAINT [PK_tblParametrFish_DaramadGroup] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblPatternFish_DaramadGroup] ADD CONSTRAINT [FK_tblParametrFish_DaramadGroup_tblDaramadGroup] FOREIGN KEY ([fldDaramadGroupId]) REFERENCES [Drd].[tblDaramadGroup] ([fldId])
GO
ALTER TABLE [Drd].[tblPatternFish_DaramadGroup] ADD CONSTRAINT [FK_tblParametrFish_DaramadGroup_tblParametrFish_DaramadGroup] FOREIGN KEY ([fldPatternFishId]) REFERENCES [Drd].[tblPatternFish] ([fldId])
GO
ALTER TABLE [Drd].[tblPatternFish_DaramadGroup] ADD CONSTRAINT [FK_tblParametrFish_DaramadGroup_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
