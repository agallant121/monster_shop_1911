require "rails_helper"

RSpec.describe "as a user", type: :feature do
  before :each do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Denver', state: 'CO', zip: 80203)

    @user = User.create!(name: "Sally", street_address: "111 Drive", city: "Broomfield", state: "CO", zip: 80020, email: "sally@gmail.com", password: "fries1", role: 1)
    @merchant_user = @bike_shop.users.create!(name: "Ben", street_address: "123 Turing St", city: "Denver", state: "CO", zip: 80020, email: "ben@gmail.com", password: "password", role: 2)

    @bone = @dog_shop.items.create(name: "Bone", description: "They'll love it", price: 8, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 100)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 100)

    @order_1 = @user.orders.create!(name: "Sally", address: "111 Drive", city: "Broomfield", state: "CO", zip: 80020)
    @order_1.item_orders.create!(item: @bone, price: @bone.price, quantity: 10)
    @order_1.item_orders.create!(item: @chain, price: @chain.price, quantity: 10)

    @order_2 = @user.orders.create!(name: "Sally", address: "111 Drive", city: "Broomfield", state: "CO", zip: 80020)
    @order_2.item_orders.create!(item: @chain, price: @chain.price, quantity: 10)

    @order_3 = @user.orders.create!(name: "Sally", address: "111 Drive", city: "Broomfield", state: "CO", zip: 80020)

    @discount_1 = @bike_shop.discounts.create!(name: "5% Discount", percent_off: 5, min_quantity: 10)
    @discount_2 = @bike_shop.discounts.create!(name: "10% Discount", percent_off: 10, min_quantity: 20)
    @discount_3 = @dog_shop.discounts.create!(name: "15% Discount", percent_off: 15, min_quantity: 30)

    @item_discount_1 = ItemDiscount.create(item: @chain, discount: @discount_1)
    @item_discount_2 = ItemDiscount.create(item: @chain, discount: @discount_2)
    @item_discount_3 = ItemDiscount.create(item: @bone, discount: @discount_3)

    visit '/'
    click_link 'Login'
    expect(current_path).to eq('/login')

    fill_in :email, with: @user.email
    fill_in :password, with: 'fries1'
    click_button 'Log In'
    expect(current_path).to eq("/profile")

    click_link "All Items"
  end

  it "can get a discount on items" do
    10.times do
      click_link "#{@chain.name}"
      click_button "Add To Cart"
    end

    click_link "Cart: 10"
    within "#subtotal-#{@chain.id}" do
      expect(page).to have_content("$380.00")
    end
    expect(page).to have_content("Total: $380.00")
  end

  it "can get the higher discount of the two on an item" do
    20.times do
      click_link "#{@chain.name}"
      click_button "Add To Cart"
    end

    click_link "Cart: 20"
    within "#subtotal-#{@chain.id}" do
      expect(page).to have_content("$720.00")
    end
    expect(page).to have_content("Total: $720.00")
  end

  it "can get the a discount for two different items" do
    10.times do
      click_link "#{@chain.name}"
      click_button "Add To Cart"
    end

    30.times do
      click_link "#{@bone.name}"
      click_button "Add To Cart"
    end

    click_link "Cart: 40"
    within "#subtotal-#{@chain.id}" do
      expect(page).to have_content("$380.00")
    end

    within "#subtotal-#{@bone.id}" do
      expect(page).to have_content("$204.00")
    end
    expect(page).to have_content("Total: $584.00")
  end

  it "can get a discount for one of two items" do
    10.times do
      click_link "#{@chain.name}"
      click_button "Add To Cart"
    end

    10.times do
      click_link "#{@bone.name}"
      click_button "Add To Cart"
    end

    click_link "Cart: 20"
    within "#subtotal-#{@chain.id}" do
      expect(page).to have_content("$380.00")
    end

    within "#subtotal-#{@bone.id}" do
      expect(page).to have_content("$80.00")
    end
    expect(page).to have_content("Total: $460.00")
  end
end
