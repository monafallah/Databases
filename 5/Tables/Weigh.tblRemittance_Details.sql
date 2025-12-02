CREATE TABLE [Weigh].[tblRemittance_Details]
(
[fldId] [int] NOT NULL,
[fldRemittanceId] [int] NOT NULL,
[fldKalaId] [int] NOT NULL,
[fldMaxTon] [int] NOT NULL,
[fldControlLimit] [bit] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tbltblRemittance_Details_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tbltblRemittance_Details_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblRemittance_Details] ADD CONSTRAINT [PK_tbltblRemittance_Details] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblRemittance_Details] ADD CONSTRAINT [FK_tbltblRemittance_Details_tblKala] FOREIGN KEY ([fldKalaId]) REFERENCES [Com].[tblKala] ([fldId])
GO
ALTER TABLE [Weigh].[tblRemittance_Details] ADD CONSTRAINT [FK_tbltblRemittance_Details_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Weigh].[tblRemittance_Details] ADD CONSTRAINT [FK_tbltblRemittance_Details_tblRemittance_Header] FOREIGN KEY ([fldRemittanceId]) REFERENCES [Weigh].[tblRemittance_Header] ([fldId]) ON DELETE CASCADE
GO
ALTER TABLE [Weigh].[tblRemittance_Details] ADD CONSTRAINT [FK_tbltblRemittance_Details_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
