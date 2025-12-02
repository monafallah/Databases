CREATE TABLE [Drd].[tblProperties]
(
[fldId] [int] NOT NULL,
[fldEnName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFaName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblProperties_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblProperties_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblProperties] ADD CONSTRAINT [PK_tblProperties] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblProperties] ADD CONSTRAINT [IX_tblProperties] UNIQUE NONCLUSTERED ([fldEnName]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblProperties] ADD CONSTRAINT [FK_tblProperties_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
