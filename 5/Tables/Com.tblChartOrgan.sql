CREATE TABLE [Com].[tblChartOrgan]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPId] [int] NULL,
[fldOrganId] [int] NULL,
[fldNoeVahed] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblChartOrgan_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblChartOrgan_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblChartOrgan] ADD CONSTRAINT [CK_tblChartOrgan] CHECK ((len([fldTitle])>=(2)))
GO
ALTER TABLE [Com].[tblChartOrgan] ADD CONSTRAINT [PK_tblChartOrgan] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblChartOrgan] ADD CONSTRAINT [IX_tblChartOrgan] UNIQUE NONCLUSTERED ([fldOrganId], [fldTitle]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblChartOrgan] ADD CONSTRAINT [FK_tblChartOrgan_tblChartOrgan] FOREIGN KEY ([fldPId]) REFERENCES [Com].[tblChartOrgan] ([fldId])
GO
ALTER TABLE [Com].[tblChartOrgan] ADD CONSTRAINT [FK_tblChartOrgan_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Com].[tblChartOrgan] ADD CONSTRAINT [FK_tblChartOrgan_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
