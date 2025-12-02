CREATE TABLE [Dead].[tblNextAction]
(
[fldId] [int] NOT NULL,
[fldAction_NextId] [int] NOT NULL,
[fldKartablId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblNextAction_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblNextAction] ADD CONSTRAINT [PK_tblNextAction] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblNextAction] ADD CONSTRAINT [FK_tblNextAction_tblActions] FOREIGN KEY ([fldAction_NextId]) REFERENCES [Dead].[tblActions] ([fldId])
GO
ALTER TABLE [Dead].[tblNextAction] ADD CONSTRAINT [FK_tblNextAction_tblKartabl] FOREIGN KEY ([fldKartablId]) REFERENCES [Dead].[tblKartabl] ([fldId])
GO
ALTER TABLE [Dead].[tblNextAction] ADD CONSTRAINT [FK_tblNextAction_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Dead].[tblNextAction] ADD CONSTRAINT [FK_tblNextAction_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
