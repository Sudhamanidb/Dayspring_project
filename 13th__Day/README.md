

# Day13 - Rails Tasks and Notes

## 1. Adding a Column to a Table

To add a column to a table:

```bash
rails generate migration AddColumnColnameToTablename colname:datatype
rails generate migration AddColumnPhone_numberToCustomer phone_number:integer
rails db:migrate
```

* This will create a migration file in `db/migrate`, for example:
  `db/migrate/20260128044536_add_column_phone_to_customer.rb`

---

## 2. Installing Action Text

```bash
rails action_text:install
rails db:migrate
```

* Adds 4 tables to `schema.rb`:

  * `action_text_rich_texts`
  * `active_storage_attachments`
  * `active_storage_blobs`
  * `active_storage_variant_records`

* Creates migration files in `db/migrate`:

  * `20260128045359_create_active_storage_tables.active_storage.rb`
  * `20260128045360_create_action_text_tables.action_text.rb`

* Adds files/folders:

  * `app/assets/stylesheets/actiontext.css`
  * `app/views/active_storage/blobs/_blob.html.erb`
  * `app/views/layouts/action_text/contents/_content.html.erb`
  * `test/fixtures/action_text/rich_texts.yml`

* **Git commands:**

  * Check modified files: `git status`
  * Check changes in a specific file: `git diff <file_path>`

###  after installation

**Connections in Action Text tables**

* `active_storage_attachments` references `active_storage_blobs` via `blob_id`.
* `active_storage_variant_records` references `active_storage_blobs` via `blob_id`.

---

## 3. Array Operations in Ruby

```ruby
a1 = [1,2,3,4,5,6]
a2 = [1,3,5]

a3 = a1 & a2 # intersection => [1, 3, 5]
a4 = a1 | a2 # union => [1, 2, 3, 4, 5, 6]

print a3
puts
print a4
```

---

## 4. Debugging with `params.inspect`

* Used to inspect parameters from forms or requests for debugging.
* Stops execution and shows all permitted params in the error page.

```ruby
def create
  raise customer_params.inspect
  @customer = Customer.new(customer_params)
  respond_to do |format|
    if @customer.save
      format.html { redirect_to @customer, notice: "Customer was successfully created." }
      format.json { render :show, status: :created, location: @customer }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @customer.errors, status: :unprocessable_entity }
    end
  end
end
```

* Example output error:

```
#<ActionController::Parameters {"name"=>"jhon", "email"=>"1@gmail.com", "about_me"=>"<div>jhon is a english name</div>"} permitted: true>
```

---


