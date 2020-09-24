require 'rails_helper'

RSpec.describe "Facilities", type: :request do
  describe '#new' do
    before do
      @user = build(:user)
      @user.admin = true
      @user.save
    end

    context '未ログイン時' do
      it 'トップページに遷移する' do
        get new_facility_path
        expect(response).to redirect_to(root_path)
      end
    end

    context 'ログイン時' do
      it '施設の新規登録ページに遷移する' do
        sign_in @user
        get new_facility_path
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#create' do
    let(:user) { build(:user)}
    let(:facility_params) {attributes_for(:facility).merge(user_id: user.id)}

    context '未ログイン時' do
      it 'トップページに遷移する' do
        post facilities_path
        expect(response).to redirect_to(root_path)
      end
    end

    context 'ログイン時' do
      it '施設情報が保存できたらfacilitiesテーブルのレコード数が1増加すること' do
        user.admin = true
        user.save
        sign_in user
        @facility = Facility.new
        expect do
          post facilities_path(@facility), params: { facility: facility_params }
        end.to change{ Facility.count }.by(1)
      end
    end
  end
end
