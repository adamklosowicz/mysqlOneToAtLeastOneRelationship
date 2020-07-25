# One to many (at least one) relationship

Usage of the implemented MySQL mechanism

## Adding a new country
```sql
CALL CreateCountry(<countryName>, <phoneCode>, '<languageList>', @country_id);
```

#### Simple case for adding a new country with one language
```sql
CALL CreateCountry('USA', 1, 'English', @country_id);
```

#### Retrieving the ID of the new instance of the country created
```sql
select @country_id;
```

#### Case for adding a country with few languages (language names must be separated by a semicolon ';')
```sql
CALL CreateCountry('Canada', 1, 'English;French', @country_id);
CALL CreateCountry('Switzerland', 44, 'German;French;Italian;Romansh', @country_id);
```

## Adding languages to the existing instance of a country
```sql
CALL AddLanguagesForCountry(<existingCountryId>, <languageList>);
```

#### Case for adding languages set for the existing instance of the country
```sql
CALL AddLanguagesForCountry(5, 'Spanish;French');
```


