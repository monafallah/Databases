CREATE TABLE [Com].[tblEmployee_Detail]
(
[fldId] [int] NOT NULL,
[fldEmployeeId] [int] NOT NULL,
[fldFatherName] [nvarchar] (60) COLLATE Persian_100_CI_AI NULL,
[fldJensiyat] [bit] NULL,
[fldTarikhTavalod] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldMadrakId] [int] NULL,
[fldNezamVazifeId] [tinyint] NULL,
[fldTaaholId] [int] NULL,
[fldReshteId] [int] NULL,
[fldFileId] [int] NULL,
[fldSh_Shenasname] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldMahalTavalodId] [int] NULL,
[fldMahalSodoorId] [int] NULL,
[fldTarikhSodoor] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldAddress] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldCodePosti] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldMeliyat] [bit] NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblEmployee_Detail_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblEmployee_Detail_fldDate] DEFAULT (getdate()),
[fldTel] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_tblEmployee_Detail_fldTel] DEFAULT (''),
[fldMobile] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_tblEmployee_Detail_fldMobile] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblEmployee_Detail] ADD CONSTRAINT [PK_tblEmployee_Detail] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblEmployee_Detail] ADD CONSTRAINT [IX_tblEmployee_Detail] UNIQUE NONCLUSTERED ([fldEmployeeId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblEmployee_Detail] ADD CONSTRAINT [FK_tblEmployee_Detail_tblCity] FOREIGN KEY ([fldMahalTavalodId]) REFERENCES [Com].[tblCity] ([fldId])
GO
ALTER TABLE [Com].[tblEmployee_Detail] ADD CONSTRAINT [FK_tblEmployee_Detail_tblCity1] FOREIGN KEY ([fldMahalSodoorId]) REFERENCES [Com].[tblCity] ([fldId])
GO
ALTER TABLE [Com].[tblEmployee_Detail] ADD CONSTRAINT [FK_tblEmployee_Detail_tblEmployee] FOREIGN KEY ([fldEmployeeId]) REFERENCES [Com].[tblEmployee] ([fldId])
GO
ALTER TABLE [Com].[tblEmployee_Detail] ADD CONSTRAINT [FK_tblEmployee_Detail_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [Com].[tblEmployee_Detail] ADD CONSTRAINT [FK_tblEmployee_Detail_tblMadrakTahsili] FOREIGN KEY ([fldMadrakId]) REFERENCES [Com].[tblMadrakTahsili] ([fldId])
GO
ALTER TABLE [Com].[tblEmployee_Detail] ADD CONSTRAINT [FK_tblEmployee_Detail_tblNezamVazife] FOREIGN KEY ([fldNezamVazifeId]) REFERENCES [Com].[tblNezamVazife] ([fldId])
GO
ALTER TABLE [Com].[tblEmployee_Detail] ADD CONSTRAINT [FK_tblEmployee_Detail_tblReshteTahsili] FOREIGN KEY ([fldReshteId]) REFERENCES [Com].[tblReshteTahsili] ([fldId])
GO
ALTER TABLE [Com].[tblEmployee_Detail] ADD CONSTRAINT [FK_tblEmployee_Detail_tblStatusTaahol] FOREIGN KEY ([fldTaaholId]) REFERENCES [Com].[tblStatusTaahol] ([fldId])
GO
ALTER TABLE [Com].[tblEmployee_Detail] ADD CONSTRAINT [FK_tblEmployee_Detail_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
