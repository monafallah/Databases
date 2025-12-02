CREATE TABLE [Weigh].[tblArze]
(
[fldId] [int] NOT NULL,
[fldBaskoolId] [int] NOT NULL,
[fldKalaId] [int] NOT NULL,
[fldShomareHesabCodeDaramadId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblArze_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblArze_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTedad] [tinyint] NULL,
[fldMablagh] [bigint] NULL,
[fldStatusForoosh] [tinyint] NOT NULL,
[fldVaznVahed] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblArze] ADD CONSTRAINT [PK_tblArze] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblArze] ADD CONSTRAINT [FK_tblArze_tblCodhayeDaramadiElamAvarez] FOREIGN KEY ([fldShomareHesabCodeDaramadId]) REFERENCES [Drd].[tblShomareHesabCodeDaramad] ([fldId])
GO
ALTER TABLE [Weigh].[tblArze] ADD CONSTRAINT [FK_tblArze_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Weigh].[tblArze] ADD CONSTRAINT [FK_tblArze_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Weigh].[tblArze] ADD CONSTRAINT [FK_tblArze_tblWeighbridge] FOREIGN KEY ([fldBaskoolId]) REFERENCES [Weigh].[tblWeighbridge] ([fldId])
GO
