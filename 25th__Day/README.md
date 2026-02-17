
# Day 25 : Multi Database + Solid Queue / async + Active Job 

* Main application data → stored in **Primary Database**
* Background jobs → stored in **Queue Database**
* Active Job → framework that runs tasks in background
* Solid Queue → engine that processes jobs

Example :
When an order is created, a reminder email is scheduled after 7 days.

---

# 1. Configure Multiple Databases

### `config/database.yml`

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  primary:
    <<: *default
    database: ecommerce_development   #--> main app data (orders, users)

  queue:
    <<: *default
    database: ecommerce_development_queue   #-->  background jobs storage
```

* `primary` → used for normal application tables
* `queue` → used only for job tables
* Rails reads this file to know how many databases exist

---

# 2. Create Databases

```bash
rails db:create
```

* Creates both primary and queue databases
* Must run after editing `database.yml`

---

# 3. Install Solid Queue

```bash
rails solid_queue:install
```

created:

* queue configuration files
* job runner (`bin/jobs`)
* queue schema

---

# 4. Run Migrations

```bash
rails db:migrate
```

* Creates tables like `solid_queue_jobs`
* These tables store job status and execution data

If tables are missing:

```bash
rails db:schema:load:queue
```

---

# 5. Set Active Job Adapter

### `config/application.rb`

```ruby
config.active_job.queue_adapter = :solid_queue  # tells Rails to use Solid Queue
```

Points:

* Active Job needs a backend to run jobs
* Solid Queue becomes the processor

---

# 6. Connect Models to Database(example)

### `app/models/application_record.rb`

```ruby
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  connects_to database: {
    writing: :primary,   # insert/update queries
    reading: :primary    # select queries
  }
end
```

* Ensures models interact with correct DB
* If replicas exist, reading can be changed

---

# 7. Generate Background Job

```bash
rails generate job ReviewReminder
```

Creates job file inside `app/jobs`.

---

# 8. Write Job Logic

```ruby
class ReviewReminderJob < ApplicationJob
  queue_as :default   # job stored in default queue

  def perform(customer_id)
    customer = Customer.find(customer_id)  # fetch fresh data
    CustomerMailer.review_reminder(customer).deliver_now  # send email
  end
end
```

* Jobs receive IDs instead of objects
* Code inside `perform` runs in background

---

# 9. Trigger Job from Model

### `app/models/order.rb`

```ruby
class Order < ApplicationRecord
  belongs_to :product
  belongs_to :customer

  after_create_commit :schedule_review_reminder  # runs after order saved

  private

  def schedule_review_reminder
    ReviewReminderJob.set(wait: 7.days).perform_later(customer_id)
  end
end
```


* Callback runs only after database commit
* `perform_later` adds job to queue
* `wait: 7.days` schedules delay

---

# 10. Creating Orders (Controller)

### Method 1

```ruby
@order = Order.new(customer_id: 3, product_id: 5)
@order.save
```

### Method 2

```ruby
@order = Order.new
@order.customer_id = 3
@order.product_id = 5
@order.save
```

* Both create associations before saving
* After save → callback schedules job

---

# 11. Start Job Worker

```bash
bin/jobs
```

* Starts Solid Queue worker
* Worker continuously checks for pending jobs

---

# 12. Test in Rails Console

```ruby
ReviewReminderJob.perform_later(1)  # enqueue job
SolidQueue::Job.last         # check last job
```


* Confirms job creation
* Helps debugging

---

# 13. Mailer View

Create file:

```
app/views/customer_mailer/review_reminder.html.erb
```

* Mailer methods render matching view templates

---

# 14. Flow of Execution

1. User creates order
2. Order saved in primary database
3. Callback runs
4. Job added to queue database
5. Worker picks job
6. Job executes after delay
7. Email sent

---

# 15. Common errors which i got

### Error 1 : `solid_queue_jobs does not exist`

Run:

```bash
rails solid_queue:install
rails db:migrate
```

---

### Error: job not running

Run worker:

```bash
bin/jobs
```

---

## Async vs Solid_Queue (my understanding)

---



| Async                             | Solid Queue                               |
| --------------------------------- | ----------------------------------------- |
| Runs jobs inside the Rails server | Runs jobs using a separate worker process |
| No extra installation needed      | Requires installation and setup           |
| Jobs are stored in memory         | Jobs are stored in the database           |
| Jobs are lost if server stops     | Jobs are safe even if server restarts     |
| Good for small apps and learning  | Good for real projects and production     |
| Not suitable for heavy tasks      | Can handle heavy and important tasks      |
| No need to run extra command      | Must run `bin/jobs` to process jobs       |
---
