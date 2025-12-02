CREATE TABLE [Weigh].[tblNoeMasraf]
(
[fldId] [tinyint] NOT NULL,
[fldName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblNoeMasraf] ADD CONSTRAINT [PK_tblNoeMasraf] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
