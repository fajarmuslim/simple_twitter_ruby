require_relative '../../models/hashtag'

describe Hashtag do
  describe 'initialize' do
    context '.new' do
      it 'should create object' do
        params = {
          id: 1,
          text: 'ppkm'
        }

        hashtag = Hashtag.new(params)

        expect(hashtag.id).to eq(params[:id])
        expect(hashtag.text).to eq(params[:text])
      end
    end
  end
end