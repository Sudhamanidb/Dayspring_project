# Day 16 – Action Mailbox 
---

## 1. Install Action Mailbox
```bash
rails action_mailbox:install
```

**Generated files:**

* `app/mailboxes/application_mailbox.rb`
* `db/migrate/20260202042002_create_action_mailbox_tables.action_mailbox.rb`

---

## 2. Database Migration
```bash
rails db:migrate
```

**Table created:**

* `action_mailbox_inbound_emails`

Used to store all incoming emails.

---
## 3. Production Configuration

In `config/environments/production.rb`:

```ruby
config.action_mailbox.ingress = :any_ingress_server
```

> Default ingress is `:relay`.

---
## 4. Application Mailbox

```ruby
class ApplicationMailbox < ActionMailbox::Base
  routing all: :support
end
```

All incoming emails are routed to `SupportMailbox`.

---
## 5. Generate Support Mailbox

```bash
rails generate mailbox support
```

**Generated files:**

* `app/mailboxes/support_mailbox.rb`
* `test/mailboxes/support_mailbox_test.rb`

---

## 6. Support Mailbox Logic

```ruby
class SupportMailbox < ApplicationMailbox
  def process
    # mail.decode  -> email body
    # mail.from    -> sender
    # mail.subject -> subject
  end
end
```

`process` method handles incoming email data.

---

## 7. View Incoming Emails (Development)

```bash
rails s
```
Open:

```
http://127.0.0.1:3000/rails/conductor/action_mailbox/inbound_emails
```

will get:
* View inbound emails
* Create emails using form or source
* Check message ID and status
---