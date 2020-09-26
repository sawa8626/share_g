require 'rails_helper'

RSpec.describe "Teams", type: :request do
  describe '#new' do
    let(:user) { create(:user) }

    context '未ログイン時' do
      it 'リクエストに失敗すること' do
        get new_team_path
        expect(response.status).to eq(302)
      end

      it 'ユーザーセッションにリダイレクトされること' do
        get new_team_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'ログイン時' do
      it 'リクエストに成功すること' do
        sign_in user
        get new_team_path
        expect(response.status).to eq(200)
      end

      it '新規チーム登録ページに遷移すること' do
        sign_in user
        get new_team_path
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#create' do
    let(:user) { create(:user) }
    let(:team_params) { attributes_for(:team, image: fixture_file_upload('public/images/team_test_image.jpg')) }
    let(:team_params_ng) { attributes_for(:team) }

    context '未ログイン時' do
      it 'リクエストに失敗すること' do
        post teams_path, params: { team: team_params }
        expect(response.status).to eq(302)
      end

      it 'ユーザーセッションにリダイレクトされること' do
        post teams_path, params: { team: team_params }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'ログイン時かつ、パラメータが妥当な場合' do
      it 'リクエストに成功すること' do
        sign_in user
        post teams_path, params: { team: team_params }
        expect(response.status).to eq(302)
      end

      it 'teamsテーブルのレコード数が1増加すること' do
        sign_in user
        expect do
          post teams_path, params: { team: team_params }
        end.to change{ Team.count }.by(1)
      end

      it 'team_usersテーブルのレコードが1増加すること' do
        sign_in user
        expect do
          post teams_path, params: { team: team_params }
        end.to change{ TeamUser.count }.by(1)
      end

      it 'トップページにリダイレクトされること' do
        sign_in user
        post teams_path, params: { team: team_params }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'ログイン時かつ、パラメータが不正な場合' do
      it 'リクエストに成功すること' do
        sign_in user
        post teams_path, params: { team: team_params_ng }
        expect(response.status).to eq(200)
      end

      it 'teamsテーブルのレコード数が増加しないこと' do
        sign_in user
        expect do
          post teams_path, params: { team: team_params_ng }
        end.to change{ Team.count }.by(0)
      end

      it 'team_usersテーブルのレコードが増加しないこと' do
        sign_in user
        expect do
          post teams_path, params: { team: team_params_ng }
        end.to change{ TeamUser.count }.by(0)
      end

      it '新規チーム登録ページにリダイレクトされること' do
        sign_in user
        post teams_path, params: { team: team_params_ng }
        expect(response).to render_template(:new)
      end

      it 'エラーが表示されること' do
        sign_in user
        post teams_path, params: { team: team_params_ng }
        expect(response.body).to include('error-message')
      end
    end
  end

  describe '#show' do
    let(:team) { create(:team, image: fixture_file_upload('public/images/team_test_image.jpg')) }

    it 'リクエストに成功すること' do
      get team_path(team.id)
      expect(response.status).to eq(200)
    end

    it 'チーム詳細ページに遷移すること' do
      get team_path(team.id)
      expect(response).to render_template(:show)
    end

    it 'チーム詳細ページにチーム情報が表示されていること' do
      get team_path(team.id)
      expect(response.body).to include(team.name)
    end
  end

  describe '#edit' do
    let(:team_user) { build(:team_user) }
    let(:another_user) { create(:user) }

    context 'チームに所属するメンバーで実行した場合' do
      it 'リクエストに成功すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        get edit_team_path(team_user.team.id)
        expect(response.status).to eq(200)
      end

      it 'チーム情報編集ページに遷移すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        get edit_team_path(team_user.team.id)
        expect(response.status).to render_template(:edit)
      end

      it 'チーム情報編集ページに登録済みの情報が入力されていること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        get edit_team_path(team_user.team.id)
        expect(response.body).to include(team_user.team.name)
      end
    end

    context 'チームに所属するメンバー以外で実行した場合' do
      it 'リクエストに失敗すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in another_user
        get edit_team_path(team_user.team.id)
        expect(response.status).to eq(302)
      end

      it 'トップページにリダイレクトされること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in another_user
        get edit_team_path(team_user.team.id)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '#update' do
    let(:team_user) { build(:team_user) }
    let(:another_user) { create(:user) }
    let(:team_params) { attributes_for(:team, id: team_user.team.id, name: 'TECH Ballers') }
    let(:team_params_ng) { attributes_for(:team, id: team_user.team.id, name: nil) }

    context 'チームに所属するメンバーで実行し、パラメータが妥当な場合' do
      it 'リクエストに成功すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        patch team_path(team_user.team.id), params: { team: team_params }
        expect(response.status).to eq(200)
      end

      it 'teamsテーブルのレコード数は変化しないこと' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        expect do
          patch team_path(team_user.team.id), params: { team: team_params }
        end.to change{ Team.count }.by(0)
      end

      it 'team_usersテーブルのレコードは変化しないこと' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        expect do
          patch team_path(team_user.team.id), params: { team: team_params }
        end.to change{ TeamUser.count }.by(0)
      end

      it 'チーム詳細ページに遷移すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        patch team_path(team_user.team.id), params: { team: team_params }
        expect(response).to render_template(:show)
      end

      it 'チーム詳細ページに遷移し、変更後の情報が表示されていること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        patch team_path(team_user.team.id), params: { team: team_params }
        expect(response.body).to include('TECH Ballers')
      end
    end

    context 'チームに所属するメンバーで実行し、パラメータが不正な場合' do
      it 'リクエストに成功すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        patch team_path(team_user.team.id), params: { team: team_params_ng }
        expect(response.status).to eq(200)
      end

      it 'teamsテーブルのレコード数は変化しないこと' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        expect do
          patch team_path(team_user.team.id), params: { team: team_params_ng }
        end.to change{ Team.count }.by(0)
      end

      it 'team_usersテーブルのレコードは変化しないこと' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        expect do
          patch team_path(team_user.team.id), params: { team: team_params_ng }
        end.to change{ TeamUser.count }.by(0)
      end

      it 'チーム情報編集ページにリダイレクトされること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        patch team_path(team_user.team.id), params: { team: team_params_ng }
        expect(response).to render_template(:edit)
      end

      it 'エラーが表示されること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        patch team_path(team_user.team.id), params: { team: team_params_ng }
        expect(response.body).to include('error-message')
      end
    end

    context 'チームに所属するメンバー以外で実行した場合' do
      it 'リクエストに失敗すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in another_user
        patch team_path(team_user.team.id), params: { team: team_params }
        expect(response.status).to eq(302)
      end

      it 'トップページにリダイレクトされること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in another_user
        patch team_path(team_user.team.id), params: { team: team_params }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '#destroy' do
    let(:team_user) { build(:team_user) }
    let(:another_user) { create(:user) }

    context 'チームに所属するメンバーで実行した場合' do
      it 'リクエストに成功すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        delete team_path(team_user.team.id)
        expect(response.status).to eq(302) 
      end

      it 'teamsテーブルのレコード数が1減少すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        expect do
          delete team_path(team_user.team.id)
        end.to change{ Team.count }.by(-1)
      end

      it 'team_usersテーブルのレコード数が1減少すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        expect do
          delete team_path(team_user.team.id)
        end.to change{ TeamUser.count }.by(-1)
      end

      it 'トップページにリダイレクトされること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in team_user.user
        delete team_path(team_user.team.id)
        expect(response).to redirect_to(root_path) 
      end
    end

    context 'チームに所属するメンバー以外で実行した場合' do
      it 'リクエストに失敗すること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in another_user
        delete team_path(team_user.team.id)
        expect(response.status).to eq(302) 
      end

      it 'teamsテーブルのレコード数が変化しないこと' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in another_user
        expect do
          delete team_path(team_user.team.id)
        end.to change{ TeamUser.count }.by(0)
      end

      it 'team_usersテーブルのレコード数が変化しないこと' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in another_user
        expect do
          delete team_path(team_user.team.id)
        end.to change{ TeamUser.count }.by(0)
      end

      it 'トップページにリダイレクトされること' do
        team_user.team.image = fixture_file_upload('public/images/team_test_image.jpg')
        team_user.save
        sign_in another_user
        delete team_path(team_user.team.id)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
