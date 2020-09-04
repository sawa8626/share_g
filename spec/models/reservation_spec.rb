require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe '施設予約' do
    before do
      @reservation = FactoryBot.build(:reservation)
    end

    it '全ての値が正しく入力されていれば登録できること' do
      expect(@reservation).to be_valid
    end

    it 'use_applicationが空では登録できないこと' do
      @reservation.use_application = nil
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include("Use application can't be blank")
    end

    it 'start_timeが空では登録できないこと' do
      @reservation.start_time = nil
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include("Start time can't be blank")
    end

    it 'end_timeが空では登録できないこと' do
      @reservation.end_time = nil
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include("End time can't be blank")
    end

    it 'releaseが空では登録できないこと' do
      @reservation.release = nil
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include('Release is not included in the list')
    end
  end
end

