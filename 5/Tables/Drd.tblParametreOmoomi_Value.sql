CREATE TABLE [Drd].[tblParametreOmoomi_Value]
(
[fldId] [int] NOT NULL,
[fldParametreOmoomiId] [int] NOT NULL,
[fldFromDate] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldEndDate] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldValue] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblParametreOmoomi_Value_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblParametreOmoomi_Value_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblParametreOmoomi_Value] ADD CONSTRAINT [CK_tblParametreOmoomi_Value] CHECK ((len([fldFromDate])>=(2)))
GO
ALTER TABLE [Drd].[tblParametreOmoomi_Value] ADD CONSTRAINT [PK_tblParametreOmoomi_Value] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblParametreOmoomi_Value] ADD CONSTRAINT [IX_tblParametreOmoomi_Value] UNIQUE NONCLUSTERED ([fldParametreOmoomiId], [fldFromDate], [fldEndDate]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblParametreOmoomi_Value] ADD CONSTRAINT [FK_tblParametreOmoomi_Value_tblParametreOmoomi] FOREIGN KEY ([fldParametreOmoomiId]) REFERENCES [Drd].[tblParametreOmoomi] ([fldId])
GO
ALTER TABLE [Drd].[tblParametreOmoomi_Value] ADD CONSTRAINT [FK_tblParametreOmoomi_Value_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
