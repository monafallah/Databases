CREATE TABLE [dbo].[tblFileBlockList]
(
[fldId] [smallint] NOT NULL,
[fldType] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblFileBlockList] ADD CONSTRAINT [PK_tblFileBlockList] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
