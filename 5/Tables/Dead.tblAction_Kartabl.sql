CREATE TABLE [Dead].[tblAction_Kartabl]
(
[fldId] [int] NOT NULL,
[fldActionId] [int] NOT NULL,
[fldKartablId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblAction_Kartabl_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblAction_Kartabl_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblAction_Kartabl] ADD CONSTRAINT [PK_tblAction_Kartabl] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblAction_Kartabl] ADD CONSTRAINT [FK_tblAction_Kartabl_tblActions] FOREIGN KEY ([fldActionId]) REFERENCES [Dead].[tblActions] ([fldId])
GO
ALTER TABLE [Dead].[tblAction_Kartabl] ADD CONSTRAINT [FK_tblAction_Kartabl_tblKartabl] FOREIGN KEY ([fldKartablId]) REFERENCES [Dead].[tblKartabl] ([fldId])
GO
ALTER TABLE [Dead].[tblAction_Kartabl] ADD CONSTRAINT [FK_tblAction_Kartabl_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Dead].[tblAction_Kartabl] ADD CONSTRAINT [FK_tblAction_Kartabl_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
