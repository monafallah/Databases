SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_GetNesbatWithPersonalInfoId](@FieldName varchar(100),@IdPersonal INT)
as
DECLARE @temp TABLE (Title NVARCHAR(50),Value TINYINT)
DECLARE @EmployeeId INT,@taaholId INT
SELECT @EmployeeId=fldEmployeeId FROM Prs.Prs_tblPersonalInfo WHERE fldId=@IdPersonal
SELECT @taaholId=fldTaaholId FROM Com.tblEmployee_Detail WHERE fldEmployeeId=@EmployeeId

if(@FieldName='Takafol')
begin
	IF(@taaholId in (1,5) )
	BEGIN
		INSERT INTO @temp
				( Title, Value )
		VALUES  ( N'تحت تکفل',3),(N'تحت تکفل(تامین اجتماعی)',5)
	END
	ELSE IF(@taaholId in (1,6))
	BEGIN
		INSERT INTO @temp
				( Title, Value )
		VALUES  (N'فرزند',1),( N'تحت تکفل',3),(N'تحت تکفل(تامین اجتماعی)',5)
	END
	ELSE IF(@taaholId=3)
	BEGIN
		INSERT INTO @temp
				( Title, Value )
		VALUES  (N'همسر',2),( N'تحت تکفل',3),(N'تحت تکفل(تامین اجتماعی)',5)
	END
	ELSE IF(@taaholId in (4,6))
	BEGIN
		INSERT INTO @temp
				( Title, Value )
		VALUES   (N'فرزند',1), (N'همسر',2),(  N'تحت تکفل(تبعی3)',3),( N'مازاد(تبعی2)',4),(N'تحت تکفل(تامین اجتماعی)',5)
	END
end

else if(@FieldName='Nesbat')
begin
	IF(@taaholId in (1,5) )
	BEGIN
		INSERT INTO @temp
				( Title, Value )
		VALUES  ( N'پدر',3),(N'مادر',4)
	END
	ELSE IF(@taaholId in (2,6))
	BEGIN
		INSERT INTO @temp
				( Title, Value )
		VALUES  (N'فرزند',1),( N'پدر',3),(N'مادر',4)
	END
	ELSE IF(@taaholId=3)
	BEGIN
		INSERT INTO @temp
				( Title, Value )
		VALUES  (N'همسر',2),( N'پدر',3),(N'مادر',4)
	END
	ELSE IF(@taaholId in (4,6))
	BEGIN
		INSERT INTO @temp
				( Title, Value )
		VALUES   (N'فرزند',1), (N'همسر',2),( N'پدر',3),(N'مادر',4)
	END
end

SELECT * FROM @temp
GO
