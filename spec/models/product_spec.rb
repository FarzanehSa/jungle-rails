require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'will pass with correct attributes' do
      @cat = Category.new(name: 'cat-name')
      @pro = Product.new(name: 'pro-name', price:100, quantity: 10, category: @cat)
      expect(@cat).to be_valid
      expect(@pro).to be_valid
    end

    it 'will fail without name' do
      @cat = Category.new(name: 'cat-name')
      @pro = Product.new(name: nil, price:100, quantity: 10, category: @cat)
      expect(@cat).to be_valid
      expect(@pro).to_not be_valid
    end

    it 'will fail without price' do
      @cat = Category.new(name: 'cat-name')
      @pro = Product.new(name: 'pro-name', price_cents: nil, quantity: 10, category: @cat)
      expect(@cat).to be_valid
      expect(@pro).to_not be_valid
    end

    it 'will fail without quantity' do
      @cat = Category.new(name: 'cat-name')
      @pro = Product.new(name: 'pro-name', price_cents: 100, quantity: nil, category: @cat)
      expect(@cat).to be_valid
      expect(@pro).to_not be_valid
    end

    it 'will fail without category' do
      @cat = Category.new(name: 'cat-name')
      @pro = Product.new(name: 'pro-name', price_cents: 100, quantity: 1, category: nil)
      expect(@cat).to be_valid
      expect(@pro).to_not be_valid
    end

  end
end