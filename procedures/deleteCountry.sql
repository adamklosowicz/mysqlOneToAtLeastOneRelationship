DROP PROCEDURE IF EXISTS `delete_country`;

DELIMITER $$

CREATE PROCEDURE `delete_country`(
	IN country_id_to_delete INT,
	OUT is_success TINYINT
)
BEGIN
	BEGIN
		SET is_success = 0;
		ROLLBACK;
	END;

	SET is_success = 1;

	START TRANSACTION;
	SET SQL_SAFE_UPDATES = 0;
	DELETE FROM language WHERE country_id=country_id_to_delete;
	DELETE FROM country WHERE id=country_id_to_delete;
	SET SQL_SAFE_UPDATES = 1;
	COMMIT;
END$$
DELIMITER ;

