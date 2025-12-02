CREATE TABLE [Drd].[tblPsp]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPsp_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPsp_fldDate] DEFAULT (getdate()),
[fldFileId] [int] NOT NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPsp] ADD CONSTRAINT [CK_tblPsp] CHECK ((len([fldTitle])>=(2)))
GO
ALTER TABLE [Drd].[tblPsp] ADD CONSTRAINT [PK_tblPsp] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblPsp] ADD CONSTRAINT [IX_tblPsp] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPsp] ADD CONSTRAINT [FK_tblPsp_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
