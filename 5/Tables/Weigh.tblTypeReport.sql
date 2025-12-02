CREATE TABLE [Weigh].[tblTypeReport]
(
[fldId] [tinyint] NOT NULL,
[fldType] [tinyint] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldBaskoolId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTypeReport_fldDate] DEFAULT (getdate()),
[fldUserId] [int] NOT NULL,
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblTypeReport] ADD CONSTRAINT [PK_tblTypeReport] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblTypeReport] ADD CONSTRAINT [FK_tblTypeReport_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Weigh].[tblTypeReport] ADD CONSTRAINT [FK_tblTypeReport_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Weigh].[tblTypeReport] ADD CONSTRAINT [FK_tblTypeReport_tblWeighbridge] FOREIGN KEY ([fldBaskoolId]) REFERENCES [Weigh].[tblWeighbridge] ([fldId])
GO
