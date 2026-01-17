📅 Day 3 – Rails Features & File Structure

On Day 3, I learned the core features of Ruby on Rails and explored the basic file and folder structure of a Rails application.
This helped me understand how Rails works behind the scenes and why it is so developer-friendly.

🚀 Main Features of Ruby on Rails
✨ 1. Syntactic Sugar

Rails reduces repetitive and boilerplate code by auto-generating files and logic for us.

🔹 Automatically creates Model, View, and Controller (MVC) files
🔹 Saves development time
🔹 Reduces manual configuration

📌 Example Command

rails generate model Customer


📂 This command generates:

Model file (customer.rb)

Migration file

Test files

👉 This shows how Rails simplifies development with minimal effort.

⚙️ 2. Convention Over Configuration

Rails follows predefined naming conventions, so we don’t need to configure everything manually.

📛 Naming Rules
Component	Naming Convention
Model	Singular → Customer
Controller	Plural → CustomersController
Database Table	Plural → customers

✅ When these conventions are followed, Rails automatically links models, controllers, views, and database tables.

📁 Config Folder (config/)

This folder controls how the Rails application behaves.

Important Files

database.yml → Database connection settings

routes.rb → Maps URLs to controller actions

application.rb → Global application configuration

environment.rb → Entry point of the application

📂 Environment-specific settings (environments/)

development → Used during development

test → Used for testing

production → Used in live deployment

🗄️ DB Folder (db/)

This folder handles all database-related operations.

Important Files

migrate/ → Migration files (create & modify tables)

schema.rb → Auto-generated snapshot of current database structure

seeds.rb → Used to insert sample or initial data

⚠️ Important Note
schema.rb is auto-generated and should never be edited manually.

❌ Mistakes Made (Day 3)

❌ Confused singular vs plural naming for models and controllers
❌ Tried editing schema.rb manually

✅ These mistakes helped me understand Rails conventions and best practices better.
