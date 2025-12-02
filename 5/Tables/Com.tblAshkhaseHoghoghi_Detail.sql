CREATE TABLE [Com].[tblAshkhaseHoghoghi_Detail]
(
[fldId] [int] NOT NULL,
[fldAshkhaseHoghoghiId] [int] NOT NULL,
[fldCodEghtesadi] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldAddress] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldCodePosti] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldShomareTelephone] [nvarchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblAshkhaseHoghoghi_Detail] ADD CONSTRAINT [CK_tblAshkhaseHoghoghi_Detail] CHECK ((len([fldCodEghtesadi])>=(2)))
GO
ALTER TABLE [Com].[tblAshkhaseHoghoghi_Detail] ADD CONSTRAINT [CK_tblAshkhaseHoghoghi_Detail_1] CHECK ((len([fldAddress])>=(2)))
GO
ALTER TABLE [Com].[tblAshkhaseHoghoghi_Detail] ADD CONSTRAINT [CK_tblAshkhaseHoghoghi_Detail_2] CHECK ((len([fldCodePosti])>=(2)))
GO
ALTER TABLE [Com].[tblAshkhaseHoghoghi_Detail] ADD CONSTRAINT [CK_tblAshkhaseHoghoghi_Detail_3] CHECK ((len([fldShomareTelephone])>=(2)))
GO
ALTER TABLE [Com].[tblAshkhaseHoghoghi_Detail] ADD CONSTRAINT [PK_tblJozyatAshkhaseHoghoghi] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblAshkhaseHoghoghi_Detail] ADD CONSTRAINT [IX_tblAshkhaseHoghoghi_Detail] UNIQUE NONCLUSTERED ([fldAshkhaseHoghoghiId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblAshkhaseHoghoghi_Detail] ADD CONSTRAINT [FK_tblAshkhaseHoghoghi_Detail_tblAshkhaseHoghoghi] FOREIGN KEY ([fldAshkhaseHoghoghiId]) REFERENCES [Com].[tblAshkhaseHoghoghi] ([fldId])
GO
ALTER TABLE [Com].[tblAshkhaseHoghoghi_Detail] ADD CONSTRAINT [FK_tblAshkhaseHoghoghi_Detail_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
