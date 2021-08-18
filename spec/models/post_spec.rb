require_relative '../../models/post'

describe Post do
  describe 'initialize' do
    context '.new' do
      it 'should create object' do
        params = {
          id: 1,
          user_id: 'andi',
          text: 'andi@gmail.com',
          attachment_path: 'andi si bolang'
        }

        post = Post.new(params)

        expect(post.id).to eq(params[:id])
        expect(post.user_id).to eq(params[:user_id])
        expect(post.text).to eq(params[:text])
        expect(post.attachment_path).to eq(params[:attachment_path])
      end
    end
  end

  describe 'validity' do
    context '#valid_id?' do
      it 'should valid positive integer' do
        params = {
          id: 1
        }

        post = Post.new(params)

        expect(post.valid_id?).to be_truthy
      end

      it 'should invalid negative integer' do
        params = {
          id: -1
        }

        post = Post.new(params)

        expect(post.valid_id?).to be_falsey
      end

      it 'should invalid nol integer' do
        params = {
          id: 0
        }

        post = Post.new(params)

        expect(post.valid_id?).to be_falsey
      end

      it 'should invalid if type is not integer' do
        params = {
          id: 'aaa'
        }

        post = Post.new(params)

        expect(post.valid_id?).to be_falsey
      end
    end

    context '#valid_user_id?' do
      it 'should valid user_id' do
        params = {
          user_id: 1
        }

        post = Post.new(params)

        expect(post.valid_user_id?).to be_truthy
      end

      it 'should invalid negative integer' do
        params = {
          user_id: -1
        }

        post = Post.new(params)

        expect(post.valid_user_id?).to be_falsey
      end

      it 'should invalid nol integer' do
        params = {
          user_id: 0
        }

        post = Post.new(params)

        expect(post.valid_user_id?).to be_falsey
      end

      it 'should invalid if type is not integer' do
        params = {
          user_id: 'aaa'
        }

        post = Post.new(params)

        expect(post.valid_user_id?).to be_falsey
      end
    end

    context '#valid_text?' do
      it 'should valid text' do
        params = {
          text: 'aaa'
        }

        post = Post.new(params)

        expect(post.valid_text?).to be_truthy
      end

      it 'should invalid empty string' do
        params = {
          text: ''
        }

        post = Post.new(params)

        expect(post.valid_text?).to be_falsey
      end

      it 'should invalid type not string' do
        params = {
          text: 1
        }

        post = Post.new(params)

        expect(post.valid_text?).to be_falsey
      end

      it 'should invalid exceed 1000 character' do
        params = {
          text: 'a' * 1001
        }

        post = Post.new(params)

        expect(post.valid_text?).to be_falsey
      end
    end

    context '#valid_save?' do
      it 'should valid save' do
        params = {
          user_id: 1,
          text: 'post text #gigih',
          attachment_path: '/public/aaa.png'
        }

        post = Post.new(params)

        expect(post.valid_save?).to be_truthy
      end

      it 'should invalid save' do
        params = {
          text: 'post text #gigih',
          attachment_path: '/public/aaa.png'
        }

        post = Post.new(params)

        expect(post.valid_save?).to be_falsey
      end
    end
  end
end