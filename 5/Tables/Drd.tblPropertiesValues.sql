CREATE TABLE [Drd].[tblPropertiesValues]
(
[fldId] [int] NOT NULL,
[fldPropertiesId] [int] NOT NULL,
[fldElamAvarezId] [int] NOT NULL,
[fldValue] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPropertiesValues_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPropertiesValues_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPropertiesValues] ADD CONSTRAINT [PK_tblPropertiesValues] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPropertiesValues] ADD CONSTRAINT [FK_tblPropertiesValues_tblElamAvarez] FOREIGN KEY ([fldElamAvarezId]) REFERENCES [Drd].[tblElamAvarez] ([fldId])
GO
ALTER TABLE [Drd].[tblPropertiesValues] ADD CONSTRAINT [FK_tblPropertiesValues_tblProperties] FOREIGN KEY ([fldPropertiesId]) REFERENCES [Drd].[tblProperties] ([fldId])
GO
ALTER TABLE [Drd].[tblPropertiesValues] ADD CONSTRAINT [FK_tblPropertiesValues_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
