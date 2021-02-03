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

Quality.reset_column_information
Quality.connection.schema_cache.clear!

qualities = [
    {name: 'Never been worn', description: Faker::Lorem.paragraph(sentence_count: 3), grade: '1'},
    {name: 'Amazing', description: Faker::Lorem.paragraph(sentence_count: 3), grade: '2'},
    {name: 'Really good', description: Faker::Lorem.paragraph(sentence_count: 3), grade: '3'},
    {name: 'Great', description: Faker::Lorem.paragraph(sentence_count: 3), grade: '4'},
    {name: 'Pretty good', description: Faker::Lorem.paragraph(sentence_count: 3), grade: '5'},
    {name: 'OK', description: Faker::Lorem.paragraph(sentence_count: 3), grade: '6'},
    {name: 'Decent', description: Faker::Lorem.paragraph(sentence_count: 3), grade: '7'},
    {name: 'Not to bad', description: Faker::Lorem.paragraph(sentence_count: 3), grade: '8'},
    {name: 'Bad', description: Faker::Lorem.paragraph(sentence_count: 3), grade: '9'},
    {name: 'Pretty bad', description: Faker::Lorem.paragraph(sentence_count: 3), grade: '10'},
    {name: 'Absolute garbage', description: Faker::Lorem.paragraph(sentence_count: 3), grade: '11'},
]

qualities.each do |c|
    Quality.create(c)
end

["Cozy sweaters", "Great looking shirts", "Smashing pants", "Sexy socks"].each do |i|
    Category.create!({
        name: i,
        description: Faker::Lorem.paragraph(sentence_count: 2),
        img_path: Faker::LoremFlickr.image(size: "300x300"),
    })
end


brands = ['Gucci', 'Prada', 'Nike', 'Adidas', 'Fear of God']
brands.each do |c|
    Brand.create({
        name: c,
        description: Faker::Lorem.paragraph(sentence_count: 3),
        img_path: Faker::LoremFlickr.image(size: "300x300"),
    })
end


[{name: 'Red', color: "#fc4c3c"}, {name: 'Black', color: "#302d2d"}, {name: 'Pink', color: '#e892a5'}, {name: 'Blue', color: '#6daceb'}, {name: 'Green', color: '#2cbd33'}].each do |c|
    Color.create({
        name: c[:name],
        color: c[:color],
        img_path: Faker::LoremFlickr.image(size: "300x300"),
        description: Faker::Lorem.paragraph(sentence_count: 3),
    })
end

100.times do 
    price = Faker::Commerce.price
    if rand(4) == 0
        old = price * 1.25
    else
        old = nil
    end

    Product.create!({
        name: Faker::Commerce.product_name,
        size: ['M', 'S', 'XL', 'L', 'XS'].sample,
        desc: Faker::Lorem.paragraph(sentence_count: 7),
        color_id: [1,2,3,4,5].sample,
        price: price,
        brand_id: [1,2,3,4,5].sample,
        category_id: [1,2,3,4].sample,
        bought: false,
        old_price: old,
        quality_id: rand(1..10),
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
        email: Faker::Internet.email,
        phone: Faker::PhoneNumber.phone_number_with_country_code,
        read: rand(3) == 0
    })
end

10.times do 
    num = rand(3)
    if num == 0
        status = 'recieved'
    elsif num == 1
        status = 'sent'
    else
        status = 'problem'
    end

    Order.create({
        value: Faker::Commerce.price * 5,
        address: Faker::Address.street_name,
        city: Faker::Address.city,
        email: Faker::Internet.email,
        phone: Faker::PhoneNumber.phone_number_with_country_code,
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        postal: Faker::Address.zip_code,
        tracking: "98022204099SE",
        status: status,
    })
end



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
150.times do
    Tag.create({
        name: keywords.sample,
        product_id: products.sample.id
    })
end

conditions = [
    'Absolute garbage',
    'Pretty bad',
    'Bad',
    'Not to bad',
    'Decent',
    'OK',
    'Pretty good',
    'Great',
    'Really good',
    'Amazing',
    'Never been worn',
]

10.times do

    SellRequest.create({
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        email: Faker::Internet.email,
        phone: Faker::PhoneNumber.phone_number_with_country_code,
        brand: brands.sample,
        condition: conditions.sample,
        file_path: "some_random_file_path",
        asking_price: Faker::Commerce.price,
    })
end

collectedPrice = 0

3.times do 
    price = Faker::Commerce.price
    collectedPrice += price
    Product.create!({
        name: Faker::Commerce.product_name,
        size: ['M', 'S', 'XL', 'L', 'XS'].sample,
        desc: Faker::Lorem.paragraph(sentence_count: 7),
        color_id: [1,2,3,4,5].sample,
        price: price,
        brand_id: [1,2,3,4,5].sample,
        category_id: [1,2,3,4].sample,
        bought: true,
        old_price: nil,
        quality_id: rand(1..10),
    })
end

products = Product.where(bought: true)
order = Order.first

products.each do |x| 

    OrderdProduct.create({
        product_id: x.id,
        order_id: order.id
    })
end

