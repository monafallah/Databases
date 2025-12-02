CREATE TABLE [Com].[tblAnvaEstekhdam]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldNoeEstekhdamId] [int] NOT NULL,
[fldPatternNoeEstekhdamId] [int] NULL,
[fldIsPattern] [bit] NULL CONSTRAINT [DF_tblAnvaEstekhdam_fldIsPattern] DEFAULT ((0)),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblAnvaEstekhdam_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblAnvaEstekhdam_fldDate] DEFAULT (getdate()),
[fldTypeEstekhdamFormul] [tinyint] NULL,
[fldTypeEstekhdamBaz] [nvarchar] (450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldTypeEstekhdamSina] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblAnvaEstekhdam] ADD CONSTRAINT [CK_tblAnvaEstekhdam] CHECK ((len([fldTitle])>=(2)))
GO
ALTER TABLE [Com].[tblAnvaEstekhdam] ADD CONSTRAINT [PK_tblAnvaEstekhdam] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblAnvaEstekhdam] ADD CONSTRAINT [IX_tblAnvaEstekhdam] UNIQUE NONCLUSTERED ([fldTitle], [fldNoeEstekhdamId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblAnvaEstekhdam] ADD CONSTRAINT [FK_tblAnvaEstekhdam_tblAnvaEstekhdam] FOREIGN KEY ([fldPatternNoeEstekhdamId]) REFERENCES [Com].[tblAnvaEstekhdam] ([fldId])
GO
ALTER TABLE [Com].[tblAnvaEstekhdam] ADD CONSTRAINT [FK_tblAnvaEstekhdam_tblTypeEstekhdam] FOREIGN KEY ([fldNoeEstekhdamId]) REFERENCES [Com].[tblTypeEstekhdam] ([fldId])
GO
ALTER TABLE [Com].[tblAnvaEstekhdam] ADD CONSTRAINT [FK_tblAnvaEstekhdam_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
