CREATE TABLE [ACC].[tblCenterCost]
(
[fldId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldNameCenter] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_CenterCost_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_CenterCost_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCenterCost] ADD CONSTRAINT [PK_CenterCost] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCenterCost] ADD CONSTRAINT [IX_CenterCost] UNIQUE NONCLUSTERED ([fldOrganId], [fldNameCenter]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCenterCost] ADD CONSTRAINT [FK_CenterCost_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [ACC].[tblCenterCost] ADD CONSTRAINT [FK_CenterCost_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
