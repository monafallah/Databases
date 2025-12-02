CREATE TABLE [Weigh].[tblTozin]
(
[fldId] [int] NOT NULL,
[fldWeighbridgeId] [int] NOT NULL,
[fldMaxW] [int] NOT NULL,
[fldPlaqueId] [int] NULL,
[fldHour] [datetime] NOT NULL,
[fldStartDate] [datetime] NOT NULL,
[fldEndDate] [datetime] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTozin_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblTozin] ADD CONSTRAINT [PK_tblTozin] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblTozin] ADD CONSTRAINT [FK_tblTozin_tblPlaque] FOREIGN KEY ([fldPlaqueId]) REFERENCES [Com].[tblPlaque] ([fldId])
GO
ALTER TABLE [Weigh].[tblTozin] ADD CONSTRAINT [FK_tblTozin_tblWeighbridge] FOREIGN KEY ([fldWeighbridgeId]) REFERENCES [Weigh].[tblWeighbridge] ([fldId])
GO
