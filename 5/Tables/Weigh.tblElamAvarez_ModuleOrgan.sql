CREATE TABLE [Weigh].[tblElamAvarez_ModuleOrgan]
(
[fldId] [int] NOT NULL,
[fldElamAvarezId] [int] NOT NULL,
[fldCodeDaramdElamAvarezId] [int] NOT NULL,
[Id] [int] NOT NULL,
[fldModulOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblElamAvarez_ModuleOrgan_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblElamAvarez_ModuleOrgan] ADD CONSTRAINT [PK_tblElamAvarez_ModuleOrgan] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblElamAvarez_ModuleOrgan] ADD CONSTRAINT [FK_tblElamAvarez_ModuleOrgan_tblCodhayeDaramadiElamAvarez] FOREIGN KEY ([fldCodeDaramdElamAvarezId]) REFERENCES [Drd].[tblCodhayeDaramadiElamAvarez] ([fldID])
GO
ALTER TABLE [Weigh].[tblElamAvarez_ModuleOrgan] ADD CONSTRAINT [FK_tblElamAvarez_ModuleOrgan_tblElamAvarez] FOREIGN KEY ([fldElamAvarezId]) REFERENCES [Drd].[tblElamAvarez] ([fldId])
GO
ALTER TABLE [Weigh].[tblElamAvarez_ModuleOrgan] ADD CONSTRAINT [FK_tblElamAvarez_ModuleOrgan_tblModule_Organ] FOREIGN KEY ([fldModulOrganId]) REFERENCES [Com].[tblModule_Organ] ([fldId])
GO
ALTER TABLE [Weigh].[tblElamAvarez_ModuleOrgan] ADD CONSTRAINT [FK_tblElamAvarez_ModuleOrgan_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
