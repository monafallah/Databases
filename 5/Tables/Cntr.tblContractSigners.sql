CREATE TABLE [Cntr].[tblContractSigners]
(
[fldId] [int] NOT NULL,
[fldContractId] [int] NOT NULL,
[fldCompanyPostId] [smallint] NULL,
[fldEmpolyId] [int] NOT NULL,
[fldPostEjraeeId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblContractSigners_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblContractSigners_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblContractSigners] ADD CONSTRAINT [PK_tblContractSigners] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblContractSigners] ADD CONSTRAINT [FK_tblContractSigners_tblCompanyPost] FOREIGN KEY ([fldCompanyPostId]) REFERENCES [Com].[tblCompanyPost] ([fldId])
GO
ALTER TABLE [Cntr].[tblContractSigners] ADD CONSTRAINT [FK_tblContractSigners_tblContracts] FOREIGN KEY ([fldContractId]) REFERENCES [Cntr].[tblContracts] ([fldId])
GO
ALTER TABLE [Cntr].[tblContractSigners] ADD CONSTRAINT [FK_tblContractSigners_tblEmployee] FOREIGN KEY ([fldEmpolyId]) REFERENCES [Com].[tblEmployee] ([fldId])
GO
ALTER TABLE [Cntr].[tblContractSigners] ADD CONSTRAINT [FK_tblContractSigners_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Cntr].[tblContractSigners] ADD CONSTRAINT [FK_tblContractSigners_tblOrganizationalPostsEjraee] FOREIGN KEY ([fldPostEjraeeId]) REFERENCES [Com].[tblOrganizationalPostsEjraee] ([fldId])
GO
ALTER TABLE [Cntr].[tblContractSigners] ADD CONSTRAINT [FK_tblContractSigners_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
