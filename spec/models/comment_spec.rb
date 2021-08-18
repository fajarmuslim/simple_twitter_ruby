require_relative '../../models/comment'

describe Comment do
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
          { 'id' => 2, 'user_id' => 2, 'post_id' => 2,  'attachment_path' => '/bbb', 'created_at' => '2021-08-18 19:31:57', 'updated_at' => '2021-08-18 19:31:57' }
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
end