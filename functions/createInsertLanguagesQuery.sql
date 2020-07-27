DROP FUNCTION IF EXISTS `create_insert_languages_query`;

DELIMITER $$
CREATE FUNCTION `create_insert_languages_query`(
	country_id INT,
	languages_string TEXT
) RETURNS TEXT
BEGIN
	RETURN CONCAT(
		'INSERT INTO language(country_id, name) VALUES ', 
		decorate_string_list_complex(languages_string, ';', ',', CONCAT("(", country_id, ", '"), "')")
	);
END$$
DELIMITER ;
