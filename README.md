# Crudify Customers 🧾

Crudify Customers is a **Ruby on Rails CRUD application** that allows users to **Create, Read, Update, and Delete customers**.  
This project is beginner-friendly and helps understand **Rails basics, MVC structure, and GitHub workflow**.

---

## 📌 What this project does

- Add a new customer
- View customer details
- Edit customer information
- Delete a customer
- Simple and clean UI
- Uses Rails MVC architecture

---

## 🛠 Technologies Used

- Ruby 3.x
- Ruby on Rails 7.x
- PostgreSQL (DB) + DBeaver (for management)
- Git & GitHub

---

## Git hub- commands

- git status
- git add .
- git commit -m "Initial commit"
- git remote add origin https://github.com/Sudhamanidb/crudify-customers.git
- git push origin master

---
## ⚙️ Project Setup (Step-by-Step) 

STEP 1: Create Rails project
rails new secondday

STEP 2: Go to project folder
cd secondday

STEP 3: Generate CRUD using scaffold
rails generate scaffold Customer name:string email:string

STEP 4: Create database
rails db:create

STEP 5: Run database migration
rails db:migrate

STEP 6: Start Rails server
rails server

STEP 7: Open in browser
http://localhost:3000/customers


