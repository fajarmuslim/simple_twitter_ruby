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
end