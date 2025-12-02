CREATE TABLE [Com].[tblMasuolin]
(
[fldId] [int] NOT NULL,
[fldTarikhEjra] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldModule_OrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMasuolin_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMasuolin_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblMasuolin] ADD CONSTRAINT [PK_tblMasuolin] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblMasuolin] ADD CONSTRAINT [IX_tblMasuolin] UNIQUE NONCLUSTERED ([fldTarikhEjra], [fldModule_OrganId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblMasuolin] ADD CONSTRAINT [FK_tblMasuolin_tblModule_Organ] FOREIGN KEY ([fldModule_OrganId]) REFERENCES [Com].[tblModule_Organ] ([fldId])
GO
ALTER TABLE [Com].[tblMasuolin] ADD CONSTRAINT [FK_tblMasuolin_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
