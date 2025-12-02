CREATE TABLE [Dead].[tblKartabl_Request]
(
[fldId] [int] NOT NULL,
[fldKartablId] [int] NOT NULL,
[fldActionId] [int] NOT NULL,
[fldRequestId] [int] NOT NULL,
[fldKartablNextId] [int] NULL,
[fldEtmamCharkhe] [bit] NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblKartabl_Request_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblKartabl_Request] ADD CONSTRAINT [PK_tblKartabl_Request] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblKartabl_Request] ADD CONSTRAINT [FK_tblKartabl_Request_tblActions] FOREIGN KEY ([fldActionId]) REFERENCES [Dead].[tblActions] ([fldId])
GO
ALTER TABLE [Dead].[tblKartabl_Request] ADD CONSTRAINT [FK_tblKartabl_Request_tblKartabl] FOREIGN KEY ([fldKartablId]) REFERENCES [Dead].[tblKartabl] ([fldId])
GO
ALTER TABLE [Dead].[tblKartabl_Request] ADD CONSTRAINT [FK_tblKartabl_Request_tblKartabl1] FOREIGN KEY ([fldKartablNextId]) REFERENCES [Dead].[tblKartabl] ([fldId])
GO
ALTER TABLE [Dead].[tblKartabl_Request] ADD CONSTRAINT [FK_tblKartabl_Request_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Dead].[tblKartabl_Request] ADD CONSTRAINT [FK_tblKartabl_Request_tblRequestAmanat] FOREIGN KEY ([fldRequestId]) REFERENCES [Dead].[tblRequestAmanat] ([fldId])
GO
ALTER TABLE [Dead].[tblKartabl_Request] ADD CONSTRAINT [FK_tblKartabl_Request_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
