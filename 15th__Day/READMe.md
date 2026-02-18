# Day 15 – Action Mailer

Action Mailer is used to **send emails** in Rails applications.
We **do not need to install** Action Mailer separately. It is **included by default** when a Rails application is created.

---

## Step 1: Generate Mailer

```bash
rails generate mailer CustomerMailer
```

This command creates the following files:

* `app/mailers/customer_mailer.rb`
* `app/views/customer_mailer/`
* `test/mailers/customer_mailer_test.rb`
* `test/mailers/previews/customer_mailer_preview.rb`

---

## Step 2: application.rb Changes

```ruby
require "action_mailer/railtie"
```

This file loads Action Mailer functionality. In most Rails apps, it is already included via `rails/all`.
A Railtie is the core component that allows a Ruby library or framework (like Action Mailer) to *plug in* to the Rails initialization process. 

---

## Step 3: Configure Email Delivery (development.rb)

Edit `config/environments/development.rb`:

```ruby
config.action_mailer.perform_deliveries = true
config.action_mailer.delivery_method = :letter_opener
```

* `letter_opener` is used to **mock email sending** in development
* Emails will open in browser instead of being sent
* In production, delivery method is usually **SMTP**

---

## Step 4: Customer Mailer Method

`app/mailers/customer_mailer.rb`

```ruby
class CustomerMailer < ApplicationMailer
  def welcome_email
    @customer = params[:customer]
    mail(to: @customer.email, subject: "Welcome !!")
  end
end
```

 `params` contains all the data passed while calling the mailer.

---

## Step 5: Mailer View

Create the file:

```
app/views/customer_mailer/welcome_email.html.erb
```

Add HTML content for the email.
---

## Step 6: Trigger Email from Controller

Send mail **after saving data**:

```ruby
CustomerMailer.with(customer: @customer).welcome_email.deliver
```

This line triggers the email.

---

## Step 7: Add Gems

In `Gemfile`:

```ruby
gem "letter_opener", group: :development
gem "letter_opener_web", group: :development
```

Run:

```bash
bundle install
```

---

## Step 8: Configure Routes

`config/routes.rb`

```ruby
if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
```

Visit in browser:

```
http://localhost:3000/letter_opener
```

---

## Product Mailer Example

Generate mailer:

```bash
rails generate mailer ProductMailer
```

Files created:

* `app/mailers/product_mailer.rb`
* `app/views/product_mailer/`
* `test/mailers/previews/product_mailer_preview.rb`
* `test/mailers/product_mailer_test.rb`

### Product Mailer Code

```ruby
class ProductMailer < ApplicationMailer
  def welcome_email
    @product = params[:product]
    mail(to: @product.email, subject: "Welcome to Rails Mailer Concept")
  end
end
```

---

## Calling Mailer from Controller

```ruby
def create
  @product = Product.new(product_params)

  if @product.save
    ProductMailer.with(product: @product).welcome_email.deliver
    redirect_to @product, notice: "Product was successfully created."
  else
    render :new, status: :unprocessable_entity
  end
end
```

---

## Mailer View for Product

Create:

```
app/views/product_mailer/welcome_email.html.erb
```

 Method name and view name must match:

```
welcome_email → welcome_email.html.erb
```

---

## Key Points 

* Action Mailer is built into Rails
* Do not delete `application.rb` or `boot.rb`
* `letter_opener` is used for development email preview
* Mailer method name must match view file name
* Emails should be triggered **after saving data**
* `params` contains all passed request data

---

