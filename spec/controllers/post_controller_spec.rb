require_relative '../../controllers/post_controller'
require_relative '../../constant/status_code'

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
          'user_id'=> 1,
          'text'=> 'post text #gigih'
        }

        status, message, data = PostController.create(params)
        expect(status).to eq(CREATED)
        expect(message).to eq('success created post')

        result = $client.query('SELECT * FROM posts')
        expect(result.size).to eq(1)


        saved_user = result.first

        expect(saved_user['user_id']).to eq(params['user_id'])
        expect(saved_user['text']).to eq(params['text'])
      end
    end
  end

  describe 'read' do
    context '#find_all' do
      it 'should get data from db' do
        params_1 = {
          'user_id'=> 1,
          'text'=> 'post text #gigih1',
        }

        post_1 = Post.new(params_1)
        post_1.save

        params_2 = {
          'user_id'=> 1,
          'text'=> 'post text #gigih2',
        }

        post_2 = Post.new(params_2)
        post_2.save

        status, message, data = PostController.find_all
        expect(status).to eq(OK)
        expect(message).to eq('success')
        expect(data).not_to be_nil
      end
    end

    context '#find_by_id' do
      it 'should get data from db' do
        params = {
          'user_id'=> 1,
          'text'=> 'post text #gigih',
          'attachment_path'=> '/public/aaa.png'
        }
        id = 1

        post = Post.new(params)
        post.save

        status, message, data = PostController.find_by_id(id)
        expect(status).to eq(OK)
        expect(message).to eq('success')
        expect(data).not_to be_nil
      end

      it 'should empty result' do
        params = {
          'user_id'=> 1,
          'text'=> 'post text #gigih',
          'attachment_path'=> '/public/aaa.png'
        }
        id = 2

        post = Post.new(params)
        post.save

        status, message, data = PostController.find_by_id(id)
        expect(status).to eq(NOT_FOUND)
        expect(message).to eq('cannot find your post id')
        expect(data).to eq(nil)
      end
    end
  end
end