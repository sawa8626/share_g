require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  describe '#index' do
    let(:facility) { create(:facility)}

    it 'リクエストに成功すること' do
      get facility_reservations_path(facility.id)
      expect(response.status).to eq(200)
    end

    it '予約カレンダーページに遷移すること' do
      get facility_reservations_path(facility.id)
      expect(response).to render_template(:index)
    end

    it '施設名が表示されること' do
      get facility_reservations_path(facility.id)
      expect(response.body).to include("#{facility.name} / #{facility.area}予約カレンダー")
    end

    it 'その他の施設名が表示されること' do
      facility2 = FactoryBot.create(:facility)
      get facility_reservations_path(facility.id)
      expect(response.body).to include(facility2.name)
    end
  end

  describe '#new' do
    let(:user) { create(:user) }
    let(:facility) { create(:facility)}

    context '未ログイン時' do
      it 'リクエストに失敗すること' do
        get new_facility_reservation_path(facility.id)
        expect(response.status).to eq(302)
      end

      it 'ユーザーセッションページにリダイレクトされること' do
        get new_facility_reservation_path(facility.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'ログイン時' do
      it 'リクエストに成功すること' do
        sign_in user
        get new_facility_reservation_path(facility.id)
        expect(response.status).to eq(200)
      end

      it '予約登録ページに遷移すること' do
        sign_in user
        get new_facility_reservation_path(facility.id)
        expect(response).to render_template(:new)
      end

      it 'ユーザーの持つチーム情報が表示されていること' do
        team_user = FactoryBot.build(:team_user, id: 1)
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.user.id = 1
        team_user.team.id = 1
        team_user.save
        sign_in team_user.user
        get new_facility_reservation_path(facility.id)
        expect(response.body).to include(team_user.team.name)
      end
    end
  end

  describe '#create' do
    let(:user) { create(:user) }
    let(:facility) { create(:facility) }
    let(:reservation_params) { attributes_for(:reservation) }
    let(:reservation_params_ng) { attributes_for(:reservation, :none) }

    context '未ログイン時' do
      it 'リクエストに失敗すること' do
        post facility_reservations_path(facility.id)
        expect(response.status).to eq(302)
      end

      it 'ユーザーセッションページにリダイレクトされること' do
        post facility_reservations_path(facility.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'ログイン時かつ、パラメータが妥当な場合' do
      it 'リクエストに成功すること' do
        sign_in user
        post facility_reservations_path(facility.id), params: { reservation: reservation_params }
        expect(response.status).to eq(302)
      end

      it 'reservationsテーブルのレコードが1増加すること' do
        sign_in user
        expect do
          post facility_reservations_path(facility.id), params: { reservation: reservation_params }
        end.to change{ Reservation.count }.by(1)
      end

      it '保存後、予約カレンダーページにリダイレクトされること' do
        sign_in user
        post facility_reservations_path(facility.id), params: { reservation: reservation_params }
        expect(response).to redirect_to(facility_reservations_path(facility.id))
      end
    end

    context 'ログイン時かつ、パラメータが不正な場合' do
      it 'リクエストに成功すること' do
        sign_in user
        post facility_reservations_path(facility.id), params: { reservation: reservation_params_ng }
        expect(response.status).to eq(200)
      end

      it 'reservationsテーブルのレコードが増加しないこと' do
        sign_in user
        expect do
          post facility_reservations_path(facility.id), params: { reservation: reservation_params_ng }
        end.to change{ Reservation.count }.by(0)
      end

      it 'エラーメッセージが表示されること' do
        sign_in user
        post facility_reservations_path(facility.id), params: { reservation: reservation_params_ng }
        expect(response.body).to include('error-message')
      end
    end
  end
end
