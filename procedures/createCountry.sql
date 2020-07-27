DROP PROCEDURE IF EXISTS `create_country`;

DELIMITER $$

CREATE PROCEDURE `create_country`(
	IN country_name VARCHAR(150),
	IN country_code INT,
	IN language_name_list TEXT,
	OUT new_country_id INT
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SET new_country_id = NULL;
		ROLLBACK;
	END;

	START TRANSACTION;
	INSERT INTO country(name, code) VALUES (country_name, country_code);
	SET new_country_id = LAST_INSERT_ID();
	CALL add_languages_to_country(new_country_id, language_name_list, @languages_added_correctly);
	COMMIT;
	IF @languages_added_correctly = 0 THEN
		SET new_country_id = NULL;
	END IF;
END$$
DELIMITER ;

