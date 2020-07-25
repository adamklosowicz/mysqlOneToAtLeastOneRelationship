DROP PROCEDURE IF EXISTS `CreateCountry`;

DELIMITER $$

CREATE PROCEDURE `CreateCountry`(
	IN country_name VARCHAR(150),
	IN country_code INT,
	IN language_name VARCHAR(50),
	OUT new_country_id INT
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;

	START TRANSACTION;
	INSERT INTO country(name, code) VALUES (country_name, country_code);
	SET new_country_id = LAST_INSERT_ID();
	CALL AddLanguagesForCountry(new_country_id, language_name_list, @languages_added_correctly);
	COMMIT;
	IF @languages_added_correctly = 0 THEN
		SET new_country_id = NULL;
	END IF;
	SELECT @new_country_id;
END$$
DELIMITER ;

