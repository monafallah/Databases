CREATE TABLE [Com].[tblStatus]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblStatus] ADD CONSTRAINT [PK_tblStatus] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblStatus] ADD CONSTRAINT [IX_tblStatus] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
