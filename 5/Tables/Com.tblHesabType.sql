CREATE TABLE [Com].[tblHesabType]
(
[fldId] [tinyint] NOT NULL,
[fldTitle] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldType] [tinyint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblHesabType] ADD CONSTRAINT [PK_tblHesabType] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
