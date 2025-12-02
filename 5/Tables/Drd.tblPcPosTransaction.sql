CREATE TABLE [Drd].[tblPcPosTransaction]
(
[fldId] [int] NOT NULL,
[fldFishId] [int] NOT NULL,
[fldPrice] [bigint] NOT NULL,
[fldStatus] [bit] NOT NULL,
[fldTrackingCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShGhabz] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Table_1_fldShGhabz1] DEFAULT (''),
[fldShPardakht] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Table_1_fldShPardakht1] DEFAULT (''),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPcPosTransaction_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPcPosTransaction_fldDate] DEFAULT (getdate()),
[fldTerminalCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldSerialNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldCardNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikh] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPcPosTransaction] ADD CONSTRAINT [PK_tblPcPosTransaction] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblPcPosTransaction] ADD CONSTRAINT [FK_tblPcPosTransaction_tblSodoorFish] FOREIGN KEY ([fldFishId]) REFERENCES [Drd].[tblSodoorFish] ([fldId])
GO
ALTER TABLE [Drd].[tblPcPosTransaction] ADD CONSTRAINT [FK_tblPcPosTransaction_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
