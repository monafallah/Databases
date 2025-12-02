CREATE TABLE [Drd].[tblParametreOmoomi]
(
[fldId] [int] NOT NULL,
[fldNameParametreFa] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldNameParametreEn] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldNoeField] [tinyint] NOT NULL,
[fldFormulId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblParametreOmoomi_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblParametreOmoomi_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblParametreOmoomi] ADD CONSTRAINT [PK_tblParametreOmoomi] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblParametreOmoomi] ADD CONSTRAINT [IX_tblParametreOmoomi] UNIQUE NONCLUSTERED ([fldNameParametreEn]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblParametreOmoomi] ADD CONSTRAINT [FK_tblParametreOmoomi_tblComputationFormula] FOREIGN KEY ([fldFormulId]) REFERENCES [Com].[tblComputationFormula] ([fldId])
GO
ALTER TABLE [Drd].[tblParametreOmoomi] ADD CONSTRAINT [FK_tblParametreOmoomi_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
