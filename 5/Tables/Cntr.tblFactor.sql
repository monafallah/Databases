CREATE TABLE [Cntr].[tblFactor]
(
[fldId] [int] NOT NULL,
[fldTarikh] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShomare] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShanaseMoadiyan] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldStatus] [bit] NOT NULL,
[fldSharhSanad] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFactor_fldDesc] DEFAULT (''),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFactor_fldDate] DEFAULT (getdate()),
[fldKasrBime] [decimal] (4, 2) NOT NULL,
[fldKasrHosnAnjamKar] [decimal] (4, 2) NOT NULL,
[fldDocumentHeaderId1] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblFactor] ADD CONSTRAINT [PK_tblFactor_1] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblFactor] ADD CONSTRAINT [FK_tblFactor_tblDocumentRecord_Header1] FOREIGN KEY ([fldDocumentHeaderId1]) REFERENCES [ACC].[tblDocumentRecord_Header1] ([fldId])
GO
ALTER TABLE [Cntr].[tblFactor] ADD CONSTRAINT [FK_tblFactor_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Cntr].[tblFactor] ADD CONSTRAINT [FK_tblFactor_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
