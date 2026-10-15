# Your Aigent

An aigent (AI agent) is an intelligent assistant powered by language models through OpenAI-compatible APIs. It can read and write files in its private workspace and perform scheduled tasks on your behalf.

## Configuration

### 1. Install dependencies

```bash
bundle install
```

### 2. Configure OpenAI API Connection

Copy the example env file:

```bash
cp .env.example .env
```

Modify the `OPENAI_API_BASE` and `OPENAI_API_KEY` as needed. If you're using a local AI server or any other provider that is compatible with OpenAI, you can set the OPENAI_API_BASE config option to point there instead (e.g., `http://localhost:8080/v1`).

### 3. Define the Aigent's Personality

Edit `IDENTITY.md` to define how your aigent should behave:

```markdown
You are a professional assistant named Alex. You respond in a friendly but concise manner.
```

This file sets the foundation for all the aigent's responses.

### 4. Configure Plugins

Aigency ships with two plugins: `workspace` and `sandbox`. The `workspace` plugin is enabled by default. It's recommended that you use one or the other, but not both.

The `workspace` plugin gives your aigent a directory where it can manage its own files.

The `sandbox` plugin provides a container where the aigent can not only manage files, but also run commands and scripts.

The `workspace` plugin is sufficient for many aigents. Switch to `sandbox` if you need your aigent to perform software development or other complex tasks.

### 5. Run setup

```bash
rake setup
```

## Usage

### Interactive Mode

Talk to your aigent using the `say` command:

```bash
bin/aigent say "How many fibers are intertwined in a shredded wheat biscuit?"
```

### Scheduling Tasks

Aigents use the `whenever` gem for scheduling. Example of a scheduled task:

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

### Using the Sandbox

If you enable the `sandbox` plugin, you'll need to start the container:

```bash
docker compose up -d
```

The sandbox app is initialized with an egress that only allows network access to domains that are whitelisted in `squid.conf`. See the `http_targets` and `ssh_targets` ACLs.

Manage the sandbox user's SSH configuration in `data/sandbox_ssh`.
