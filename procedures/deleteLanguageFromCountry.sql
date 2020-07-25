DROP PROCEDURE IF EXISTS `delete_language_from_country`;

DELIMITER $$

CREATE PROCEDURE `delete_language_from_country`(
	IN operated_country_id INT,
	IN lang_name_to_delete VARCHAR(50),
	OUT is_success TINYINT
)
BEGIN
	DECLARE languages_count INT;
	BEGIN
		SET is_success = 0;
		ROLLBACK;
	END;

	SET languages_count = (SELECT count(*) FROM language WHERE country_id=operated_country_id);

	CASE
		WHEN languages_count = 0 THEN
			SET is_success = -2;
		WHEN languages_count = 1 THEN
			SET is_success = -1;
		ELSE
			START TRANSACTION;
			SET SQL_SAFE_UPDATES = 0;
			DELETE FROM language WHERE country_id=operated_country_id AND name=lang_name_to_delete;
			SET SQL_SAFE_UPDATES = 1;
			SET is_success = 1;
			COMMIT;
	END CASE;
	SELECT @is_success;
END$$
DELIMITER ;

