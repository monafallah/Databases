CREATE TABLE [Drd].[tblPcPosInfo]
(
[fldId] [int] NOT NULL,
[fldPspId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPcPosInfo_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPcPosInfo_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPcPosInfo] ADD CONSTRAINT [PK_tblPcPosInfo] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblPcPosInfo] ADD CONSTRAINT [IX_tblPcPosInfo] UNIQUE NONCLUSTERED ([fldPspId], [fldOrganId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPcPosInfo] ADD CONSTRAINT [FK_tblPcPosInfo_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Drd].[tblPcPosInfo] ADD CONSTRAINT [FK_tblPcPosInfo_tblPcPosInfo] FOREIGN KEY ([fldId]) REFERENCES [Drd].[tblPcPosInfo] ([fldId])
GO
ALTER TABLE [Drd].[tblPcPosInfo] ADD CONSTRAINT [FK_tblPcPosInfo_tblPspModel] FOREIGN KEY ([fldPspId]) REFERENCES [Drd].[tblPspModel] ([fldId])
GO
ALTER TABLE [Drd].[tblPcPosInfo] ADD CONSTRAINT [FK_tblPcPosInfo_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
