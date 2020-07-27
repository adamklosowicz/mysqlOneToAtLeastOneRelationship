DROP FUNCTION IF EXISTS `decorate_string_list_complex`;

DELIMITER $$
CREATE FUNCTION `decorate_string_list_complex`(
	operated_string TEXT,
	delimiter_char CHAR(1),
	join_char CHAR(1),
	decorator_prefix CHAR(50),
	decorator_suffix CHAR(50)
) RETURNS TEXT
BEGIN
	DECLARE str_len INT;
	DECLARE sub_str_len INT;
	DECLARE decorated_string TEXT;
	DECLARE item VARCHAR(50);

	IF operated_string IS NULL OR operated_string = '' THEN
		RETURN '';
	END IF;

	for_each_item: LOOP
		SET str_len = CHAR_LENGTH(operated_string);
		SET item = SUBSTRING_INDEX(operated_string, delimiter_char, 1);
		IF decorated_string is NULL THEN
			SET decorated_string = CONCAT(decorator_prefix, item, decorator_suffix);
		ELSE
			SET decorated_string = CONCAT(decorated_string, join_char, decorator_prefix, item, decorator_suffix);
		END IF;
		SET sub_str_len = CHAR_LENGTH(item)+2;
		SET operated_string = MID(operated_string, sub_str_len, str_len);

		IF operated_string = '' THEN
			LEAVE for_each_item;
		END IF;
	END LOOP for_each_item;

	RETURN decorated_string;
END$$
DELIMITER ;
