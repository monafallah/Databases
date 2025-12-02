CREATE TABLE [Str].[tblInsuranceCompany]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFileId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblInsuranceCompany_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblInsuranceCompany_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL CONSTRAINT [DF_tblInsuranceCompany_fldOrganId] DEFAULT ((1)),
[fldIp] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblInsuranceCompany_fldIp] DEFAULT ('')
) ON [AnbarAmval] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Str].[tblInsuranceCompany] ADD CONSTRAINT [PK_tblInsuranceCompany] PRIMARY KEY CLUSTERED ([fldId]) ON [AnbarAmval]
GO
ALTER TABLE [Str].[tblInsuranceCompany] ADD CONSTRAINT [FK_tblInsuranceCompany_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Str].[tblInsuranceCompany] ADD CONSTRAINT [FK_tblInsuranceCompany_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
