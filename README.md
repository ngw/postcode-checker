# Postcode checker

Who am I?

Where am I going?

But mostly, is this postcode within my service area?

```bash
~/ bundle
...
~/ bundle exec rackup
```

- The integration test could be better, I never wrote a feature spec with Rack::Test and I decided to simplify
- There's an ["easy" way to validate postcodes](https://stackoverflow.com/questions/164979/regex-for-matching-uk-postcodes), I decided to ignore that and accept pretty much everything to let [postcodes.io](https://postcodes.io) do the job and handle error with an `ArgumentError`.
