# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# rails db:reset
Category.connection.schema_cache.clear!
Category.reset_column_information

Brand.connection.schema_cache.clear!
Brand.reset_column_information

Product.reset_column_information
Product.connection.schema_cache.clear!


["Cozy sweaters", "Great looking shirts", "Smashing pants", "Sexy socks"].each do |i|
    Category.create({
        cat_name: i,
        description: Faker::Lorem.paragraph(sentence_count: 2),
    })
end

['Gucci', 'Prada', 'Nike', 'Adidas', 'Fear of God'].each do |c|
    Brand.create({
        name: c
    })
end


['Red', 'Black', 'Pink', 'Blue', 'Green'].each do |c|
    Color.create({
        name: c
    })
end

100.times do 
    Product.create!({
        name: Faker::Commerce.product_name,
        size: ['M', 'S', 'XL', 'L', 'XS'].sample,
        desc: Faker::Lorem.paragraph(sentence_count: 7),
        color: [1,2,3,4,5].sample,
        price: Faker::Commerce.price,
        brand_id: [1,2,3,4,5].sample,
        category_id: [1,2,3,4].sample,
        bought: false
    })
end

[{name: "shippingCost", value: 70}, {name: "shippingBar", value: 700}].each do |x|
    Misc.create(x)
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
        address: Faker::Address.street_name,
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

discounts = [
    {value_in_cash: nil, value_in_percent: nil, value_in_shipping: true, required_value: 200, amount: 10, code: Faker::Commerce.promotion_code},
    {value_in_cash: 100, value_in_percent: nil, value_in_shipping: false, required_value: 1000, amount: 5, code: Faker::Commerce.promotion_code},
    {value_in_cash: nil, value_in_percent: 10, value_in_shipping: false, required_value: 0, amount: 3, code: Faker::Commerce.promotion_code},
    {value_in_cash: 25, value_in_percent: nil, value_in_shipping: false, required_value: 100, amount: 22, code: Faker::Commerce.promotion_code},
    {value_in_cash: nil, value_in_percent: nil, value_in_shipping: true, required_value: 125, amount: 56, code: Faker::Commerce.promotion_code},
    {value_in_cash: nil, value_in_percent: 25, value_in_shipping: false, required_value: 2000, amount: 15, code: Faker::Commerce.promotion_code}
]

discounts.each do |d| 
    DiscountCode.create(d)
end

keywords = ['long', 'shirt', 'pants' 'something']
products = Product.all
30.times do
    Tag.create({
        name: keywords.sample,
        product_id: 1
    })
end


