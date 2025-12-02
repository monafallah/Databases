CREATE TABLE [Dead].[tblGhabrInfo]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFamily] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldNameFather] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldBDate] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDeathDate] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldObjectId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblGhabrInfo_fldDate] DEFAULT (getdate()),
[fldStatus] [tinyint] NOT NULL CONSTRAINT [DF__tblGhabrI__fldSt__7F10ABA8] DEFAULT ((1)),
[fldTabaghe] [tinyint] NOT NULL CONSTRAINT [DF__tblGhabrI__fldTa__24423057] DEFAULT ((1)),
[fldGheteId] [int] NULL,
[fldMeliCode] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__tblGhabrI__fldMe__0805E45C] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblGhabrInfo] ADD CONSTRAINT [PK_tblGhabrInfo] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblGhabrInfo] ADD CONSTRAINT [FK_tblGhabrInfo_tblGhete] FOREIGN KEY ([fldGheteId]) REFERENCES [Dead].[tblGhete] ([fldId])
GO
