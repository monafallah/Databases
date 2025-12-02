CREATE TABLE [Com].[tblAshkhaseHoghoghi]
(
[fldId] [int] NOT NULL,
[fldShenaseMelli] [nvarchar] (11) COLLATE Persian_100_CI_AI NOT NULL,
[fldName] [nvarchar] (250) COLLATE Persian_100_CI_AI NOT NULL,
[fldShomareSabt] [nvarchar] (20) COLLATE Persian_100_CI_AI NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblAshkhaseHoghoghi_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblAshkhaseHoghoghi_fldDate] DEFAULT (getdate()),
[fldTypeShakhs] [tinyint] NOT NULL CONSTRAINT [DF_tblAshkhaseHoghoghi_fldTypeShakhs] DEFAULT ((0)),
[fldSayer] [tinyint] NOT NULL CONSTRAINT [DF_tblAshkhaseHoghoghi_fldSayer] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblAshkhaseHoghoghi] ADD CONSTRAINT [CK_tblAshkhaseHoghoghi] CHECK (([fldTypeShakhs]=(0) AND ([fldShenaseMelli]='0' OR [com].[fn_CheckShenaseMeli]([fldShenaseMelli])=(1) AND [fldSayer]=(1)) OR [fldTypeShakhs]=(1) OR NOT [fldsayer]=(1)))
GO
ALTER TABLE [Com].[tblAshkhaseHoghoghi] ADD CONSTRAINT [CK_tblAshkhaseHoghoghi_1] CHECK ((([fldShenaseMelli]='0 ' AND len([fldShenaseMelli])=(1) OR len([fldShenaseMelli])='' OR len([fldShenaseMelli])>=(2)) AND len([fldName])>=(2)))
GO
ALTER TABLE [Com].[tblAshkhaseHoghoghi] ADD CONSTRAINT [CK_tblAshkhaseHoghoghi_2] CHECK (([fldShomareSabt] IS NULL OR len([fldShomareSabt])>=(2)))
GO
ALTER TABLE [Com].[tblAshkhaseHoghoghi] ADD CONSTRAINT [PK_tblAshkhaseHoghoghi] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblAshkhaseHoghoghi] ADD CONSTRAINT [IX_tblAshkhaseHoghoghi_1] UNIQUE NONCLUSTERED ([fldName]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblAshkhaseHoghoghi] ADD CONSTRAINT [FK_tblAshkhaseHoghoghi_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
