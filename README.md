# Aigency

A framework for creating AI agents with RubyLLM.

## Installation

Install the gem from the command line:

```bash
gem install aigency
```

Or add it to your Gemfile:

```ruby
gem 'aigency'
```

## Usage

### Creating a New Aigent

The recommended way to create an aigent is to give it a dedicated system user.

```bash
useradd aigent_user
sudo su - aigent_user
```

Once you're logged in as the aigent user, create the aigent directory:

```bash
aigency enlist
cd aigent
bundle install
rake setup
```

The bare minimum configuration you need to do is setting `openai_api_base` and `openai_api_key` in `config/aigent.yml`.

Test the aigent with the `rake say` task.

```bash
rake say["How many fibers are intertwined in a shredded wheat biscuit?"]
```

See the aigent's README (scaffold/README.md in this codebase) for more information.
