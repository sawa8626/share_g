require 'rails_helper'

RSpec.describe "TeamUsers", type: :request do
  describe '#update' do
    let(:team_user) { build(:team_user) }
    let(:another_user) { create(:user) }

    context '未ログイン時' do
      it 'リクエストに失敗すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        patch team_user_path(team_user.team.id)
        expect(response.status).to eq(302)
      end

      it 'ユーザーセッションにリダイレクトされること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        patch team_user_path(team_user.team.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'ログイン時' do
      it 'リクエストに成功すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in another_user
        patch team_user_path(team_user.team.id)
        expect(response.status).to eq(302)
      end

      it 'チーム詳細ページにリダイレクトされること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in another_user
        patch team_user_path(team_user.team.id)
        expect(response).to redirect_to(team_path(team_user.team.id))
      end

      it 'TeamUsersテーブルのレコード数が1増加すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        expect do
          patch team_user_path(team_user.team.id)
        end.to change{ TeamUser.count }.by(1)
      end
    end
  end

  describe '#destroy' do
    let(:team_user) { build(:team_user) }

    context '未ログイン時' do
      it 'リクエストに失敗すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        delete team_user_path(team_user.team.id)
        expect(response.status).to eq(302)
      end

      it 'ユーザーセッションにリダイレクトされること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        delete team_user_path(team_user.team.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'ログイン時' do
      it 'リクエストに成功すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        delete team_user_path(team_user.team.id)
        expect(response.status).to eq(302)
      end

      it 'チーム詳細ページにリダイレクトされること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        delete team_user_path(team_user.team.id)
        expect(response).to redirect_to(team_path(team_user.team.id))
      end

      it 'TeamUsersテーブルのレコード数が1減少すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        expect do
          delete team_user_path(team_user.team.id)
        end.to change{ TeamUser.count }.by(-1)
      end
    end
  end
end
