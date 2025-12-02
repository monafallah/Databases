CREATE TABLE [Dead].[tblCodeDaramadAramestan]
(
[fldId] [int] NOT NULL,
[fldCodeDaramadId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCodeDaramadAramestan_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCodeDaramadAramestan_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblCodeDaramadAramestan] ADD CONSTRAINT [PK_tblCodeDaramadAramestan] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblCodeDaramadAramestan] ADD CONSTRAINT [FK_tblCodeDaramadAramestan_tblCodhayeDaramd] FOREIGN KEY ([fldCodeDaramadId]) REFERENCES [Drd].[tblCodhayeDaramd] ([fldId])
GO
ALTER TABLE [Dead].[tblCodeDaramadAramestan] ADD CONSTRAINT [FK_tblCodeDaramadAramestan_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Dead].[tblCodeDaramadAramestan] ADD CONSTRAINT [FK_tblCodeDaramadAramestan_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
