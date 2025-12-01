CREATE TABLE [dbo].[tblHeaderImage]
(
[fldId] [smallint] NOT NULL,
[fldTitle] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldImageUrl] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldStatus] [bit] NOT NULL,
[fldMatn1] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMatn2] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldInputId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblHeaderImage_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblHeaderImage] ADD CONSTRAINT [PK_tblHeaderImage] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblHeaderImage] ADD CONSTRAINT [FK_tblHeaderImage_tblInputInfo] FOREIGN KEY ([fldInputId]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
