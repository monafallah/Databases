CREATE TABLE [Com].[tblEmployee]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (100) COLLATE Persian_100_CI_AI NOT NULL,
[fldFamily] [nvarchar] (100) COLLATE Persian_100_CI_AI NOT NULL,
[fldCodemeli] [nvarchar] (50) COLLATE Persian_100_CI_AI NULL,
[fldStatus] [bit] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblEmployee_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblEmployee_fldDate] DEFAULT (getdate()),
[fldTypeShakhs] [tinyint] NOT NULL CONSTRAINT [DF_tblEmployee_fldTypeShakhs] DEFAULT ((0)),
[fldCodeMoshakhase] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [Com].[DeleteTriggerEmployee] ON [Com].[tblEmployee]
FOR DELETE
AS
BEGIN

    SET NOCOUNT ON;

    IF EXISTS (
        SELECT *
        FROM deleted
        WHERE fldId in (select fldSourceId from ACC.tblCase where fldSourceId=deleted.fldId and fldCaseTypeId=1)
    )
    BEGIN
        ROLLBACK;
        THROW 50001, 'Cannot delete,conflict ACC.tblCase, fldSourceId column', 1;
    END
END;
GO
ALTER TABLE [Com].[tblEmployee] ADD CONSTRAINT [CK_tblEmployee] CHECK (([fldTypeShakhs]=(0) AND len([fldCodemeli])=(10) OR [fldTypeShakhs]=(1) OR [fldCodeMeli] IS NULL))
GO
ALTER TABLE [Com].[tblEmployee] ADD CONSTRAINT [CK_tblEmployee_1] CHECK (([fldTypeShakhs]=(0) AND [Com].[Fnc_CheckCodeMelli]([fldCodemeli])=(1) OR [fldTypeShakhs]=(1) OR [fldCodeMeli] IS NULL))
GO
ALTER TABLE [Com].[tblEmployee] ADD CONSTRAINT [CK_tblEmployee_2] CHECK ((len([fldName])>=(2)))
GO
ALTER TABLE [Com].[tblEmployee] ADD CONSTRAINT [CK_tblEmployee_3] CHECK ((len([fldFamily])>=(2)))
GO
ALTER TABLE [Com].[tblEmployee] ADD CONSTRAINT [PK_tblEmployee] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblEmployee] ADD CONSTRAINT [FK_tblEmployee_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
