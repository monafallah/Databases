CREATE TABLE [Com].[tblTypeEstekhdam]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblTypeEstekhdam] ADD CONSTRAINT [PK_tblTypeEstekhdam] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblTypeEstekhdam] ADD CONSTRAINT [IX_tblTypeEstekhdam] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
