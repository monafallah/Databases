CREATE TABLE [Drd].[tblCodhayeDaramd]
(
[fldId] [int] NOT NULL,
[fldDaramadId] [sys].[hierarchyid] NOT NULL,
[fldDaramadCode] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDaramadTitle] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMashmooleArzesheAfzoode] [bit] NOT NULL,
[fldMashmooleKarmozd] [bit] NOT NULL,
[fldUnitId] [int] NOT NULL,
[fldLevel] AS ([fldDaramadId].[GetLevel]()),
[fldStrhid] AS ([fldDaramadId].[ToString]()),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCodhayeDaramd_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCodhayeDaramd_fldDate] DEFAULT (getdate()),
[fldAmuzeshParvaresh] [bit] NOT NULL CONSTRAINT [DF_tblCodhayeDaramd_fldAmuzeshParvaresh] DEFAULT ((0))
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblCodhayeDaramd] ADD CONSTRAINT [PK_tblCodhayeDaramd] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblCodhayeDaramd] ADD CONSTRAINT [IX_tblCodhayeDaramd_2] UNIQUE NONCLUSTERED ([fldDaramadId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblCodhayeDaramd] ADD CONSTRAINT [FK_tblCodhayeDaramd_tblMeasureUnit] FOREIGN KEY ([fldUnitId]) REFERENCES [Com].[tblMeasureUnit] ([fldId])
GO
ALTER TABLE [Drd].[tblCodhayeDaramd] ADD CONSTRAINT [FK_tblCodhayeDaramd_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
