CREATE TABLE [Prs].[tblSavabegheSanavateKHedmat]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL CONSTRAINT [DF_Prs_tblSavabegheSanavateKHedmat_fldPersonalId] DEFAULT ((1)),
[fldNoeSabeghe] [bit] NOT NULL CONSTRAINT [DF_Prs_tblSavabegheSanavateKHedmat_fldNoeSabeghe] DEFAULT ((0)),
[fldAzTarikh] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTaTarikh] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblSavabegheSanavateKHedmat_fldTaTarikh] DEFAULT (getdate()),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblSavabegheSanavateKHedmat_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblSavabegheSanavateKHedmat_fldDate] DEFAULT (getdate())
) ON [Personeli]
GO
ALTER TABLE [Prs].[tblSavabegheSanavateKHedmat] ADD CONSTRAINT [PK_tblSavabegheSanavateKHedmat] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblSavabegheSanavateKHedmat] ADD CONSTRAINT [IX_Prs_tblSavabegheSanavateKHedmat] UNIQUE NONCLUSTERED ([fldAzTarikh], [fldTaTarikh], [fldNoeSabeghe], [fldPersonalId]) ON [PRIMARY]
GO
ALTER TABLE [Prs].[tblSavabegheSanavateKHedmat] ADD CONSTRAINT [FK_tblSavabegheSanavateKHedmat_Prs_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Prs].[Prs_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Prs].[tblSavabegheSanavateKHedmat] ADD CONSTRAINT [FK_tblSavabegheSanavateKHedmat_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
