RUBY ON RAILS – WINDOWS CHEAT SHEET
====================================

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
(Optional) Change port:
   rails server -p YOUR_PORT_NUMBER
Stop server:
   Ctrl + C
