
## Task 1. Generating a Controller

When we run:

```
rails generate controller admin
```

Rails creates files related to **controller and views**:
This comes under **Action Pack** (Action Controller + Action View).

* `app/controllers/admin_controller.rb` → controller file
* `app/views/admin/` → folder for admin views
* `app/helpers/admin_helper.rb` → helper file
* `test/controllers/admin_controller_test.rb` → controller test file

---

## Task 2. Generating a Model

When we run:

```
rails generate model admin
```

Rails creates files related to **database and business logic**:
This comes under **Active Record**.

* `app/models/admin.rb` → model file
* `db/migrate/XXXXXXXX_create_admins.rb` → migration file
* `test/models/admin_test.rb` → model test file
* `test/fixtures/admins.yml` → test data

---

## Task 3. Deleting `show.html.erb` Page

If we **delete the `show.html.erb` file** and access the show page, will get this error:

```
ActionController::UnknownFormat in CustomersController#show
CustomersController#show is missing a template for this request format.
```
## Bcz:
* `show` action exists in the controller
* But the `show.html.erb` view file is missing

---

## Task 4. Removing `def show` from Controller

If we **remove `def show` from the controller**,
there is **no error in Rails version 8**.

Bcz -->
* Rails 8 handles missing actions 
* If the route or action is not used, it does not crash the app

---
`rails db:migrate` is used to modify the database schema

---
## Task 5.Changes in routes.rb

```ruby
resources :products, skip: [:show]
resources :products, only: [:new, :destroy]
```
---
* `show` route is removed
* `/products/:id` is not available

## If we try to open show page

URL:

```
/products/1
```

## We will get this error

```
ActionController::RoutingError
No route matches [GET] "/products/1"
```
## Bcz -->
* Rails does not have a `show` route
* Request is stopped in `routes.rb`

---
## Rails Components Table

| Name              | Feature                      | Description                                                             | Version        |
| ----------------- | ---------------------------- | ----------------------------------------------------------------------- | -------------- |
| Active Model      | Model layer support          | Provides validations, callbacks, and naming without database connection | Rails 3.0 |
| Active Record     | Object Relational Mapping    | Connects models with database tables and handles database operations    | Rails 1.0 |
| Action View       | View rendering               | Displays HTML pages using templates like ERB                            | Rails 1.0 |
| Action Controller | Request and response control | Handles browser requests, responses, and connects models with views     | Rails 1.0 |
| Active Job        | Background jobs              | Manages background tasks and job queues                                 |  Rails 4.2 |
| Active Support    | Utility helpers              | Provides Ruby extensions and helper methods                             | Rails 1.0 |
| Action Mailer     | Email sending                | Used to send emails from the application                                | Rails 1.0 |
| Action Mailbox    | Incoming email handling      | Receives and processes incoming emails                                  | Rails 6.0 |
| Action Cable      | Real-time features           | Supports WebSocket connections like chat                                | Rails 5.0 |
| Active Storage    | File uploads                 | Manages file uploads like images and documents                          | Rails 5.2 |
| Action Text       | Rich text content            | Handles rich text editor and formatted content                          | Rails 6.0 |
| Action Dispatch   | Routing and middleware       | Routes requests and manages middleware                                  | Rails 1.0 |

---

### Class Notes :
---

### Database Configuration

* `database.yml` is used for **structured data** (SQL databases)

  * Example: MySQL, PostgreSQL, SQLite
* For **unstructured data**, we use external **gems**

  * Example: MongoDB, Redis

---

### Migration: Change and Rollback

* **up method**

  * Used to add or delete columns or tables
* **down method**

  * Used to rollback changes if the up method fails

---

### Controllers and SOLID Principle

* We can create any number of controllers based on requirements
* Follow SOLID principles:

  * Thin controller
  * Flat model
  * Every class should have only one responsibility

---

### Active Job (Queueing)

* Active Job is used for background processing
* Before Rails 5, there was **no built-in queueing mechanism**
* Rails 5 and above support job queues

### Important Notes

* Not all tables need a model
* Not all models need a table

