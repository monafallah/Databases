CREATE TABLE [Drd].[tblTypeFish]
(
[fldId] [int] NOT NULL,
[fldTypeFish] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTypeFish_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTypeFish_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblTypeFish] ADD CONSTRAINT [PK_tblTypeFish] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblTypeFish] ADD CONSTRAINT [IX_tblTypeFish] UNIQUE NONCLUSTERED ([fldTypeFish]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblTypeFish] ADD CONSTRAINT [FK_tblTypeFish_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
