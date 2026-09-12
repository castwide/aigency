# Your Aigent

An aigent (AI agent) is an intelligent assistant powered by language models through OpenAI-compatible APIs. It can read and write files in its private workspace and perform scheduled tasks on your behalf.

## Configuration

### Install dependencies

```bash
bundle install
```

### Initial setup

```bash
rake setup
```

### 1. Configure the Aigent

Configure the aigent's settings in `config/aigent.yml`.

#### OpenAI-Compatible Providers

If you're using a local AI server or any other provider that is compatible with OpenAI, you can set the OPENAI_API_BASE config option to point there instead (e.g., `http://localhost:8080/v1`).

### 2. Define the Aigent's Personality

Edit `IDENTITY.md` to define how your aigent should behave:

```markdown
You are a professional assistant named Alex. You respond in a friendly but concise manner.
```

This file sets the foundation for all the aigent's responses.

## Usage

### Interactive Mode

Talk to your aigent using the Rake task:

```bash
rake say["Tell me about project progress"]
```

### The Workspace

Your aigent has read/write access to everything in the `data/workspace` directory.

### Scheduling Tasks

The project includes the `whenever` gem for scheduling. Example of a scheduled task:

```ruby
# config/schedule.rb

# Every day at 9am, the aigent will run the prompt in the DAILY_TASKS.md file
every 1.day, at: '9am' do
  rake 'load[DAILY_TASKS.md]'
end
```

Add the scheduled tasks to your crontab:

```bash
bundle exec whenever --update-crontab
```

(Note: the `whenever` gem does not work on Windows.)

## Aigent Tools

You can give your aigent more functionality by installing additional tools. It ships with the `Workspace` tool, which gives it full read/write access to the `data/workspace` directory.
