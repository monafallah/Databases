CREATE TABLE [ACC].[tblTree_CenterCost]
(
[fldId] [int] NOT NULL,
[fldCenterCoId] [int] NOT NULL,
[fldCostTreeId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTree_CenterCost_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTree_CenterCost_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblTree_CenterCost] ADD CONSTRAINT [PK_SakhtarTree_CenterCost_1] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblTree_CenterCost] ADD CONSTRAINT [FK_tblTree_CenterCost_tblCenterCost] FOREIGN KEY ([fldCenterCoId]) REFERENCES [ACC].[tblCenterCost] ([fldId])
GO
ALTER TABLE [ACC].[tblTree_CenterCost] ADD CONSTRAINT [FK_tblTree_CenterCost_tblTreeCenterCost] FOREIGN KEY ([fldCostTreeId]) REFERENCES [ACC].[tblTreeCenterCost] ([fldId])
GO
ALTER TABLE [ACC].[tblTree_CenterCost] ADD CONSTRAINT [FK_tblTree_CenterCost_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
