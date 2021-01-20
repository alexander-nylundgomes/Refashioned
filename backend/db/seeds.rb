# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.connection.schema_cache.clear!
Category.reset_column_information


["Cozy sweaters", "Great looking shirts", "Smashing pants", "Sexy socks"].each do |i|
    Category.create({
        name: i,
        description: Faker::Lorem.paragraph(sentence_count: 2),
    })
end

100.times do 
    Product.create({
        name: Faker::Commerce.product_name,
        size: ['M', 'S', 'XL', 'L', 'XS'].sample,
        desc: Faker::Lorem.paragraph(sentence_count: 4),
        color: [1,2,3,4,5].sample,
        price: Faker::Commerce.price,
        brand_id: [1,2,3,4,5].sample,
        category_id: [1,2,3,4].sample
    })
end

['Red', 'Black', 'Pink', 'Blue', 'Green'].each do |c|
    Color.create({
        name: c
    })
end

['Gucci', 'Prada', 'Nike', 'Adidas', 'Fear of God'].each do |c|
    Brand.create({
        name: c
    })
end

20.times do 
    Msg.create({
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        msg: Faker::Lorem.paragraph(sentence_count: [1,2,3,4].sample),
        subject: Faker::Lorem.word,
        email: Faker::Internet.email
    })
end

10.times do 
    Order.create({
        value: Faker::Commerce.price * 3,
        adress: Faker::Address.street_name,
        city: Faker::Address.city,
        email: Faker::Internet.email,
        phone: Faker::PhoneNumber.phone_number_with_country_code,
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        postal: Faker::Address.zip_code,
        tracking: "98022204099SE",
    })
end

# 30.times do 
#     products = Product.all
#     orders = Order.all
#     OrderdProduct.create({
#         product_id: 
#     })
# end

3.times do 
    DiscountCode.create({
        code: Faker::Commerce.promotion_code,
        amount: rand(100),
    })
end

keywords = ['long', 'shirt', 'pants' 'something']
products = Product.all
30.times do
    Tag.create({
        name: keywords.sample,
        product_id: 1
    })
end


