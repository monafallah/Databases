CREATE TABLE [Dead].[tblVadiSalam]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldStateId] [int] NOT NULL,
[fldCityId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldAddress] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldLatitude] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldLongitude] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblVadiSalam_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblVadiSalam_fldDesc] DEFAULT (''),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblVadiSalam] ADD CONSTRAINT [PK_tblVadiSalam] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblVadiSalam] ADD CONSTRAINT [IX_tblVadiSalam] UNIQUE NONCLUSTERED ([fldName], [fldCityId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblVadiSalam] ADD CONSTRAINT [FK_tblVadiSalam_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Dead].[tblVadiSalam] ADD CONSTRAINT [FK_tblVadiSalam_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
