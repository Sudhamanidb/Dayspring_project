📅 Day 3 – Rails Features & File Structure

On Day 3, I learned the core features of Ruby on Rails and understood the basic file & folder structure of a Rails application. This helped me understand how Rails works behind the scenes.

🚀 Main Features of Rails
✨ 1. Syntactic Sugar

Rails reduces repetitive coding by auto-generating code for us.

Automatically creates Model, View, and Controller (MVC) files

Saves time by avoiding manual setup

📌 Example:

rails generate model Customer


This command generates:

Model file

Migration file

Test files

⚙️ 2. Convention Over Configuration

Rails follows predefined naming rules, so we don’t need to configure everything manually.

📛 Naming Rules:
Component	Naming Rule
Model	Singular → Customer
Controller	Plural → CustomersController
Table	Plural → customers

✅ When conventions are followed, Rails automatically connects everything.

📁 Config Folder (config/)

This folder controls how the Rails application behaves.

Important Files:

database.yml → Database connection settings

routes.rb → Maps URLs to controller actions

application.rb → Global application configuration

environment.rb → Entry point of the app

environments/ → Environment-specific settings:

development

test

production

🗄️ DB Folder (db/)

This folder manages all database-related operations.

Important Files:

migrate/ → Database migration files (table creation & changes)

schema.rb → Auto-generated snapshot of current DB structure

seeds.rb → Used to insert sample or initial data

⚠️ Note: schema.rb should never be edited manually.

❌ Mistakes Made (Day 3)

❌ Confused singular vs plural naming for models and controllers

❌ Tried editing schema.rb manually (learned it is auto-generated)

✅ These mistakes helped me better understand Rails conventions and best practices.

📚 Key Takeaways

Rails follows MVC architecture

Naming conventions are very important

Configuration is mostly handled automatically

Database changes should be done via migrations only
