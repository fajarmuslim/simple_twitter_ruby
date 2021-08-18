require_relative '../../models/comment'

describe Comment do
  describe 'initialize' do
    context '.new' do
      it 'should create object' do
        params = {
          id: 1,
          post_id: 1,
          user_id: 1,
          text: 'post text #gigih',
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
  end
end