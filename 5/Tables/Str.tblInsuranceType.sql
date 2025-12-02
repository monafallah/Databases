CREATE TABLE [Str].[tblInsuranceType]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblInsuranceType_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblInsuranceType_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL CONSTRAINT [DF_tblInsuranceType_fldOrganId] DEFAULT ((1)),
[fldIp] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblInsuranceType_fldIp] DEFAULT ('')
) ON [AnbarAmval] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Str].[tblInsuranceType] ADD CONSTRAINT [PK_tblInsuranceType] PRIMARY KEY CLUSTERED ([fldId]) ON [AnbarAmval]
GO
ALTER TABLE [Str].[tblInsuranceType] ADD CONSTRAINT [FK_tblInsuranceType_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Str].[tblInsuranceType] ADD CONSTRAINT [FK_tblInsuranceType_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
