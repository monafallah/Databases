CREATE TABLE [Pay].[tblStatusMahalKhedmat]
(
[fldId] [tinyint] NOT NULL,
[fldTitle] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblStatusMahalKhedmat] ADD CONSTRAINT [PK_tblStatusMahalKhedmat] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
