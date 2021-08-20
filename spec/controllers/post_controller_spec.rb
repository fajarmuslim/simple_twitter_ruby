require_relative '../../controllers/post_controller'

describe PostController do
  $client = create_db_client

  before(:each) do
    $client.query('SET FOREIGN_KEY_CHECKS = 0')
    $client.query('TRUNCATE table users')
    $client.query('TRUNCATE table posts')
    $client.query("INSERT INTO users(username, email, bio) VALUES('aa', 'email@email.com', 'bio')")
  end

  after(:all) do
    $client.query('TRUNCATE table posts')
    $client.query('TRUNCATE table users')
    $client.query('SET FOREIGN_KEY_CHECKS = 1')
  end

  describe 'create' do
    context '#save' do
      it 'should save data to db' do
        params = {
          user_id: 1,
          text: 'post text #gigih',
          attachment_path: '/public/aaa.png'
        }

        PostController.create(params)

        result = $client.query('SELECT * FROM posts')
        expect(result.size).to eq(1)

        saved_user = result.first

        expect(saved_user['user_id']).to eq(params[:user_id])
        expect(saved_user['text']).to eq(params[:text])
        expect(saved_user['attachment_path']).to eq(params[:attachment_path])
      end
    end
  end
end