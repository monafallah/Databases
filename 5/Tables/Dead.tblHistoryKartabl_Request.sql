CREATE TABLE [Dead].[tblHistoryKartabl_Request]
(
[fldId] [int] NOT NULL,
[fldKartablName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldActionName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldRequestId] [int] NOT NULL,
[fldKartablNextName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldEtmamCharkhe] [bit] NULL,
[fldUserIdInsert] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldIPInsert] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDateInsert] [datetime] NOT NULL CONSTRAINT [DF_Table_1_fldDate] DEFAULT (getdate()),
[fldUserIdDelete] [int] NOT NULL,
[fldDateDelete] [datetime] NOT NULL,
[fldIPDelete] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblHistoryKartabl_Request] ADD CONSTRAINT [PK_tblHistoryKartabl_Request] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblHistoryKartabl_Request] ADD CONSTRAINT [FK_tblHistoryKartabl_Request_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Dead].[tblHistoryKartabl_Request] ADD CONSTRAINT [FK_tblHistoryKartabl_Request_tblUser] FOREIGN KEY ([fldUserIdInsert]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Dead].[tblHistoryKartabl_Request] ADD CONSTRAINT [FK_tblHistoryKartabl_Request_tblUser1] FOREIGN KEY ([fldUserIdDelete]) REFERENCES [Com].[tblUser] ([fldId])
GO
