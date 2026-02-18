# Day 14: Active Storage

## 1. Installation

Active Storage is included in Rails 5.2+. If not installed:

```bash
rails active_storage:install
rails db:migrate
```

> Configure storage in `config/storage.yml` for local or cloud (AWS, GCP, etc.).

---

## 2. Attaching Files to Models

**Product model (single & multiple attachments, rich text):**

```ruby
class Product < ApplicationRecord
  has_one_attached :invoice
  has_many_attached :product_images
  has_rich_text :review
end
```

**Customer model (multiple attachments):**

```ruby
class Customer < ApplicationRecord
  has_many_attached :profile_photos
end
```

> Use **snake_case** for attachment names.

---

## 3. Strong Parameters

**Product controller:**

```ruby
def product_params
  params.require(:product).permit(:name, :description, :price, :stock, :is_active, :review, :invoice, product_images: [])
end
```

**Customer controller:**

```ruby
def customer_params
  params.require(:customer).permit(:name, :email, :phone_number, :about_me, profile_photos: [])
end
```

---

## 4. Forms in Views

**Product form:**

```erb
<%= form.rich_text_area :review, class: "form-control", placeholder: "Enter review" %>
<%= form.file_field :product_picture, class: "form-control", multiple: true %>
<%= form.file_field :invoice, class: "form-control" %>
```

**Customer form:**

```erb
<%= form.file_field :profile_photos, class: "form-control", multiple: true %>
```

---

## 5. Adding Columns via Migration

```bash
rails generate migration AddColumnDobToCustomer dob:date
rails db:migrate
```

> Adds a `dob` column to `customers`.

---

## 6. Displaying Attachments

```erb
<% if customer.profile_photos.attached? %>
  <% customer.profile_photos.each do |photo| %>
    <%= image_tag url_for(photo), class: "rounded" %>
  <% end %>
<% end %>

<% if product.invoice.attached? %>
  <%= link_to "Download Invoice", url_for(product.invoice) %>
<% end %>
```

---

## 7. Key Points

1. Use **snake_case** for attachment names.
2. **Action Text** requires Active Storage.
3. Configure cloud storage in `storage.yml`.
4. For multiple files: `has_many_attached` + `multiple: true`.
5. Always whitelist attachments in controllers.
6. Use `url_for` to render attachments in views.
