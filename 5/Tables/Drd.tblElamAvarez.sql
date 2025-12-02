CREATE TABLE [Drd].[tblElamAvarez]
(
[fldId] [int] NOT NULL,
[fldAshakhasID] [int] NOT NULL,
[fldType] [bit] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblElamAvarez_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblElamAvarez_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL,
[fldIsExternal] [bit] NULL,
[fldDaramadGroupId] [int] NULL,
[fldCodeSystemMabda] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldTarikh] AS ([dbo].[Fn_AssembelyMiladiToShamsi]([flddate]))
) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblElamAvarez] ADD CONSTRAINT [PK_tblElamAvarez] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblElamAvarez] ADD CONSTRAINT [FK_tblElamAvarez_tblAshkhas] FOREIGN KEY ([fldAshakhasID]) REFERENCES [Com].[tblAshkhas] ([fldId])
GO
ALTER TABLE [Drd].[tblElamAvarez] ADD CONSTRAINT [FK_tblElamAvarez_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Drd].[tblElamAvarez] ADD CONSTRAINT [FK_tblElamAvarez_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
