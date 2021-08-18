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

    it 'should invalid negative integer' do
      params = {
        id: -1
      }

      hashtag = Hashtag.new(params)

      expect(hashtag.valid_id?).to be_falsey
    end

    it 'should invalid nol integer' do
      params = {
        id: 0
      }

      hashtag = Hashtag.new(params)

      expect(hashtag.valid_id?).to be_falsey
    end

    it 'should invalid if type is not integer' do
      params = {
        id: 'aaa'
      }

      hashtag = Hashtag.new(params)

      expect(hashtag.valid_id?).to be_falsey
    end
  end

  context '#valid_text?' do
    it 'should valid text' do
      params = {
        text: 'ppkm'
      }

      hashtag = Hashtag.new(params)

      expect(hashtag.valid_text?).to be_truthy
    end

    it 'should invalid empty string' do
      params = {
        text: ''
      }

      hashtag = Hashtag.new(params)

      expect(hashtag.valid_text?).to be_falsey
    end

    it 'should invalid type not string' do
      params = {
        text: 1
      }

      hashtag = Hashtag.new(params)

      expect(hashtag.valid_text?).to be_falsey
    end

    it 'should invalid exceed 999 character' do
      params = {
        text: 'a' * 1000
      }

      hashtag = Hashtag.new(params)

      expect(hashtag.valid_text?).to be_falsey
    end
  end
end