SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblComboBoxValueSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@value1 nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	set  @Value1=com.fn_TextNormalize(@Value1)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT TOP (@h) Drd.tblComboBoxValue.fldId, Drd.tblComboBoxValue.fldComboBoxId, Drd.tblComboBoxValue.fldTitle, Drd.tblComboBoxValue.fldValue, 
                  Drd.tblComboBoxValue.fldUserId, Drd.tblComboBoxValue.fldDesc, Drd.tblComboBoxValue.fldDate,isnull(Drd.tblComboBox.fldTitle,'') AS comboboxTitle
FROM     Drd.tblComboBoxValue INNER JOIN
                  Drd.tblComboBox ON Drd.tblComboBoxValue.fldComboBoxId = Drd.tblComboBox.fldId
WHERE  (Drd.tblComboBoxValue.fldId = @Value)

	if (@fieldname=N'fldComboBoxId')
	SELECT TOP (@h) Drd.tblComboBoxValue.fldId, Drd.tblComboBoxValue.fldComboBoxId, Drd.tblComboBoxValue.fldTitle, Drd.tblComboBoxValue.fldValue, 
                  Drd.tblComboBoxValue.fldUserId, Drd.tblComboBoxValue.fldDesc, Drd.tblComboBoxValue.fldDate,isnull(Drd.tblComboBox.fldTitle,'') AS comboboxTitle
FROM     Drd.tblComboBoxValue INNER JOIN
                  Drd.tblComboBox ON Drd.tblComboBoxValue.fldComboBoxId = Drd.tblComboBox.fldId
	WHERE  fldComboBoxId = @Value


	if (@fieldname=N'fldTitle')
	SELECT TOP (@h) Drd.tblComboBoxValue.fldId, Drd.tblComboBoxValue.fldComboBoxId, Drd.tblComboBoxValue.fldTitle, Drd.tblComboBoxValue.fldValue, 
                  Drd.tblComboBoxValue.fldUserId, Drd.tblComboBoxValue.fldDesc, Drd.tblComboBoxValue.fldDate,isnull(Drd.tblComboBox.fldTitle,'') AS comboboxTitle
    FROM     Drd.tblComboBoxValue INNER JOIN
                  Drd.tblComboBox ON Drd.tblComboBoxValue.fldComboBoxId = Drd.tblComboBox.fldId
	WHERE  Drd.tblComboBoxValue.fldTitle like @Value
	 

	if (@fieldname=N'comboboxTitle')
	SELECT TOP (@h) Drd.tblComboBoxValue.fldId, Drd.tblComboBoxValue.fldComboBoxId, Drd.tblComboBoxValue.fldTitle, Drd.tblComboBoxValue.fldValue, 
                  Drd.tblComboBoxValue.fldUserId, Drd.tblComboBoxValue.fldDesc, Drd.tblComboBoxValue.fldDate, isnull(Drd.tblComboBox.fldTitle,'') AS comboboxTitle
    FROM     Drd.tblComboBoxValue INNER JOIN
                  Drd.tblComboBox ON Drd.tblComboBoxValue.fldComboBoxId = Drd.tblComboBox.fldId
	WHERE  Drd.tblComboBox.fldTitle like @Value


		if (@fieldname=N'fldValue')
	SELECT TOP (@h) Drd.tblComboBoxValue.fldId, Drd.tblComboBoxValue.fldComboBoxId, Drd.tblComboBoxValue.fldTitle, Drd.tblComboBoxValue.fldValue, 
                  Drd.tblComboBoxValue.fldUserId, Drd.tblComboBoxValue.fldDesc, Drd.tblComboBoxValue.fldDate, isnull(Drd.tblComboBox.fldTitle,'') AS comboboxTitle
FROM     Drd.tblComboBoxValue INNER JOIN
                  Drd.tblComboBox ON Drd.tblComboBoxValue.fldComboBoxId = Drd.tblComboBox.fldId
	WHERE  Drd.tblComboBoxValue.fldValue like @Value


		if (@fieldname=N'fldDesc')
	SELECT TOP (@h) Drd.tblComboBoxValue.fldId, Drd.tblComboBoxValue.fldComboBoxId, Drd.tblComboBoxValue.fldTitle, Drd.tblComboBoxValue.fldValue, 
                  Drd.tblComboBoxValue.fldUserId, Drd.tblComboBoxValue.fldDesc, Drd.tblComboBoxValue.fldDate,isnull(Drd.tblComboBox.fldTitle,'') AS comboboxTitle
FROM     Drd.tblComboBoxValue INNER JOIN
                  Drd.tblComboBox ON Drd.tblComboBoxValue.fldComboBoxId = Drd.tblComboBox.fldId
	WHERE  Drd.tblComboBoxValue.fldDesc like @Value


		if (@fieldname=N'fldTitle_Value')
	SELECT TOP (@h) Drd.tblComboBoxValue.fldId, Drd.tblComboBoxValue.fldComboBoxId, Drd.tblComboBoxValue.fldTitle, Drd.tblComboBoxValue.fldValue, 
                  Drd.tblComboBoxValue.fldUserId, Drd.tblComboBoxValue.fldDesc, Drd.tblComboBoxValue.fldDate, isnull(Drd.tblComboBox.fldTitle,'') AS comboboxTitle
FROM     Drd.tblComboBoxValue INNER JOIN
                  Drd.tblComboBox ON Drd.tblComboBoxValue.fldComboBoxId = Drd.tblComboBox.fldId
	WHERE  Drd.tblComboBoxValue.fldTitle like @Value and Drd.tblComboBoxValue.fldValue like @value1



	if (@fieldname=N'')
		SELECT TOP (@h) Drd.tblComboBoxValue.fldId, Drd.tblComboBoxValue.fldComboBoxId, Drd.tblComboBoxValue.fldTitle, Drd.tblComboBoxValue.fldValue, 
                  Drd.tblComboBoxValue.fldUserId, Drd.tblComboBoxValue.fldDesc, Drd.tblComboBoxValue.fldDate, isnull(Drd.tblComboBox.fldTitle,'') AS comboboxTitle
FROM     Drd.tblComboBoxValue INNER JOIN
                  Drd.tblComboBox ON Drd.tblComboBoxValue.fldComboBoxId = Drd.tblComboBox.fldId                                                                                                                                                                                                                                                                                                                                                                                                                                                                  

	COMMIT
GO
