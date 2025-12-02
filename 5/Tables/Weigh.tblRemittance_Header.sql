CREATE TABLE [Weigh].[tblRemittance_Header]
(
[fldId] [int] NOT NULL,
[fldAshkhasiId] [int] NULL,
[fldStatus] [bit] NOT NULL,
[fldStartDate] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldEndDate] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblRemittance_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblRemittance_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTitle] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldEmployId] [int] NULL,
[fldChartOrganEjraeeId] [int] NULL,
[fldFileId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblRemittance_Header] ADD CONSTRAINT [PK_tblRemittance_Header] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblRemittance_Header] ADD CONSTRAINT [FK_tblRemittance_Header_tblAshkhas] FOREIGN KEY ([fldEmployId]) REFERENCES [Com].[tblAshkhas] ([fldId])
GO
ALTER TABLE [Weigh].[tblRemittance_Header] ADD CONSTRAINT [FK_tblRemittance_Header_tblChartOrganEjraee] FOREIGN KEY ([fldChartOrganEjraeeId]) REFERENCES [Com].[tblChartOrganEjraee] ([fldId])
GO
ALTER TABLE [Weigh].[tblRemittance_Header] ADD CONSTRAINT [FK_tblRemittance_Header_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [Weigh].[tblRemittance_Header] ADD CONSTRAINT [FK_tblRemittance_tblAshkhas] FOREIGN KEY ([fldAshkhasiId]) REFERENCES [Com].[tblAshkhas] ([fldId])
GO
ALTER TABLE [Weigh].[tblRemittance_Header] ADD CONSTRAINT [FK_tblRemittance_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Weigh].[tblRemittance_Header] ADD CONSTRAINT [FK_tblRemittance_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
