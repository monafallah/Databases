CREATE TABLE [Drd].[tblMap_Header]
(
[fldId] [int] NOT NULL,
[fldSalMada] [smallint] NOT NULL,
[fldSalMaghsad] [smallint] NOT NULL,
[fldMarja] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMap_Header_fldDate] DEFAULT (getdate()),
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblMap_Header] ADD CONSTRAINT [PK_tblMap_Header] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblMap_Header] ADD CONSTRAINT [FK_tblMap_Header_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
