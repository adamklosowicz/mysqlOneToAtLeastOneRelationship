# One to many (at least one) relationship

The designed solution supports managing database relationship <i>one-to-many</i>, considering that element of the A entity must be assigned to at least one element from the B entity.
Designed example solves the problem of mananging countries with the languages that are used there (in each country people speak at least one language).

# Usage of the designed MySQL mechanism

## Adding a new country
```sql
CALL create_country(<countryName>, <phoneCode>, '<languageList>', @country_id);
```

#### Simple case for adding a new country with one language
```sql
CALL create_country('USA', 1, 'English', @country_id);
```

#### Retrieving the ID of the new instance of the country created
```sql
select @country_id;
```

#### Case for adding a country with few languages (language names must be separated by a semicolon ';')
```sql
CALL create_country('Canada', 1, 'English;French', @country_id);
CALL create_country('Switzerland', 44, 'German;French;Italian;Romansh', @country_id);
```

## Adding languages to the existing instance of a country
```sql
CALL add_languages_to_country(<existingCountryId>, <languageList>, @is_success);
```

#### Case for adding languages set for the existing instance of the country
```sql
CALL add_languages_to_country(5, 'Spanish;French', @is_success);
```

## Removing existing instance of a country
```sql
CALL delete_country(<existingCountryId>, @is_success);
```

## Removing languages from the instance of a country
```sql
CALL delete_language_from_country(<existingCountryId>, <languageName>, @is_success);
CALL delete_languages_from_country(<existingCountryId>, <languageList>, @is_success);
```

#### Case for removing one language from the existing instance of the country
```sql
CALL delete_language_from_country(5, 'English', @is_success);
```

#### Case for removing many languages from the existing instance of the country
```sql
CALL delete_language_from_country(8, 'French;Spanish', @is_success);
```

---

## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**
- Copyright 2020 © <a href="http://klosowi.cz" target="_blank">Adam Klosowicz</a>.
