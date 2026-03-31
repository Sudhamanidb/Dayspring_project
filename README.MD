# 🚀 Auto Fulfill — Docker Setup & Troubleshooting Guide

> This guide covers everything from scratch — first-time setup, daily usage, and all errors with fixes.

---

## Requirements

Before starting, make sure these are installed:

| Tool | How to Check |
|------|-------------|
| Docker | `docker --version` |
| Docker Compose | `docker-compose --version` |
| Git | `git --version` |

---

## 🏗️ First-Time Setup (From Scratch)

### Step 1 — Clone the project

```bash
git clone <repo-url>
cd auto_fulfill
```

---

### Step 2 — Fix GPG keys in Dockerfile

> ⚠️ **Why:** The base image has expired GPG keys. Without valid keys, `apt-get update` fails with exit code 100.

Add these two lines to your `Dockerfile` **before** `apt-get update`:

```dockerfile
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D870AB033FB45BD1
```

---

### Step 3 — Fix port conflicts

> ⚠️ **Why:** If another project uses ports `80` or `443`, Docker will fail with "port already allocated" error.

Edit `docker-compose.yml`:

```yaml
# Change from:
ports:
  - '443:443'
  - '80:80'

# Change to:
ports:
  - '4443:443'
  - '3000:80'
```

Access the app at: `https://localhost:4443`

---

### Step 4 — Fix log file permissions

> ⚠️ **Why:** The app runs as a different user inside Docker. Without this, it can't write log files and crashes on startup.

```bash
mkdir -p log
chmod -R 777 log/
```

---

### Step 5 — Add yourself to the Docker group *(first time only)*

```bash
sudo usermod -aG docker $USER
newgrp docker     # apply without logout
docker ps         # verify it works
```

> If `newgrp` doesn't work, fully log out and log back in, or reboot.

---

### Step 6 — Build the Docker image

```bash
LOCAL_USER_ID=$(id -u) docker-compose build
```

> **Why `LOCAL_USER_ID`:** Passes your user ID into Docker so files inside the container are owned by you — this prevents permission errors on logs and tmp files.

---

### Step 7 — Start all containers

**Terminal 1:**
```bash
docker-compose up
```

> ⏳ Wait until you see MySQL ready and Passenger online in the logs before continuing.

---

### Step 8 — Create database and run migrations

**Terminal 2 (new tab):**
```bash
# Create the database first
LOCAL_USER_ID=$(id -u) docker-compose run --rm --user "$(id -u):$(id -g)" web bundle exec rake db:create

# Then run migrations
LOCAL_USER_ID=$(id -u) docker-compose run --rm --user "$(id -u):$(id -g)" web bundle exec rake db:migrate
```

> **Why separate commands:** `db:create` creates the database, `db:migrate` creates the tables. Create must come first.

---

### Step 9 — Open in browser

```
https://localhost:4443
```

> 🔐 When you see a security warning, click **Advanced → Proceed to localhost**. This is expected — the app uses a self-signed SSL certificate locally.

---

## 📅 Daily Usage

```bash
# Start
docker-compose up -d

# Open browser → https://localhost:4443

# Stop when done
docker-compose down
```

---

## ⚡ Quick Command Reference

| Task | Command |
|------|---------|
| Start containers (background) | `docker-compose up -d` |
| Start containers (with logs) | `docker-compose up` |
| Stop containers | `docker-compose down` |
| Check container status | `docker-compose ps` |
| View web logs | `docker-compose logs web` |
| Follow web logs live | `docker-compose logs -f web` |
| Rails console | `docker-compose exec web bash -c "cd /home/app/autofulfill && bundle exec rails console"` |
| Run migrations | `LOCAL_USER_ID=$(id -u) docker-compose run --rm --user "$(id -u):$(id -g)" web bundle exec rake db:migrate` |
| Generate model/controller | `docker-compose run --rm --user "$(id -u):$(id -g)" web bundle exec rails g {model/migration/controller}` |
| Clean all Docker data | `docker system prune -f` |

---

## 🗃️ Connecting to Database (DBeaver / TablePlus)

Use these settings from your **host machine** — not the values from `database.yml`:

| Setting | Value |
|---------|-------|
| Host | `localhost` |
| Database | `autofulfill` |
| Username | `root` |
| Password | `autofulfill` |


> - `mysql` → works only **inside** Docker (Docker internal network DNS)
> - `localhost` → works from your **host machine** via the exposed port `3306`

---

## 🐛 Troubleshooting — Errors & Fixes

---

### ❌ Error 1: `apt-get update` fails — exit code 100

```
The command '/bin/sh -c apt-get update' returned a non-zero code: 100
W: GPG error: NO_PUBKEY D870AB033FB45BD1
```

**Cause:** Expired GPG keys for the Phusion Passenger apt repository.

**Fix:** Add to Dockerfile before `apt-get update`, then rebuild:
```dockerfile
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D870AB033FB45BD1
```
```bash
LOCAL_USER_ID=$(id -u) docker-compose build
```

---

### ❌ Error 2: Port already in use

```
Bind for 0.0.0.0:80 failed: port is already allocated
```

**Cause:** Another project is already using port 80 or 443.

**Fix:** Update `docker-compose.yml` and restart:
```yaml
ports:
  - '4443:443'
  - '3000:80'
```
```bash
docker-compose down
docker-compose up -d
```

---

### ❌ Error 3: Bundler gem not found

```
Could not find rails-7.0.3, mysql2-0.5.7 ... in any of the sources
Run `bundle install` to install missing gems.
```

**Cause:** Each new `docker-compose run` starts a fresh container — gems installed previously are not available.

**Fix:**
```bash
LOCAL_USER_ID=$(id -u) docker-compose run --rm web bash -c "bundle install && bundle exec rake db:migrate"
```

---

### ❌ Error 4: Permission denied on log files

```
Permission denied @ rb_sysopen - /home/app/autofulfill/log/development_resque.log
```

**Cause:** The `log/` directory is owned by root. The app user inside Docker cannot write to it.

**Fix** (run on your host machine, then restart):
```bash
mkdir -p log
chmod -R 777 log/
docker-compose down
docker-compose up -d
```

---

### ❌ Error 5: Can't connect to MySQL via socket

```
Mysql2::Error::ConnectionError: Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock'
```

**Cause:** `database.yml` has the wrong host, or the mysql container isn't running.

**Fix 1 — Check `database.yml`:**
```yaml
development:
  host: mysql   # must be "mysql", not "127.0.0.1" or "localhost"
```

**Fix 2 — Make sure containers are running:**
```bash
docker-compose up -d
docker-compose ps   # mysql should show "Up"
```

**Fix 3 — Run inside the already running container:**
```bash
docker-compose exec web bash -c "bundle exec rake db:create"
```

---

### ❌ Error 6: Unknown MySQL server host 'mysql'

```
Mysql2::Error::ConnectionError: Unknown MySQL server host 'mysql' (-2)
```

**Cause:** `docker-compose run` creates a new isolated container that may not be connected to the project network.

**Fix:** Use `docker-compose exec` instead:
```bash
docker-compose exec web bash -c "bundle exec rake db:create && bundle exec rake db:migrate"
```

> **`run` vs `exec`:**
> - `run` → creates a **new** container (isolated, may not reach mysql)
> - `exec` → runs inside the **already running** container (connected to mysql ✅)

---

### ❌ Error 7: Permission denied — Docker socket

```
permission denied while trying to connect to the docker API at unix:///var/run/docker.sock
```

**Cause:** Your user is not in the `docker` group.

**Fix:**
```bash
sudo usermod -aG docker $USER
newgrp docker     # apply in current session
docker ps         # verify it works now
```

> If `newgrp` doesn't work, log out and log back in, or run `sudo reboot`.

---

### ❌ Error 8: ffi gem version removed from RubyGems

```
Your bundle is locked to ffi (1.17.4-x86_64-linux) ... that version can no longer be found
```

**Cause:** The gem author removed that specific version from RubyGems.org.

**Fix:**
```bash
docker-compose run --rm web bash -c "chmod -R 777 /usr/local/rvm/gems/ruby-3.0.3 && bundle update ffi && bundle install"
```

---

### ❌ Error 9: RubyGems `Net` constant error

```
NameError: uninitialized constant Gem::Request::ConnectionPools::Net
```

**Cause:** The RubyGems version inside the container is incompatible with Ruby 3.0.3.

**Fix:** Add to Dockerfile and rebuild:
```dockerfile
RUN curl -sL https://rubygems.org/rubygems/rubygems-3.3.27.tgz | tar xz \
    && cd rubygems-3.3.27 && ruby setup.rb --no-document \
    && cd .. && rm -rf rubygems-3.3.27 \
    && gem install bundler:2.3.27
```

---

### ❌ Error 10: Test database sqlite3 error during db:create

```
Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock'
Couldn't create 'db/test.sqlite3' database.
```

**Cause:** The `test:` section in `database.yml` still uses old sqlite3 config.

**Fix — Update `config/database.yml`:**
```yaml
test:
  <<: *default
  host: mysql
  database: autofulfill_test
  username: root
  password: autofulfill
  encoding: utf8mb4
```

Or skip the test database entirely:
```bash
docker-compose exec web bash -c "bundle exec rake db:migrate RAILS_ENV=development"
```

---

## 📄 Final Dockerfile (Working Version)

```dockerfile
FROM phusion/passenger-ruby30:2.1.0
MAINTAINER Friedrich Paul <fred@dayspringlabs.com>

ARG LOCAL_USER_ID
ARG SKIP_BUNDLE

ENV APP_NAME autofulfill

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Fix expired GPG keys
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D870AB033FB45BD1

RUN apt-get update
RUN apt-get install -y imagemagick shared-mime-info

RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default
COPY $APP_NAME.conf /etc/nginx/sites-enabled/$APP_NAME.conf
COPY $APP_NAME-env.conf /etc/nginx/main.d/rails-env.conf

ENV APP_PATH /home/app/$APP_NAME
WORKDIR $APP_PATH
RUN mkdir -p $APP_PATH
RUN chown -R app:app $APP_PATH

RUN mkdir -p /root/.ssl
WORKDIR /root/.ssl
RUN apt-get update && apt-get install -y openssl && \
    openssl genrsa -des3 -passout pass:xxxx -out server.pass.key 2048 && \
    openssl rsa -passin pass:xxxx -in server.pass.key -out server.key && \
    rm server.pass.key && \
    openssl req -new -key server.key -out server.csr \
        -subj "/C=IN/ST=Karnataka/L=Bangalore/O=Dayspring/OU=Technology Department/CN=localhost" && \
    openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

EXPOSE 80
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR $APP_PATH
ENV ENC_KEY Ej8tZd0o6HcTTTewj7QYpHK7BOZmZxqgdMtr
ENV ENC_SALT Eoqi0Pp7CcGB7GdmfK0WEU7n7DlD0N1m

CMD ["/sbin/my_init"]
```

---

## Final docker-compose.yml

```yaml
version: '3.1'
services:
  web:
    build:
      context: .
      args:
        - LOCAL_USER_ID=${LOCAL_USER_ID}
    image: autofulfill
    env_file:
      - .env.docker
    volumes:
      - .:/home/app/autofulfill
      - tmp:/tmp
    ports:
      - '4443:443'
      - '3000:80'
  mysql:
    image: mysql:5.7
    ports:
      - '3306:3306'
    env_file:
      - .env.docker
    volumes:
      - autofulfill-data:/var/lib/mysql
  redis:
    image: redis:3.2.11
    command: redis-server
    ports:
      - '6379:6379'
  resque:
    build:
      context: .
      args:
        - LOCAL_USER_ID=${LOCAL_USER_ID}
    restart: always
    depends_on:
      - 'mysql'
      - 'redis'
    command: bash -c 'cd /home/app/autofulfill && bundle exec rake resque:work QUEUE=manual,verify,excel,new_order_notify,schedule,email_notify,mailers,adhoc'
    volumes:
      - .:/home/app/autofulfill
      - tmp:/tmp
    env_file:
      - .env.docker
volumes:
  autofulfill-data:
  tmp:
```

---

## 🧠 Key Concepts

| Concept | Explanation |
|---------|-------------|
| `LOCAL_USER_ID=$(id -u)` | Passes your Linux user ID into Docker so file permissions match yours |
| `docker-compose run` | Creates a **new** temporary container — gems not persisted between runs |
| `docker-compose exec` | Runs inside an **already running** container — use this for db tasks |
| `host: mysql` in database.yml | Works inside Docker (internal DNS) |
| `host: localhost` in DBeaver | Works from your host machine via exposed port 3306 |
| `chmod -R 777 log/` | Lets any user inside Docker write log files |
| No `sudo` with docker-compose | `sudo` changes your user ID and breaks `LOCAL_USER_ID` |

---

##  New Error, Always Check

1. `docker-compose ps` — are all containers running?
2. `docker-compose logs web` — what does the web container say?
3. Did you use `LOCAL_USER_ID=$(id -u)` when building?
4. Did you run `chmod -R 777 log/` on your host?

---
