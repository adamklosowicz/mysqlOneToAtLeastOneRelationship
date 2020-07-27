DROP PROCEDURE IF EXISTS `add_languages_to_country`;

DELIMITER $$

CREATE PROCEDURE `add_languages_to_country`(
	IN country_id INT,
	IN language_name_list TEXT,
	OUT is_success TINYINT
)
BEGIN
	DECLARE is_in_transaction TINYINT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SET is_success = 0;
		IF is_in_transaction() != 1 THEN
			ROLLBACK;
		END IF;
	END;

	SET is_success = 1;

	SET @tmp_query = create_insert_languages_query(country_id, language_name_list);
	PREPARE stmt FROM @tmp_query;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END$$
DELIMITER ;
