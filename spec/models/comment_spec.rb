require_relative '../../models/comment'

describe Comment do
  $client = create_db_client

  before(:each) do
    $client.query('SET FOREIGN_KEY_CHECKS = 0')
    $client.query('TRUNCATE table comments')
    $client.query('TRUNCATE table posts')
    $client.query('TRUNCATE table users')
    $client.query("INSERT INTO users(username, email, bio) VALUES('aa', 'email@email.com', 'bio')")
    $client.query("INSERT INTO posts(user_id, text) VALUES(1, 'aaa')")
  end

  after(:all) do
    $client.query('TRUNCATE table comments')
    $client.query('TRUNCATE table posts')
    $client.query('TRUNCATE table users')
    $client.query('SET FOREIGN_KEY_CHECKS = 1')
  end

  describe 'initialize' do
    context '.new' do
      it 'should create object' do
        params = {
          id: 1,
          post_id: 1,
          user_id: 1,
          text: 'comment text #gigih',
          attachment_path: '/public/aaa.png'
        }

        comment = Comment.new(params)

        expect(comment.id).to eq(params[:id])
        expect(comment.post_id).to eq(params[:post_id])
        expect(comment.user_id).to eq(params[:user_id])
        expect(comment.text).to eq(params[:text])
        expect(comment.attachment_path).to eq(params[:attachment_path])
      end
    end
  end

  describe 'validity' do
    context '#valid_id?' do
      it 'should valid positive integer' do
        params = {
          id: 1
        }

        comment = Comment.new(params)

        expect(comment.valid_id?).to be_truthy
      end

      it 'should invalid negative integer' do
        params = {
          id: -1
        }

        comment = Comment.new(params)

        expect(comment.valid_id?).to be_falsey
      end

      it 'should invalid nol integer' do
        params = {
          id: 0
        }

        comment = Comment.new(params)

        expect(comment.valid_id?).to be_falsey
      end

      it 'should invalid if type is not integer' do
        params = {
          id: 'aaa'
        }

        comment = Comment.new(params)

        expect(comment.valid_id?).to be_falsey
      end
    end

    context '#valid_user_id?' do
      it 'should valid user_id' do
        params = {
          user_id: 1
        }

        comment = Comment.new(params)

        expect(comment.valid_user_id?).to be_truthy
      end

      it 'should invalid negative integer' do
        params = {
          user_id: -1
        }

        comment = Comment.new(params)

        expect(comment.valid_user_id?).to be_falsey
      end

      it 'should invalid nol integer' do
        params = {
          user_id: 0
        }

        comment = Comment.new(params)

        expect(comment.valid_user_id?).to be_falsey
      end

      it 'should invalid if type is not integer' do
        params = {
          user_id: 'aaa'
        }

        comment = Comment.new(params)

        expect(comment.valid_user_id?).to be_falsey
      end
    end

    context '#valid_post_id?' do
      it 'should valid post_id' do
        params = {
          post_id: 1
        }

        comment = Comment.new(params)

        expect(comment.valid_post_id?).to be_truthy
      end

      it 'should invalid negative integer' do
        params = {
          post_id: -1
        }

        comment = Comment.new(params)

        expect(comment.valid_post_id?).to be_falsey
      end

      it 'should invalid nol integer' do
        params = {
          post_id: 0
        }

        comment = Comment.new(params)

        expect(comment.valid_post_id?).to be_falsey
      end

      it 'should invalid if type is not integer' do
        params = {
          post_id: 'aaa'
        }

        comment = Comment.new(params)

        expect(comment.valid_post_id?).to be_falsey
      end
    end

    context '#valid_text?' do
      it 'should valid text' do
        params = {
          text: 'aaa'
        }

        comment = Comment.new(params)

        expect(comment.valid_text?).to be_truthy
      end

      it 'should invalid empty string' do
        params = {
          text: ''
        }

        comment = Comment.new(params)

        expect(comment.valid_text?).to be_falsey
      end

      it 'should invalid type not string' do
        params = {
          text: 1
        }

        comment = Comment.new(params)

        expect(comment.valid_text?).to be_falsey
      end

      it 'should invalid exceed 1000 character' do
        params = {
          text: 'a' * 1001
        }

        comment = Comment.new(params)

        expect(comment.valid_text?).to be_falsey
      end
    end

    context '#valid_save?' do
      it 'should valid save' do
        params = {
          user_id: 1,
          post_id: 1,
          text: 'post text #gigih',
          attachment_path: '/public/aaa.png'
        }

        comment = Comment.new(params)

        expect(comment.valid_save?).to be_truthy
      end

      it 'should invalid save' do
        params = {
          user_id: 1,
          text: 'post text #gigih',
          attachment_path: '/public/aaa.png'
        }

        comment = Comment.new(params)

        expect(comment.valid_save?).to be_falsey
      end
    end
  end

  describe 'convert sql result' do
    context '.convert_sql_result_to_array' do
      it 'should return filled array' do
        sql_result = [
          { 'id' => 1, 'user_id' => 1, 'post_id' => 1, 'attachment_path' => '/aaa', 'created_at' => '2021-08-18 19:31:56', 'updated_at' => '2021-08-18 19:31:56' },
          { 'id' => 2, 'user_id' => 2, 'post_id' => 2, 'attachment_path' => '/bbb', 'created_at' => '2021-08-18 19:31:57', 'updated_at' => '2021-08-18 19:31:57' }
        ]

        expected_comment_1 = Comment.new({ id: 1, user_id: 1, post_id: 1, attachment_path: '/aaa', created_at: '2021-08-18 19:31:56', updated_at: '2021-08-18 19:31:56' })
        expected_comment_2 = Comment.new({ id: 2, user_id: 2, post_id: 2, attachment_path: '/bbb', created_at: '2021-08-18 19:31:57', updated_at: '2021-08-18 19:31:57' })

        actual_array = Comment.convert_sql_result_to_array(sql_result)
        expected_array = [expected_comment_1, expected_comment_2]

        expect(expected_array.size).to eq(actual_array.size)
        (0..expected_array.size - 1).each do |i|
          expect(actual_array[i].id).to eq(expected_array[i].id)
          expect(actual_array[i].user_id).to eq(expected_array[i].user_id)
          expect(actual_array[i].post_id).to eq(expected_array[i].post_id)
          expect(actual_array[i].attachment_path).to eq(expected_array[i].attachment_path)
          expect(actual_array[i].created_at).to eq(expected_array[i].created_at)
          expect(actual_array[i].updated_at).to eq(expected_array[i].updated_at)
        end
      end

      it 'should return empty array' do
        sql_result = nil

        actual_array = Comment.convert_sql_result_to_array(sql_result)
        expected_array = []

        expect(expected_array.size).to eq(actual_array.size)
      end
    end
  end

  describe 'create' do
    context '#save' do
      it 'should receive correct query' do
        params = {
          user_id: 1,
          post_id: 1,
          text: 'comment text #gigih',
          attachment_path: '/public/aaa.png'
        }

        comment = Comment.new(params)

        mock_client = double
        allow(Mysql2::Client).to receive(:new).and_return(mock_client)
        allow(mock_client).to receive(:last_id).and_return(1)

        expect(mock_client).to receive(:query).with("INSERT INTO comments(user_id, post_id, text, attachment_path) VALUES (#{params[:user_id]}, #{params[:post_id]}, '#{params[:text]}', '#{params[:attachment_path]}')")
        expect(comment.save).not_to be_nil
      end

      it 'should save data to db' do
        params = {
          user_id: 1,
          post_id: 1,
          text: 'comment text #gigih',
          attachment_path: '/public/aaa.png'
        }

        comment = Comment.new(params)
        comment.save

        result = $client.query('SELECT * FROM comments')
        expect(result.size).to eq(1)

        saved_user = result.first

        expect(saved_user['user_id']).to eq(params[:user_id])
        expect(saved_user['post_id']).to eq(params[:post_id])
        expect(saved_user['text']).to eq(params[:text])
        expect(saved_user['attachment_path']).to eq(params[:attachment_path])
      end
    end
  end

  describe 'read' do
    context '#find_all' do
      it 'should receive correct query' do
        mock_client = double
        allow(Mysql2::Client).to receive(:new).and_return(mock_client)

        expect(mock_client).to receive(:query).with('SELECT * FROM comments')
        expect(Comment.find_all).to eq([])
      end

      it 'should get data from db' do
        params_1 = {
          user_id: 1,
          post_id: 1,
          text: 'comment text #gigih1',
          attachment_path: '/public/aaa1.png'
        }

        comment_1 = Comment.new(params_1)
        comment_1.save

        params_2 = {
          user_id: 1,
          post_id: 1,
          text: 'comment text #gigih2',
          attachment_path: '/public/aaa2.png'
        }

        comment_2 = Comment.new(params_2)
        comment_2.save

        result = Comment.find_all
        expect(result.size).to eq(2)

        result_1 = result[0]
        expect(result_1.user_id).to eq(params_1[:user_id])
        expect(result_1.post_id).to eq(params_1[:post_id])
        expect(result_1.text).to eq(params_1[:text])
        expect(result_1.attachment_path).to eq(params_1[:attachment_path])

        result_2 = result[1]
        expect(result_2.user_id).to eq(params_2[:user_id])
        expect(result_2.post_id).to eq(params_2[:post_id])
        expect(result_2.text).to eq(params_2[:text])
        expect(result_2.attachment_path).to eq(params_2[:attachment_path])
      end
    end

    context '#find_by_id' do
      it 'should receive correct query' do
        id = 1

        mock_client = double
        allow(Mysql2::Client).to receive(:new).and_return(mock_client)

        expect(mock_client).to receive(:query).with("SELECT * FROM comments WHERE id = #{id}")
        expect(Comment.find_by_id(id)).to eq(nil)
      end

      it 'should get data from db' do
        params = {
          user_id: 1,
          post_id: 1,
          text: 'comment text #gigih',
          attachment_path: '/public/aaa.png'
        }

        comment = Comment.new(params)
        comment.save

        result = Comment.find_by_id(1)
        expect(result.user_id).to eq(params[:user_id])
        expect(result.post_id).to eq(params[:post_id])
        expect(result.text).to eq(params[:text])
        expect(result.attachment_path).to eq(params[:attachment_path])
      end
    end
  end
end