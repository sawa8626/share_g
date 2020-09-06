require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'チーム新規登録' do
    before do
      @team = FactoryBot.build(:team)
      @team.image = fixture_file_upload('public/images/team_test_image.jpg')
    end

    it '全ての値が正しく入力されていれば登録できること' do
      expect(@team).to be_valid
    end

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
