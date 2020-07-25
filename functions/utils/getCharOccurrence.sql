DROP FUNCTION IF EXISTS `get_char_occurrence`;

DELIMITER $$
CREATE FUNCTION `get_char_occurrence`(
	operated_string TEXT,
	wanted_char VARCHAR(1)
) RETURNS INT
BEGIN
	RETURN LENGTH(operated_string) - LENGTH(REPLACE(operated_string, wanted_char, ''));
END$$
DELIMITER ;
