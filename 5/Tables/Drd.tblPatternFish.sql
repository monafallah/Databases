CREATE TABLE [Drd].[tblPatternFish]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFileId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPatternFish_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPatternFish_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPatternFish] ADD CONSTRAINT [PK_tblPatternFish] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblPatternFish] ADD CONSTRAINT [FK_tblPatternFish_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [Drd].[tblPatternFish] ADD CONSTRAINT [FK_tblPatternFish_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
