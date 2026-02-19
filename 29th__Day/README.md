# Day 29 : Routes

## 1. Splitting Routes using draw

Keeps routes modular by moving them into separate files.

config/routes.rb

```ruby
draw :admin
```

Create file:

```
config/routes/admin.rb
```

---

## 2. Custom Route

```ruby
get '/payment_details', to: 'payments#payment_modes'
# URL → http://localhost:3000/payment_details
```

---

## 3. Root Route

```ruby
root 'products#index'
# URL → http://localhost:3000/
```

---

## 4. Redirect All Unknown Routes

```ruby
get '*path', to: redirect("/")
# Any invalid URL → http://localhost:3000/
```

---

## 5. Controller Generation

```bash
rails g controller payments
rails g controller admin/dashboard
rails g controller admin/reports
```

Creates controller, views, helper, and tests.

---

## 6. Aliasing Route

```ruby
get '/payment_details', to: 'payments#payment_modes', as: 'payment_info'
# URL → http://localhost:3000/payment_details
```

Helper:

```erb
payment_info_path
```

---

## 7. Constraints

```ruby
get '/products', to: 'products#index', constraints: { format: "json" }
# URL → http://localhost:3000/products.json
```

---

## 8. Match Route with Multiple Methods

```ruby
match '/login', to: 'products#index', via: [:get, :post]
# URL → http://localhost:3000/login
```

Inside controller:

```ruby
request.get?
request.post?
```

---

## 9. Member and Collection

```ruby
resources :products do
  member do
    get 'analytics'
    get 'post'
  end

  collection do
    get 'out_of_stock'
  end
end

# Member URL → http://localhost:3000/products/1/analytics
# Member URL → http://localhost:3000/products/1/post
# Collection URL → http://localhost:3000/products/out_of_stock
```

---

## 10. Namespace

Adds URL prefix and module.

```ruby
namespace :admin do
  resources :dashboard
end

# URL → http://localhost:3000/admin/dashboard
```

Controller:

```
app/controllers/admin/dashboard_controller.rb
```

---

## 11. Scope with Module

Uses module without URL prefix.

```ruby
scope module: :admin do
  resources :reports
end

# URL → http://localhost:3000/reports
```

Controller:

```
Admin::ReportsController
```

---

## 12. Nested Namespace

```ruby
namespace :product do
  resources :categories do
    collection do
      get 'review'
    end
  end
end

# URL → http://localhost:3000/product/categories/review
```

---

## 13. Scope with Path

```ruby
resources :customers do
  scope '/people' do
    resources :customers
  end

  collection do
    get 'blacklisted_customers'
  end
end

# URL → http://localhost:3000/customers/blacklisted_customers
# URL → http://localhost:3000/customers/people/customers
```

---

## 14. Explicit vs Shortcut Route

Explicit

```ruby
get '/details', to: 'payments#modes'
# URL → http://localhost:3000/details
```

Shortcut

```ruby
get 'payments/payment_modes'
# URL → http://localhost:3000/payments/payment_modes
```

---

## 15. HTTP Status Codes (Important for Developers)

Success

* 200 OK
* 201 Created
* 202 Accepted
* 204 No Content

Redirection

* 301 Moved Permanently
* 302 Found
* 304 Not Modified

Client Errors

* 400 Bad Request
* 401 Unauthorized
* 403 Forbidden
* 404 Not Found
* 405 Method Not Allowed
* 406 Not Acceptable
* 408 Request Timeout
* 409 Conflict
* 415 Unsupported Media Type
* 422 Unprocessable Entity (Rails validation errors)
* 429 Too Many Requests

Server Errors

* 500 Internal Server Error
* 501 Not Implemented
* 502 Bad Gateway
* 503 Service Unavailable
* 504 Gateway Timeout
---