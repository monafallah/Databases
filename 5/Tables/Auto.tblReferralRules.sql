CREATE TABLE [Auto].[tblReferralRules]
(
[fldId] [int] NOT NULL,
[fldPostErjaDahandeId] [int] NOT NULL,
[fldPostErjaGirandeId] [int] NULL,
[fldChartEjraeeGirandeId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblReferralRules_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblReferralRules_fldDesc] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblReferralRules] ADD CONSTRAINT [PK_tblReferralRules] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblReferralRules] ADD CONSTRAINT [FK_tblReferralRules_tblChartOrganEjraee] FOREIGN KEY ([fldChartEjraeeGirandeId]) REFERENCES [Com].[tblChartOrganEjraee] ([fldId])
GO
ALTER TABLE [Auto].[tblReferralRules] ADD CONSTRAINT [FK_tblReferralRules_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblReferralRules] ADD CONSTRAINT [FK_tblReferralRules_tblOrganizationalPostsEjraee] FOREIGN KEY ([fldPostErjaDahandeId]) REFERENCES [Com].[tblOrganizationalPostsEjraee] ([fldId])
GO
ALTER TABLE [Auto].[tblReferralRules] ADD CONSTRAINT [FK_tblReferralRules_tblOrganizationalPostsEjraee1] FOREIGN KEY ([fldPostErjaGirandeId]) REFERENCES [Com].[tblOrganizationalPostsEjraee] ([fldId])
GO
ALTER TABLE [Auto].[tblReferralRules] ADD CONSTRAINT [FK_tblReferralRules_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
