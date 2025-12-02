CREATE TABLE [chk].[tblCheckHayeVarede]
(
[fldId] [int] NOT NULL,
[fldIdShobe] [int] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldTarikhVosolCheck] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikhDaryaftCheck] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShenaseKamelCheck] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldBabat] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldNoeeCheck] [bit] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCheckHayeVarede_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCheckHayeVarede_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL,
[fldAshkhasId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [chk].[tblCheckHayeVarede] ADD CONSTRAINT [PK_tblCheckHayeVarede] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [chk].[tblCheckHayeVarede] ADD CONSTRAINT [FK_tblCheckHayeVarede_tblAshkhas] FOREIGN KEY ([fldAshkhasId]) REFERENCES [Com].[tblAshkhas] ([fldId])
GO
ALTER TABLE [chk].[tblCheckHayeVarede] ADD CONSTRAINT [FK_tblCheckHayeVarede_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [chk].[tblCheckHayeVarede] ADD CONSTRAINT [FK_tblCheckHayeVarede_tblSHobe] FOREIGN KEY ([fldIdShobe]) REFERENCES [Com].[tblSHobe] ([fldId])
GO
ALTER TABLE [chk].[tblCheckHayeVarede] ADD CONSTRAINT [FK_tblCheckHayeVarede_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
