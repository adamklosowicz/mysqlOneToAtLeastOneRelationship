DROP PROCEDURE IF EXISTS `delete_languages_from_country`;

DELIMITER $$

CREATE PROCEDURE `delete_languages_from_country`(
	IN operated_country_id INT,
	IN lang_names_to_delete TEXT,
	OUT is_success TINYINT
)
BEGIN
	DECLARE all_languages_count INT;
	DECLARE languages_selected_count INT;

	SET all_languages_count = (SELECT count(*) FROM language WHERE country_id=operated_country_id);
	SET languages_selected_count = get_char_occurrence(lang_names_to_delete, ';')+1;

	IF all_languages_count - languages_selected_count > 0 THEN
		SET is_success = validate_and_delete_languages_from_country(operated_country_id, lang_names_to_delete, languages_selected_count);
	ELSE
		SET is_success = -1;
	END IF;
	SELECT @is_success;
END$$
DELIMITER ;

