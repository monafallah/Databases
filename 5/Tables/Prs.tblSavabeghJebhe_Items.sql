CREATE TABLE [Prs].[tblSavabeghJebhe_Items]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDarsad_Sal] [decimal] (5, 2) NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSavabeghJebhe_Items_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblSavabeghJebhe_Items_fldDate] DEFAULT (getdate())
) ON [Personeli] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Prs].[tblSavabeghJebhe_Items] ADD CONSTRAINT [PK_tblSavabeghJebhe_Items] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblSavabeghJebhe_Items] ADD CONSTRAINT [FK_tblSavabeghJebhe_Items_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
