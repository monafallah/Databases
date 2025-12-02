CREATE TABLE [Dead].[tblKartabl]
(
[fldId] [int] NOT NULL,
[fldTitleKartabl] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblKartabl_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblKartabl_fldDate] DEFAULT (getdate()),
[fldOrderId] [int] NULL,
[fldHaveEtmam] [bit] NULL,
[fldHaveEbtal] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblKartabl] ADD CONSTRAINT [PK_tblKartabl] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblKartabl] ADD CONSTRAINT [FK_tblKartabl_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Dead].[tblKartabl] ADD CONSTRAINT [FK_tblKartabl_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
