CREATE TABLE [Com].[tblDigitalArchiveTreeStructure]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPID] [int] NULL,
[fldModuleId] [int] NULL,
[fldAttachFile] [bit] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblDigitalArchiveTree_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblDigitalArchiveTree_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblDigitalArchiveTreeStructure] ADD CONSTRAINT [PK_tblDigitalArchiveTree] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblDigitalArchiveTreeStructure] ADD CONSTRAINT [IX_tblDigitalArchiveTreeStructure_1] UNIQUE NONCLUSTERED ([fldTitle], [fldModuleId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblDigitalArchiveTreeStructure] ADD CONSTRAINT [IX_tblDigitalArchiveTreeStructure] UNIQUE NONCLUSTERED ([fldTitle], [fldPID]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblDigitalArchiveTreeStructure] ADD CONSTRAINT [FK_tblDigitalArchiveTreeStructure_tblDigitalArchiveTreeStructure1] FOREIGN KEY ([fldPID]) REFERENCES [Com].[tblDigitalArchiveTreeStructure] ([fldId])
GO
ALTER TABLE [Com].[tblDigitalArchiveTreeStructure] ADD CONSTRAINT [FK_tblDigitalArchiveTreeStructure_tblModule] FOREIGN KEY ([fldModuleId]) REFERENCES [Com].[tblModule] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Com].[tblDigitalArchiveTreeStructure] ADD CONSTRAINT [FK_tblDigitalArchiveTreeStructure_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
