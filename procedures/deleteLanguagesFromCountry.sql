DROP PROCEDURE IF EXISTS `delete_languages`;

DELIMITER $$

CREATE PROCEDURE `delete_languages_from_country`(
	IN operated_country_id INT,
	IN lang_names_to_delete TEXT,
	OUT is_success TINYINT
)
BEGIN
	DECLARE all_languages_count INT;
	DECLARE languages_selected_count INT;
	DECLARE languages_decorated TEXT;
	DECLARE verified_languages_count INT;
	DECLARE tmp_query TEXT;
	DECLARE tmp_where TEXT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SET is_success = 0;
	END;

	SET all_languages_count = (SELECT count(*) FROM language WHERE country_id=operated_country_id);
	SET languages_selected_count = get_char_occurance(lang_names_to_delete, ';')+1;

	IF all_languages_count - languages_selected_count < 1 THEN
		SET is_success = -1;
	ELSE
		SET languages_decorated = decorate_string_list(lang_names_to_delete, ';', ',', "'");

		SET tmp_where = CONCAT('WHERE country_id=', operated_country_id, ' AND `name` IN (', languages_decorated, ')');
		SET @tmp_query = CONCAT('SELECT count(*) INTO @verified_languages_count FROM language ', tmp_where);
		PREPARE select_stmt FROM @tmp_query;
		EXECUTE select_stmt;

		IF languages_selected_count != @verified_languages_count THEN
			DEALLOCATE PREPARE select_stmt;
			SET is_success = -2;
		ELSE
			DEALLOCATE PREPARE select_stmt;

			SET @tmp_query = CONCAT('DELETE FROM language ', tmp_where);
			SET SQL_SAFE_UPDATES = 0;
			PREPARE delete_stmt FROM @tmp_query;
			EXECUTE delete_stmt;
			DEALLOCATE PREPARE delete_stmt;
			SET SQL_SAFE_UPDATES = 1;
			SET is_success = 1;
		END IF;
	END IF;
	SELECT @is_success;
END$$
DELIMITER ;

