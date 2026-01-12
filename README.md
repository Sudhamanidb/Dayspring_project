RUBY ON RAILS – USEFUL COMMANDS (WINDOWS)

----------------------------------
1. CHECK INSTALLATION
----------------------------------

Check Ruby version:
ruby -v

Check Gem version:
gem -v

Check Rails version:
rails -v

Check Bundler version:
bundle -v


----------------------------------
2. MSYS2 / DEVKIT COMMANDS
----------------------------------

Enable MSYS2 environment:
ridk enable

Install development tools:
pacman -S --needed base-devel mingw-w64-ucrt-x86_64-toolchain

Install libyaml (important for Rails):
pacman -S libyaml pkgconf


----------------------------------
3. CREATE RAILS PROJECT
----------------------------------

Go to user folder:
cd C:\Users\Sudha

Create projects folder:
mkdir rails_projects
cd rails_projects

Create new Rails project:
rails new my_first_app

Enter project folder:
cd my_first_app


----------------------------------
4. RUN RAILS SERVER
----------------------------------

Start server:
rails server

Open browser:
http://localhost:3000

Stop server:
Ctrl + C

----------------------------------
5. BUNDLE / GEMS
----------------------------------

Install gems:
bundle install

Update gems:
bundle update

----------------------------------
6. DAILY WORKFLOW
----------------------------------

cd rails_projects
cd my_first_app
rails server


