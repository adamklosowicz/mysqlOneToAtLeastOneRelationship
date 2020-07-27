DROP FUNCTION IF EXISTS `decorate_string_list`;

DELIMITER $$
CREATE FUNCTION `decorate_string_list`(
	operated_string TEXT,
	delimiter_char CHAR(1),
	join_char CHAR(1),
	decorator_wrapper CHAR(50)
) RETURNS TEXT
BEGIN
	RETURN decorate_string_list_complex(operated_string, delimiter_char, join_char, decorator_wrapper, decorator_wrapper);
END$$
DELIMITER ;
