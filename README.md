# api-bdd-tests
Cucumber Tests for API Endpoints

### How to run tests

1. Install latest Ruby and [Bundler](https://bundler.io/)
2. Run `bundle install`
3. Create your `.env` file, copy from `.env.sample`
4. Run your tests.
Example to run OddsFeed Scenarios agaist Public Endpoints:

`$ bundle exec cucumber --tags @external --tags @oddsfeed`

Run Platform Scenarios against Public Endpoints:

`$ bundle exec cucumber --tags @external --tags @platformapi`

4. Or read the `Rakefile` for the tasks:

```shell
$ rake external:oddsfeed

$ rake external:platform
```

.
