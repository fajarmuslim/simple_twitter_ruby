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

    context '#valid_save?' do
      it 'should valid save' do
        params = {
          text: 'aaa'
        }

        hashtag = Hashtag.new(params)

        expect(hashtag.valid_save?).to be_truthy
      end

      it 'should invalid save' do
        params = {
          text: ''
        }

        hashtag = Hashtag.new(params)

        expect(hashtag.valid_save?).to be_falsey
      end
    end
  end

  describe 'convert sql result' do
    context '.convert_sql_result_to_array' do
      it 'should return filled array' do
        sql_result = [
          { 'id' => 1, 'text' => 'aaa' },
          { 'id' => 2, 'text' => 'bbb' }
        ]

        expected_hashtag_1 = Hashtag.new({ id: 1, text: 'aaa' })
        expected_hashtag_2 = Hashtag.new({ id: 2, text: 'bbb' })

        actual_array = Hashtag.convert_sql_result_to_array(sql_result)
        expected_array = [expected_hashtag_1, expected_hashtag_2]

        expect(expected_array.size).to eq(actual_array.size)
        (0..expected_array.size - 1).each do |i|
          expect(actual_array[i].id).to eq(expected_array[i].id)
          expect(actual_array[i].text).to eq(expected_array[i].text)
        end
      end

      it 'should return empty array' do
        sql_result = nil

        actual_array = Hashtag.convert_sql_result_to_array(sql_result)
        expected_array = []

        expect(expected_array).to eq(actual_array)
      end
    end
  end
end