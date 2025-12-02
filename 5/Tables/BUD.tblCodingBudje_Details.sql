CREATE TABLE [BUD].[tblCodingBudje_Details]
(
[fldCodeingBudjeId] [int] NOT NULL,
[fldhierarchyidId] [sys].[hierarchyid] NOT NULL,
[fldLevelId] AS ([fldhierarchyidId].[GetLevel]()),
[fldStrhid] AS ([fldhierarchyidId].[ToString]()),
[fldHeaderId] [int] NULL,
[fldTitle] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldCode] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOldId] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldTarh_KhedmatTypeId] [tinyint] NULL,
[fldEtebarTypeId] [tinyint] NULL,
[fldMasrafTypeId] [tinyint] NULL,
[fldDate] [datetime] NOT NULL,
[fldIp] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldBudCode] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldCodeingLevelId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblCodingBudje_Details] ADD CONSTRAINT [PK_tblCodingBudje_Details] PRIMARY KEY CLUSTERED ([fldCodeingBudjeId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblCodingBudje_Details] ON [BUD].[tblCodingBudje_Details] ([fldHeaderId], [fldhierarchyidId]) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblCodingBudje_Details] ADD CONSTRAINT [FK_tblCodingBudje_Details_tblCodingBudje_Header] FOREIGN KEY ([fldHeaderId]) REFERENCES [BUD].[tblCodingBudje_Header] ([fldHedaerId])
GO
