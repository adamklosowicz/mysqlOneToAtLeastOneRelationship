DROP PROCEDURE IF EXISTS `AddLanguagesForCountry`;

DELIMITER $$

CREATE PROCEDURE `AddLanguagesForCountry`(
	IN country_id INT,
	IN language_name_list TEXT,
	OUT is_success TINYINT
)
BEGIN
	DECLARE is_in_transaction TINYINT;
	DECLARE str_len INT;
	DECLARE sub_str_len INT;
	DECLARE language_name VARCHAR(50);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SET is_success = 0;
		ROLLBACK;
	END;

	SET is_success = 1;

	SET is_in_transaction = is_in_transaction();
	IF is_in_transaction != 1 THEN
		START TRANSACTION;
	END IF;

	forEachLanguage: LOOP
		SET str_len = CHAR_LENGTH(language_name_list);
        	SET language_name = SUBSTRING_INDEX(language_name_list, ';', 1);
		INSERT INTO language(country_id, name) VALUES (country_id, language_name);
		SET sub_str_len = CHAR_LENGTH(language_name)+2;
		SET language_name_list = MID(language_name_list, sub_str_len, str_len);

		IF language_name_list = '' THEN
			LEAVE forEachLanguage;
		END IF;
	END LOOP forEachLanguage;

	IF is_in_transaction != 1 THEN
		COMMIT;
	END IF;

	SELECT @is_success;
END$$
DELIMITER ;
