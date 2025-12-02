CREATE TABLE [Com].[tblAshkhas]
(
[fldId] [int] NOT NULL,
[fldHaghighiId] [int] NULL,
[fldHoghoghiId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblAshkhas_fldDesc] DEFAULT (''),
[fldDate] [datetime] NULL CONSTRAINT [DF_tblAshkhas_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblAshkhas] ADD CONSTRAINT [CK_tblAshkhas] CHECK (([fldhaghighiId] IS NULL AND [fldhoghoghiId] IS NOT NULL OR [fldhaghighiId] IS NOT NULL AND [fldhoghoghiId] IS NULL))
GO
ALTER TABLE [Com].[tblAshkhas] ADD CONSTRAINT [PK_tblAshkhas] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblAshkhas] ADD CONSTRAINT [IX_tblAshkhas] UNIQUE NONCLUSTERED ([fldHaghighiId], [fldHoghoghiId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblAshkhas] ADD CONSTRAINT [FK_tblAshkhas_tblAshkhaseHoghoghi] FOREIGN KEY ([fldHoghoghiId]) REFERENCES [Com].[tblAshkhaseHoghoghi] ([fldId])
GO
ALTER TABLE [Com].[tblAshkhas] ADD CONSTRAINT [FK_tblAshkhas_tblEmployee] FOREIGN KEY ([fldHaghighiId]) REFERENCES [Com].[tblEmployee] ([fldId])
GO
ALTER TABLE [Com].[tblAshkhas] ADD CONSTRAINT [FK_tblAshkhas_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
