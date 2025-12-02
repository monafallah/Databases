CREATE TABLE [Drd].[tblMap_Detail]
(
[fldId] [int] NOT NULL,
[fldHeaderId] [int] NOT NULL,
[fldMaghsadId] [int] NOT NULL,
[fldCodeDaramadMabda] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMap_Detail_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblMap_Detail] ADD CONSTRAINT [PK_tblMap_Detail] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblMap_Detail] ADD CONSTRAINT [FK_tblMap_Detail_tblCodhayeDaramd] FOREIGN KEY ([fldMaghsadId]) REFERENCES [Drd].[tblCodhayeDaramd] ([fldId])
GO
ALTER TABLE [Drd].[tblMap_Detail] ADD CONSTRAINT [FK_tblMap_Detail_tblMap_Header] FOREIGN KEY ([fldHeaderId]) REFERENCES [Drd].[tblMap_Header] ([fldId])
GO
ALTER TABLE [Drd].[tblMap_Detail] ADD CONSTRAINT [FK_tblMap_Detail_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Drd].[tblMap_Detail] ADD CONSTRAINT [FK_tblMap_Detail_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
