CREATE TABLE [Weigh].[tblArze_Detail]
(
[fldId] [int] NOT NULL,
[fldHeaderId] [int] NOT NULL,
[fldParametrSabetCodeDaramd] [int] NOT NULL,
[fldValue] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblArze_Detail_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblArze_Detail_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFlag] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblArze_Detail] ADD CONSTRAINT [PK_tblArze_Detail] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblArze_Detail] ADD CONSTRAINT [FK_tblArze_Detail_tblArze] FOREIGN KEY ([fldHeaderId]) REFERENCES [Weigh].[tblArze] ([fldId])
GO
ALTER TABLE [Weigh].[tblArze_Detail] ADD CONSTRAINT [FK_tblArze_Detail_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Weigh].[tblArze_Detail] ADD CONSTRAINT [FK_tblArze_Detail_tblParametreSabet] FOREIGN KEY ([fldParametrSabetCodeDaramd]) REFERENCES [Drd].[tblParametreSabet] ([fldId])
GO
ALTER TABLE [Weigh].[tblArze_Detail] ADD CONSTRAINT [FK_tblArze_Detail_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
