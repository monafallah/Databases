CREATE TABLE [Weigh].[tblLoadingPlace]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblLoadingPlace_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblLoadingPlace_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblLoadingPlace] ADD CONSTRAINT [PK_tblLoadingPlace] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblLoadingPlace] ADD CONSTRAINT [IX_tblLoadingPlace] UNIQUE NONCLUSTERED ([fldName]) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblLoadingPlace] ADD CONSTRAINT [FK_tblLoadingPlace_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
