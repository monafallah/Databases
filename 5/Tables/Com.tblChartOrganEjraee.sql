CREATE TABLE [Com].[tblChartOrganEjraee]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPId] [int] NULL,
[fldOrganId] [int] NULL,
[fldNoeVahed] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblChartOrganEjraee_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblChartOrganEjraee_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblChartOrganEjraee] ADD CONSTRAINT [PK_tblChartOrganEjraee] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblChartOrganEjraee] ADD CONSTRAINT [FK_tblChartOrganEjraee_tblChartOrganEjraee1] FOREIGN KEY ([fldPId]) REFERENCES [Com].[tblChartOrganEjraee] ([fldId])
GO
ALTER TABLE [Com].[tblChartOrganEjraee] ADD CONSTRAINT [FK_tblChartOrganEjraee_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Com].[tblChartOrganEjraee] ADD CONSTRAINT [FK_tblChartOrganEjraee_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
