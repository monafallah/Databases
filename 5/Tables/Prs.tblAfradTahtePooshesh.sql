CREATE TABLE [Prs].[tblAfradTahtePooshesh]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFamily] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldBirthDate] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldStatus] [tinyint] NOT NULL,
[fldMashmul] [bit] NOT NULL,
[fldNesbat] [tinyint] NOT NULL,
[fldCodeMeli] [Com].[Codemeli] NOT NULL,
[fldSh_Shenasname] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFatherName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblFarzandan_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblFarzandan_fldDesc] DEFAULT (''),
[fldTarikhEzdevaj] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldNesbatShakhs] [tinyint] NULL,
[fldMashmoolPadash] [bit] NULL CONSTRAINT [DF_tblAfradTahtePooshesh_fldMashmoolPadash] DEFAULT ((0)),
[fldTarikhTalagh] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [Personeli]
GO
ALTER TABLE [Prs].[tblAfradTahtePooshesh] ADD CONSTRAINT [PK_tblFarzandan] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblAfradTahtePooshesh] ADD CONSTRAINT [IX_tblAfradTahtePooshesh] UNIQUE NONCLUSTERED ([fldCodeMeli], [fldPersonalId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblAfradTahtePooshesh] ADD CONSTRAINT [FK_tblAfradTahtePooshesh_Prs_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Prs].[Prs_tblPersonalInfo] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Prs].[tblAfradTahtePooshesh] ADD CONSTRAINT [FK_tblFarzandan_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
