# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.destroy_all
Item.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
maxxis_DH = bike_shop.items.create(name: "Maxxis DHR", description: "Awesome grp!", price: 150, image: "https://i.ebayimg.com/images/i/142126821783-0-1/s-l1000.jpg", inventory: 5)
death_grips = bike_shop.items.create(name: "death grips ", description: "Awesome grips!", price: 40, image: "https://brink.uk/assets/images/generic/DMR-Brendog-Death-Grips.jpg", inventory: 25)
downhill_rims = bike_shop.items.create(name: "STANS flow s1  29er", description: "Awesome rim!", price: 250, image: "https://www.wigglestatic.com/product-media/163035/Stans-No-Tubes-Flow-S1-MTB-Wheelset-Internal-Black-Grey-NotSet-850-WS1FL7004-6.jpg?w=2000&h=2000&a=7", inventory: 12)
xx1 = bike_shop.items.create(name: "XX1 eagle cassette", description: "Best around", price: 700, image: "https://content.competitivecyclist.com/images/items/1200/SRM/SRM009X/GD.jpg", inventory: 4)
cranks = bike_shop.items.create(name: "carbon cranks ", description: "LIGHT", price: 300, image: "https://www.sefiles.net/images/library/zoom/sram-x7-crankset-44-32-22-9-speed-copy-184997-1.jpg", inventory: 4)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
