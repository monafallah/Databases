CREATE TABLE [Weigh].[tblWeighbridge]
(
[fldId] [int] NOT NULL,
[fldAshkhasHoghoghiId] [int] NOT NULL,
[fldName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAddress] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblWeighbridge_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblWeighbridge_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPassword] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblWeighbridge] ADD CONSTRAINT [PK_tblWeighbridge] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblWeighbridge] ADD CONSTRAINT [FK_tblWeighbridge_tblAshkhaseHoghoghi] FOREIGN KEY ([fldAshkhasHoghoghiId]) REFERENCES [Com].[tblAshkhaseHoghoghi] ([fldId])
GO
ALTER TABLE [Weigh].[tblWeighbridge] ADD CONSTRAINT [FK_tblWeighbridge_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
