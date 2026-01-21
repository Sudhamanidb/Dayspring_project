# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Product.create(name:"Sample Product", price:29.99, stock:100, active:true, description:"This is a sample product.")
# Product.create(name:"Another Product", price:49.99, stock:50, active:true, description:"This is another sample product.")
# Product.create([{name:"Third Product", price:19.99, stock:200, active:false, description:"This is the third sample product."},
#                 {name:"Fourth Product", price:99.99, stock:10, active:true, description:"This is the fourth sample product."}])
10.times do
Product.create(
    name: Faker::Commerce.product_name,
    description:"This is asample description for the product.",
    price: Faker::Commerce.price(range: 10..100),
    stock: rand(0..50),
    is_active: [true, false].sample,
    )
end

