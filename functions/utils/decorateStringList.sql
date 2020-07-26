DROP FUNCTION IF EXISTS `decorate_string_list`;

DELIMITER $$
CREATE FUNCTION `decorate_string_list`(
	operated_string TEXT,
	delimiter_char CHAR(1),
	join_char CHAR(1),
	decorator_char CHAR(1)
) RETURNS TEXT
BEGIN
	DECLARE str_len INT;
	DECLARE sub_str_len INT;
	DECLARE merged_string TEXT;
	DECLARE item VARCHAR(50);
    
    SET merged_string = '';
	for_each_item: LOOP
		SET str_len = CHAR_LENGTH(operated_string);
		SET item = SUBSTRING_INDEX(operated_string, delimiter_char, 1);
		IF merged_string = '' THEN
			SET merged_string = CONCAT(decorator_char, item, decorator_char);
		ELSE
			SET merged_string = CONCAT(merged_string, join_char, decorator_char,item, decorator_char);
		END IF;
		SET sub_str_len = CHAR_LENGTH(item)+2;
		SET operated_string = MID(operated_string, sub_str_len, str_len);

		IF operated_string = '' THEN
			LEAVE for_each_item;
		END IF;
	END LOOP for_each_item;

	RETURN merged_string;
END$$
DELIMITER ;
