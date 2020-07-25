DROP FUNCTION IF EXISTS `validate_and_delete_languages_from_country`;

DELIMITER $$
CREATE FUNCTION `validate_and_delete_languages_from_country`(
	operated_country_id INT,
	operated_string TEXT,
	langs_count INT
) RETURNS TINYINT
BEGIN
	DECLARE str_len INT;
	DECLARE sub_str_len INT;
	DECLARE item VARCHAR(50);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		RETURN 0;
	END;

	DROP TEMPORARY TABLE IF EXISTS `tmp_list`;
	CREATE TEMPORARY TABLE tmp_list(tmp_item VARCHAR(50) NOT NULL);
	for_each_item: LOOP
		SET str_len = CHAR_LENGTH(operated_string);
		SET item = SUBSTRING_INDEX(operated_string, ';', 1);
		INSERT INTO tmp_list(tmp_item) VALUES (item);
		SET sub_str_len = CHAR_LENGTH(item)+2;
		SET operated_string = MID(operated_string, sub_str_len, str_len);

		IF operated_string = '' THEN
			LEAVE for_each_item;
		END IF;
	END LOOP for_each_item;

	IF langs_count != (
		SELECT count(*) FROM language 
		WHERE country_id=operated_country_id AND `name` IN (SELECT tmp_item FROM tmp_list) 
	) THEN
		RETURN -2;
	END IF;

	DELETE FROM language WHERE country_id=operated_country_id AND `name` IN (SELECT tmp_item FROM tmp_list);
	RETURN 1;
END$$
DELIMITER ;
