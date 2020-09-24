require 'rails_helper'
require './config/routes.rb'

RSpec.describe Reservation, type: :model do
  describe '予約機能' do
    before do
      @reservation = FactoryBot.build(:reservation)
    end

    context '正常に登録できる場合' do
      context 'チーム情報を連携する場合' do
        it '全ての値が正しく入力され、チームが選択されていれば登録できること' do
          @reservation.release = true
          expect(@reservation).to be_valid
        end
      end

      context 'チーム情報を連携しない場合' do
        it '全ての値が正しく入力されていれば、チームが選択されていなくても登録できること' do
          @reservation.release = false
          @reservation.team_id = nil
          expect(@reservation).to be_valid
        end
      end
    end

    context '登録できない場合' do
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
end

