CREATE TABLE [Com].[tblMaliyatArzesheAfzoode]
(
[fldId] [int] NOT NULL,
[fldFromDate] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldEndDate] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDarsadeAvarez] [decimal] (5, 2) NOT NULL,
[fldDarsadeMaliyat] [decimal] (5, 2) NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMaliyatArzesheAfzoode_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMaliyatArzesheAfzoode_fldDate] DEFAULT (getdate()),
[fldDarsadAmuzeshParvaresh] [decimal] (5, 2) NOT NULL CONSTRAINT [DF_tblMaliyatArzesheAfzoode_fldDarsadAmuzeshParvaresh] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblMaliyatArzesheAfzoode] ADD CONSTRAINT [CK_tblMaliyatArzesheAfzoode] CHECK ((len([fldFromDate])>=(2) AND len([fldEndDate])>=(2)))
GO
ALTER TABLE [Com].[tblMaliyatArzesheAfzoode] ADD CONSTRAINT [CK_tblMaliyatArzesheAfzoode_1] CHECK (([fldDarsadeAvarez]<=(100)))
GO
ALTER TABLE [Com].[tblMaliyatArzesheAfzoode] ADD CONSTRAINT [CK_tblMaliyatArzesheAfzoode_2] CHECK (([fldDarsadeMaliyat]<=(100)))
GO
ALTER TABLE [Com].[tblMaliyatArzesheAfzoode] ADD CONSTRAINT [CK_tblMaliyatArzesheAfzoode_3] CHECK (([com].[fn_CheckRengeDate]([fldFromDate],[fldEndDate])=(1)))
GO
ALTER TABLE [Com].[tblMaliyatArzesheAfzoode] ADD CONSTRAINT [PK_tblMaliyatArzesheAfzoode] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblMaliyatArzesheAfzoode] ADD CONSTRAINT [FK_tblMaliyatArzesheAfzoode_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
