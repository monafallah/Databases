CREATE TABLE [Drd].[tblParametrHesabdari]
(
[fldId] [int] NOT NULL,
[fldShomareHesabCodeDaramadId] [int] NOT NULL,
[fldCodeHesab] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldHesabId] [int] NULL,
[fldCompanyId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblParametrHesabdari_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblParametrHesabdari_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblParametrHesabdari] ADD CONSTRAINT [PK_tblParametrHesabdari] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblParametrHesabdari] ADD CONSTRAINT [FK_tblParametrHesabdari_tblCompany] FOREIGN KEY ([fldCompanyId]) REFERENCES [Drd].[tblCompany] ([fldId])
GO
ALTER TABLE [Drd].[tblParametrHesabdari] ADD CONSTRAINT [FK_tblParametrHesabdari_tblShomareHesabCodeDaramad] FOREIGN KEY ([fldShomareHesabCodeDaramadId]) REFERENCES [Drd].[tblShomareHesabCodeDaramad] ([fldId])
GO
ALTER TABLE [Drd].[tblParametrHesabdari] ADD CONSTRAINT [FK_tblParametrHesabdari_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
