CREATE TABLE [Weigh].[tblParametrBaskoolValue]
(
[fldId] [int] NOT NULL,
[fldParametrBaskoolId] [int] NOT NULL,
[fldBaskoolId] [int] NOT NULL,
[fldValue] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblParametrBaskoolValue_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblParametrBaskoolValue_fldDate] DEFAULT (getdate()),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblParametrBaskoolValue] ADD CONSTRAINT [PK_tblParametrBaskoolValue] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblParametrBaskoolValue] ADD CONSTRAINT [FK_tblParametrBaskoolValue_tblParametrsBaskool] FOREIGN KEY ([fldParametrBaskoolId]) REFERENCES [Weigh].[tblParametrsBaskool] ([fldId])
GO
ALTER TABLE [Weigh].[tblParametrBaskoolValue] ADD CONSTRAINT [FK_tblParametrBaskoolValue_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Weigh].[tblParametrBaskoolValue] ADD CONSTRAINT [FK_tblParametrBaskoolValue_tblWeighbridge] FOREIGN KEY ([fldBaskoolId]) REFERENCES [Weigh].[tblWeighbridge] ([fldId])
GO
