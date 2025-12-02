CREATE TABLE [ACC].[tblTreeCenterCost]
(
[fldId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldGroupCenterCoId] [int] NOT NULL,
[fldPID] [int] NULL,
[fldName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_SakhtarTree_CenterCost_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_SakhtarTree_CenterCost_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblTreeCenterCost] ADD CONSTRAINT [PK_SakhtarTree_CenterCost] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblTreeCenterCost] ADD CONSTRAINT [FK_SakhtarTree_CenterCost_GroupCenterCost] FOREIGN KEY ([fldGroupCenterCoId]) REFERENCES [ACC].[tblGroupCenterCost] ([fldId])
GO
ALTER TABLE [ACC].[tblTreeCenterCost] ADD CONSTRAINT [FK_SakhtarTree_CenterCost_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [ACC].[tblTreeCenterCost] ADD CONSTRAINT [FK_SakhtarTree_CenterCost_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [ACC].[tblTreeCenterCost] ADD CONSTRAINT [FK_SakhtarTreeCenterCost_SakhtarTreeCenterCost] FOREIGN KEY ([fldPID]) REFERENCES [ACC].[tblTreeCenterCost] ([fldId])
GO
