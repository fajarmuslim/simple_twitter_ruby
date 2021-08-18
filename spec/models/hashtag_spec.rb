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

  describe 'validity' do
    context '#valid_id?' do
      it 'should valid positive integer' do
        params = {
          id: 1
        }

        hashtag = Hashtag.new(params)

        expect(hashtag.valid_id?).to be_truthy
      end
    end
  end
end