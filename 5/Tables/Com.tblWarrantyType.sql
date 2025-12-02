CREATE TABLE [Com].[tblWarrantyType]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblWarrantyType_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblWarrantyType_fldDate] DEFAULT (getdate()),
[fldIp] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblWarrantyType] ADD CONSTRAINT [PK_tblWarrantyType] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblWarrantyType] ADD CONSTRAINT [IX_tblWarrantyType] UNIQUE NONCLUSTERED ([fldName]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblWarrantyType] ADD CONSTRAINT [FK_tblWarrantyType_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
