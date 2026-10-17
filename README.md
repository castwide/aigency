# Aigency

A framework for creating AI agents with RubyLLM.

## Requierments

- Ruby 3.2+
- Docker 29+

(Note: Aigency is not tested on Windows. Some features are known to be Windows-incompatible.)

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

```bash
aigency enlist
cd aigent
bundle install
rake setup
cp .env.example .env
```

The bare minimum configuration you need to do is setting `OPENAI_API_BASE` and `OPENAI_API_KEY` in `.env`.

Test the aigent with the `say` command.

```bash
bin/aigent say "How many fibers are intertwined in a shredded wheat biscuit?"
```

See the aigent's README for more information (`README.md` in your aigent directory or `scaffold/enlist/README.md` in this codebase).
