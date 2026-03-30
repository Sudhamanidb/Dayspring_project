
# Auto Fulfill â€” Complete Docker Setup & Troubleshooting Guide

---

## Requirements

Before starting, make sure these are installed:

| Tool | How to check |
|------|-------------|
| Docker | `docker --version` |
| Docker Compose | `docker-compose --version` |
| Git | `git --version` |

---

## First-Time Setup (From Scratch)

### Step 1 â€” Clone the project

```bash
git clone <repo-url>
cd auto_fulfill
```

---

### Step 2 â€” Fix GPG keys in Dockerfile

The base image (`phusion/passenger-ruby30`) has expired GPG keys.  
**Why:** Without valid keys, `apt-get update` fails with exit code 100.

Make sure your Dockerfile has these two lines **before** `apt-get update`:

```dockerfile
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D870AB033FB45BD1
```

---

### Step 3 â€” Fix port conflicts (if another project is running)

If another project already uses ports `80` or `443`, edit `docker-compose.yml`:

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

Then access the app at: `https://localhost:4443`

---

### Step 4 â€” Fix log file permissions (on your host machine)

```bash
mkdir -p log
chmod -R 777 log/
```

**Why:** The app runs as a different user inside Docker. Without this, it can't write to log files and crashes on startup.

---

### Step 5 â€” Add yourself to the Docker group (first time only)

```bash
sudo usermod -aG docker $USER
newgrp docker       # apply without logout
docker ps           # verify it works
```

If `newgrp` doesn't work, fully log out and log back in.

---

### Step 6 â€” Build the Docker image

```bash
LOCAL_USER_ID=$(id -u) docker-compose build
```

**Why `LOCAL_USER_ID`:** This passes your current user's ID into Docker so all files created inside the container are owned by you, preventing permission errors on logs, tmp files, etc.

---

### Step 7 â€” Start all containers

**Terminal 1:**
```bash
docker-compose up
```

Wait until you see MySQL ready and Passenger core online in the logs before moving to the next step.

---

### Step 8 â€” Create database and run migrations

**Terminal 2 (new tab):**
```bash
# Create the database first
LOCAL_USER_ID=$(id -u) docker-compose run --rm --user "$(id -u):$(id -g)" web bundle exec rake db:create

# Then run migrations
LOCAL_USER_ID=$(id -u) docker-compose run --rm --user "$(id -u):$(id -g)" web bundle exec rake db:migrate
```

**Why separate commands:** `db:create` creates the database, `db:migrate` creates all the tables. You must do create before migrate.

---

### Step 9 â€” Open the app in browser

```
https://localhost:4443
```

When you see a security warning, click **Advanced â†’ Proceed to localhost**.  
This is expected â€” the app uses a self-signed SSL certificate for local development.

---

## Daily Usage (After First Setup)

Every day you work on this project:

```bash
# Start containers
docker-compose up -d

# Open browser
# https://localhost:4443

# Stop containers when done
docker-compose down
```

---

## Common Commands

| Task | Command |
|------|---------|
| Start containers (background) | `docker-compose up -d` |
| Start containers (see logs) | `docker-compose up` |
| Stop containers | `docker-compose down` |
| Check container status | `docker-compose ps` |
| View web logs | `docker-compose logs web` |
| Follow web logs live | `docker-compose logs -f web` |
| Open Rails console | `docker-compose exec web bash -c "cd /home/app/autofulfill && bundle exec rails console"` |
| Run migrations | `LOCAL_USER_ID=$(id -u) docker-compose run --rm --user "$(id -u):$(id -g)" web bundle exec rake db:migrate` |
| Generate model/controller | `docker-compose run --rm --user "$(id -u):$(id -g)" web bundle exec rails g {model/migration/controller}` |

---

## Connecting to Database (DBeaver / TablePlus)

Use these settings â€” **not** the values from `database.yml`:

| Setting | Value |
|---------|-------|
| Host | `localhost` |
| Port | `3306` |
| Database | `autofulfill` |
| Username | `root` |
| Password | `autofulfill` |

> **Why `localhost` and not `mysql`:** The hostname `mysql` only works inside Docker containers. DBeaver runs on your host machine, so it connects via `localhost:3306` which is exposed by the `ports` mapping in `docker-compose.yml`.

---

## Troubleshooting â€” Errors & Fixes

---

### Error 1: `apt-get update` fails with exit code 100

**Error message:**
```
The command '/bin/sh -c apt-get update' returned a non-zero code: 100
W: GPG error: NO_PUBKEY D870AB033FB45BD1
```

**Cause:** Expired GPG keys for Phusion Passenger apt repository.

**Fix:** Add to Dockerfile before `apt-get update`:
```dockerfile
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D870AB033FB45BD1
```

Then rebuild:
```bash
LOCAL_USER_ID=$(id -u) docker-compose build
```

---

### Error 2: Port already in use

**Error message:**
```
Bind for 0.0.0.0:80 failed: port is already allocated
```

**Cause:** Another project or service is using port 80 or 443.

**Fix:** Change ports in `docker-compose.yml`:
```yaml
ports:
  - '4443:443'
  - '3000:80'
```

Then restart:
```bash
docker-compose down
docker-compose up -d
```

---

### Error 3: Bundler gem not found

**Error message:**
```
Could not find rails-7.0.3, mysql2-0.5.7 ... in any of the sources
Run `bundle install` to install missing gems.
```

**Cause:** Gems are installed in the Docker image but the container was started fresh or with a different user context.

**Fix:**
```bash
LOCAL_USER_ID=$(id -u) docker-compose run --rm web bash -c "bundle install && bundle exec rake db:migrate"
```

---

### Error 4: Permission denied on log files

**Error message:**
```
Permission denied @ rb_sysopen - /home/app/autofulfill/log/development_resque.log
```

**Cause:** The `log/` directory is owned by root. The app user inside Docker can't write to it.

**Fix (run on host machine):**
```bash
mkdir -p log
chmod -R 777 log/
```

Then restart:
```bash
docker-compose down
docker-compose up -d
```

---

### Error 5: Can't connect to MySQL server

**Error message:**
```
Mysql2::Error::ConnectionError: Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock'
```

**Cause:** `database.yml` has `host: 127.0.0.1` instead of `host: mysql`, OR the mysql container isn't running yet.

**Fix 1 â€” Check database.yml:**
```yaml
development:
  host: mysql   # must be "mysql", not "127.0.0.1" or "localhost"
```

**Fix 2 â€” Make sure all containers are running:**
```bash
docker-compose up -d
docker-compose ps   # check mysql shows "Up"
```

**Fix 3 â€” Run db:create inside the running container:**
```bash
docker-compose exec web bash -c "bundle exec rake db:create"
```

---

### Error 6: Unknown MySQL server host 'mysql'

**Error message:**
```
Mysql2::Error::ConnectionError: Unknown MySQL server host 'mysql' (-2)
```

**Cause:** The `docker-compose run` command created a new isolated container not connected to the project network.

**Fix:** Use `docker-compose exec` (not `run`) to connect to the already running web container which is on the same network as mysql:
```bash
docker-compose exec web bash -c "bundle exec rake db:create && bundle exec rake db:migrate"
```

---

### Error 7: Permission denied connecting to Docker socket

**Error message:**
```
permission denied while trying to connect to the docker API at unix:///var/run/docker.sock
```

**Cause:** Your user is not in the `docker` group.

**Fix:**
```bash
sudo usermod -aG docker $USER
newgrp docker       # apply in current session
docker ps           # verify
```

If `newgrp` doesn't work, fully log out and log back in, or reboot.

---

### Error 8: ffi gem version removed from RubyGems

**Error message:**
```
Your bundle is locked to ffi (1.17.4-x86_64-linux) ... that version can no longer be found
```

**Cause:** The gem author removed that specific version from RubyGems.org.

**Fix:**
```bash
docker-compose run --rm web bash -c "chmod -R 777 /usr/local/rvm/gems/ruby-3.0.3 && bundle update ffi && bundle install"
```

---

### Error 9: RubyGems `Net` constant error

**Error message:**
```
NameError: uninitialized constant Gem::Request::ConnectionPools::Net
```

**Cause:** The RubyGems version in the container is incompatible with Ruby 3.0.3. Bundler 2.2.x is too old.

**Fix:** Add to Dockerfile before `apt-get update` and rebuild:
```dockerfile
RUN curl -sL https://rubygems.org/rubygems/rubygems-3.3.27.tgz | tar xz \
    && cd rubygems-3.3.27 && ruby setup.rb --no-document \
    && cd .. && rm -rf rubygems-3.3.27 \
    && gem install bundler:2.3.27
```

---

### Error 10: Test database sqlite3 connection error during db:create

**Error message:**
```
Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)
Couldn't create 'db/test.sqlite3' database.
```

**Cause:** The `test:` section in `database.yml` still has the old sqlite3 config.

**Fix:** Update `config/database.yml`:
```yaml
test:
  <<: *default
  host: mysql
  database: autofulfill_test
  username: root
  password: autofulfill
  encoding: utf8mb4
```

Or skip test DB entirely by running only development:
```bash
docker-compose exec web bash -c "bundle exec rake db:migrate RAILS_ENV=development"
```

---

## Correct Dockerfile (Final Working Version)

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

## Correct docker-compose.yml (with port fix)

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

## Key Concepts to Remember

| Concept | Explanation |
|---------|-------------|
| `LOCAL_USER_ID=$(id -u)` | Passes your Linux user ID into Docker so file permissions match |
| `docker-compose run` | Creates a NEW temporary container |
| `docker-compose exec` | Runs inside an ALREADY RUNNING container |
| `host: mysql` in database.yml | Works inside Docker (uses Docker network DNS) |
| `host: localhost` in DBeaver | Works from your host machine (uses exposed port 3306) |
| Port `4443:443` | Maps container's 443 to your machine's 4443 |
| `chmod -R 777 log/` | Lets any user inside Docker write log files |
| No `sudo` with docker-compose | `sudo` changes your user ID and breaks `LOCAL_USER_ID` |
