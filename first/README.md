## Day 1 – Ruby & Rails Basics

1️⃣ INSTALL RUBY
----------------
Step 1: Download and install Ruby from https://rubyinstaller.org/

Step 2: Verify installation:
   ruby -v

2️⃣ INSTALL RAILS
-----------------
Step 3: Install Rails gem (use CMD as Administrator):
   gem install rails
   
Step 4: Verify installation:
   rails -v

3️⃣ CREATE NEW RAILS PROJECT
----------------------------
Step 5: Create a folder for projects:

   cd C:\Users\Sudha
   
   mkdir rails_projects
   
   cd rails_projects
   
Step 6: Create a new Rails app:
    rails new my_first_app
   
   cd my_first_app

4️⃣ RUN RAILS SERVER
--------------------
Step 7: Start server:
   rails server
   
Step 8: Open browser and go to:
   http://localhost:3000
### Ruby

* Ruby is a **dynamically typed**, **open-source** programming language known for **simplicity** and **developer productivity**.
* Everything in Ruby is an **object**.
* Latest stable version: **Ruby 3.x**.
* Ruby generally follows **SOLID principles** (with limited emphasis on Interface Segregation due to Ruby’s dynamic nature).

### Rails

* Rails is a **web application framework built on Ruby**.
* It helps developers build applications faster by providing conventions and boilerplate code.
* Latest major version: **Rails 8.x**.

### Important Points

* Ruby version management is done using **RVM** or **RBENV** (used to switch Ruby versions).
* Install Rails using:

  ```bash
  gem install rails
  ```
* Ruby alone can create applications, but frameworks like Rails:

  * Reduce development time
  * Provide structure
  * Generate boilerplate code automatically

### Creating a Rails Project

Rails projects can be created in multiple ways:

1. `rails new project_name`
2. `rails new project_name --api` (API-only / two-tier architecture)
3. **Scaffold** (auto-creates MVC components)

### Commands to Remember

* `ruby --version`
* `rails --version`
* `gem install rails`
* `rails new ProjectName`
