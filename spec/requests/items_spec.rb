require 'rails_helper'
# 結合テストでやる↓
RSpec.describe 'Items', type: :request do
  describe 'GET /items' do
    context 'ユーザーがサインインしているとき' do
      it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do
        get new_item_path
        expect(response).to have_http_status(200)
      end
    end
  end
end
