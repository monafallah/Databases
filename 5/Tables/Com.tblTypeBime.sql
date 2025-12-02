CREATE TABLE [Com].[tblTypeBime]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblTypeBime] ADD CONSTRAINT [PK_tblTypeBime] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblTypeBime] ADD CONSTRAINT [IX_tblTypeBime] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
