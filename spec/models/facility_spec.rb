require 'rails_helper'

RSpec.describe Facility, type: :model do
  describe '新規登録' do
    before do
      @facility = FactoryBot.build(:facility)
    end

    it '全ての値が正しく入力されていれば登録できること' do
      expect(@facility).to be_valid
    end

    it 'prefecture_idが空では登録できないこと' do
      @facility.prefecture_id = nil
      @facility.valid?
      expect(@facility.errors.full_messages).to include("Prefecture can't be blank")
    end

    it 'cityが空では登録できないこと' do
      @facility.city = nil
      @facility.valid?
      expect(@facility.errors.full_messages).to include("City can't be blank")
    end

    it 'nameが空では登録できないこと' do
      @facility.name = nil
      @facility.valid?
      expect(@facility.errors.full_messages).to include("Name can't be blank")
    end

    it 'areaが空では登録できないこと' do
      @facility.area = nil
      @facility.valid?
      expect(@facility.errors.full_messages).to include("Area can't be blank")
    end

    it 'phone_numberが空では登録できないこと' do
      @facility.phone_number = nil
      @facility.valid?
      expect(@facility.errors.full_messages).to include("Phone number can't be blank")
    end

    it 'phone_numberが12桁以上では登録できないこと' do
      @facility.phone_number = '061234567890'
      @facility.valid?
      expect(@facility.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
    end

    it 'priceが空では登録できないこと' do
      @facility.price = nil
      @facility.valid?
      expect(@facility.errors.full_messages).to include("Price is not a number")
    end

    it 'priceが数値以外では登録できないこと' do
      @facility.price = 'one thousand'
      @facility.valid?
      expect(@facility.errors.full_messages).to include("Price is not a number")
    end
  end
end
