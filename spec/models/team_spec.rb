require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'チーム新規登録' do
    before do
      @team = FactoryBot.build(:team)
      @team.image = fixture_file_upload('public/images/team_test_image.jpg')
    end

    context '正常に登録できる場合' do
      it '全ての値が正しく入力されていれば登録できること' do
        expect(@team).to be_valid
      end

      it 'facebook_urlが空でも登録できること' do
        @team.facebook_url = nil
        expect(@team).to be_valid
      end

      it 'twitter_urlが空でも登録できること' do
        @team.twitter_url = nil
        expect(@team).to be_valid
      end

      it 'instagram_urlが空でも登録できること' do
        @team.instagram_url = nil
        expect(@team).to be_valid
      end
    end

    context '登録できない場合' do
      it 'nameが空では登録できないこと' do
        @team.name = nil
        @team.valid?
        expect(@team.errors.full_messages).to include("Name can't be blank")
      end
  
      it 'activityが空では登録できないこと' do
        @team.activity = nil
        @team.valid?
        expect(@team.errors.full_messages).to include("Activity can't be blank")
      end
  
      it 'imageが空では登録できないこと' do
        @team.image = nil
        @team.valid?
        expect(@team.errors.full_messages).to include("Image can't be blank")
      end
  
      it 'contentが空では登録できないこと' do
        @team.content = nil
        @team.valid?
        expect(@team.errors.full_messages).to include("Content can't be blank")
      end
    end
  end
end
