require 'rails_helper'

RSpec.describe "Facilities", type: :request do
  describe '#index' do
    before do
      @user = create(:user)
    end

    it 'トップページへのリクエストに成功すること' do
      get root_path
      expect(response.status).to eq(200)
    end

    it 'トップページに遷移すること' do
      get root_path
      expect(response).to render_template(:index)
    end

    it 'ログインできていればユーザー名が表示されること' do
      sign_in @user
      get root_path
      expect(response.body).to include(@user.nickname)
    end
  end

  describe '#new' do
    let(:user) { create(:user)}
    let(:user_admin) { create(:user, :admin)}

    context '未ログイン時' do
      it 'リクエストに失敗すること' do
        get new_facility_path
        expect(response.status).to eq(302)
      end

      it 'トップページにリダイレクトすること' do
        get new_facility_path
        expect(response).to redirect_to(root_path)
      end
    end

    context '一般ユーザーでログイン時' do
      it 'リクエストに失敗すること' do
        sign_in user
        get new_facility_path
        expect(response.status).to eq(302)
      end

      it 'トップページにリダイレクトすること' do
        sign_in user
        get new_facility_path
        expect(response).to redirect_to(root_path)
      end
    end

    context '管理者でログイン時' do
      it 'リクエストに成功すること' do
        sign_in user_admin
        get new_facility_path
        expect(response.status).to eq(200)
      end

      it '施設の新規登録ページに遷移すること' do
        sign_in user_admin
        get new_facility_path
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#create' do
    let(:user) { create(:user) }
    let(:user_admin) { create(:user, :admin) }
    let(:facility_params) { attributes_for(:facility) }
    let(:facility_params_ng) { attributes_for(:facility, :none) }

    context '未ログイン時' do
      it 'トップページに遷移すること' do
        post facilities_path
        expect(response).to redirect_to(root_path)
      end
    end

    context '一般ユーザーでログイン時' do
      it 'リクエストに失敗すること' do
        sign_in user
        post facilities_path
        expect(response.status).to eq(302)
      end

      it 'トップページにリダイレクトすること' do
        sign_in user
        post facilities_path
        expect(response).to redirect_to(root_path)
      end
    end

    context '管理者でログイン時かつ、パラメータが妥当な場合' do
      it 'リクエストに成功すること' do
        sign_in user_admin
        post facilities_path, params: { facility: facility_params }
        expect(response.status).to eq(302)
      end

      it 'facilityテーブルのレコード数が1増加すること' do
        sign_in user_admin
        expect do
          post facilities_path, params: { facility: facility_params }
        end.to change{ Facility.count }.by(1)
      end

      it '保存後トップページにリダイレクトすること' do
        sign_in user_admin
        post facilities_path, params: { facility: facility_params }
        expect(response).to redirect_to(root_path)
      end
    end

    context '管理者でログイン時かつ、パラメータが不正な場合' do
      it 'リクエストに成功すること' do
        sign_in user_admin
        post facilities_path, params: { facility: facility_params_ng }
        expect(response.status).to eq(200)
      end

      it 'facilityテーブルのレコード数が増加しないこと' do
        sign_in user_admin
        expect do
          post facilities_path, params: { facility: facility_params_ng }
        end.to change{ Facility.count }.by(0)
      end

      it 'エラーが表示されること' do
        sign_in user_admin
        post facilities_path, params: { facility: facility_params_ng }
        expect(response.body).to include('error-message')
      end
    end
  end
end
