# github-score

A command-line utility to score and rank users based on their latest activity in Github.

### Requirements

- Ruby 3.1.0

### Installation

- Install Ruby dependencies via bundler

  ```bundle install```

### Running the script

github-score makes use of the gem Thor to provide a command line interface.

To view a list of commands you can run: `thor list`.

#### `users:github_score`

This command will accept any number of usernames, and each one's score will be
fetched and listed out from highest to lowest.

```
$ thor users:github_score shogie1 shogie2 shogie3

# will output
1. shogie3: 74
2. shogie1: 30
3. shogie2: 10
```

### Development

This application makes use of rspec for its test suite.

To run the tests: `bundle exec rspec`
