CREATE TABLE [Dead].[tblHistoryRequestAmanat]
(
[fldId] [int] NOT NULL,
[fldEmployeeName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShomareName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikh] [int] NULL,
[fldOrganId] [int] NOT NULL,
[fldUserIdInsert] [int] NOT NULL,
[fldIPInsert] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblHistoryRequestAmant_fldDesc] DEFAULT (''),
[fldDateInsert] [datetime] NOT NULL CONSTRAINT [DF_tblHistoryRequestAmant_fldDate] DEFAULT (getdate()),
[fldDateDelete] [date] NOT NULL,
[fldUserIdDelete] [int] NOT NULL,
[fldIPDelete] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldRequstId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblHistoryRequestAmanat] ADD CONSTRAINT [PK_tblHistoryRequestAmanat] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblHistoryRequestAmanat] ADD CONSTRAINT [FK_tblHistoryRequestAmant_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Dead].[tblHistoryRequestAmanat] ADD CONSTRAINT [FK_tblHistoryRequestAmant_tblUser] FOREIGN KEY ([fldUserIdDelete]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Dead].[tblHistoryRequestAmanat] ADD CONSTRAINT [FK_tblHistoryRequestAmant_tblUser1] FOREIGN KEY ([fldUserIdInsert]) REFERENCES [Com].[tblUser] ([fldId])
GO
