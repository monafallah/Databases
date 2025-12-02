CREATE TABLE [Drd].[tblPspModel]
(
[fldId] [int] NOT NULL,
[fldPspId] [int] NOT NULL,
[fldModel] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMultiHesab] [bit] NOT NULL CONSTRAINT [DF_tblPspModel_fldMultiHesab] DEFAULT ((0)),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPspModel_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPspModel_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPspModel] ADD CONSTRAINT [CK_tblPspModel] CHECK ((len([fldModel])>=(2)))
GO
ALTER TABLE [Drd].[tblPspModel] ADD CONSTRAINT [PK_tblPspModel] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblPspModel] ADD CONSTRAINT [IX_tblPspModel] UNIQUE NONCLUSTERED ([fldPspId], [fldModel]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPspModel] ADD CONSTRAINT [FK_tblPspModel_tblPsp] FOREIGN KEY ([fldPspId]) REFERENCES [Drd].[tblPsp] ([fldId])
GO
ALTER TABLE [Drd].[tblPspModel] ADD CONSTRAINT [FK_tblPspModel_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
