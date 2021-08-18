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
end