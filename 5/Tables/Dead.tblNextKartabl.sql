CREATE TABLE [Dead].[tblNextKartabl]
(
[fldId] [int] NOT NULL,
[fldKartablNextId] [int] NOT NULL,
[fldActionId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblNextKartabl_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblNextKartabl_fldDate] DEFAULT (getdate()),
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblNextKartabl] ADD CONSTRAINT [PK_tblNextKartabl] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblNextKartabl] ADD CONSTRAINT [FK_tblNextKartabl_tblActions] FOREIGN KEY ([fldActionId]) REFERENCES [Dead].[tblActions] ([fldId])
GO
ALTER TABLE [Dead].[tblNextKartabl] ADD CONSTRAINT [FK_tblNextKartabl_tblKartabl] FOREIGN KEY ([fldKartablNextId]) REFERENCES [Dead].[tblKartabl] ([fldId])
GO
ALTER TABLE [Dead].[tblNextKartabl] ADD CONSTRAINT [FK_tblNextKartabl_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Dead].[tblNextKartabl] ADD CONSTRAINT [FK_tblNextKartabl_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
