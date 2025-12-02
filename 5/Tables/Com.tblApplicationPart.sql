CREATE TABLE [Com].[tblApplicationPart]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblApplicationPart_fldTitle] DEFAULT (''),
[fldPID] [int] NULL,
[fldUserID] [int] NOT NULL CONSTRAINT [DF_tblApplicationPart_fldUserID] DEFAULT ((1)),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblApplicationPart_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblApplicationPart_fldDate] DEFAULT (getdate()),
[fldModuleId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblApplicationPart] ADD CONSTRAINT [PK_tblApplicationPart] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblApplicationPart] ADD CONSTRAINT [FK_tblApplicationPart_tblApplicationPart] FOREIGN KEY ([fldPID]) REFERENCES [Com].[tblApplicationPart] ([fldId])
GO
ALTER TABLE [Com].[tblApplicationPart] ADD CONSTRAINT [FK_tblApplicationPart_tblModule] FOREIGN KEY ([fldModuleId]) REFERENCES [Com].[tblModule] ([fldId])
GO
ALTER TABLE [Com].[tblApplicationPart] ADD CONSTRAINT [FK_tblApplicationPart_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
