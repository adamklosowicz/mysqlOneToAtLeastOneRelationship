DROP FUNCTION IF EXISTS `is_in_transaction`;

DELIMITER $$
CREATE FUNCTION `is_in_transaction`() RETURNS TINYINT
BEGIN
	DECLARE oldIsolation TEXT DEFAULT @@TX_ISOLATION;
	DECLARE EXIT HANDLER FOR 1568 BEGIN
		-- error 1568 will only be thrown within a transaction
		RETURN 1;
	END;
	-- will throw an error if we are within a transaction
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
	-- no error was thrown - we are not within a transaction
	SET TX_ISOLATION = oldIsolation;
	RETURN 0;
END$$
DELIMITER ;
