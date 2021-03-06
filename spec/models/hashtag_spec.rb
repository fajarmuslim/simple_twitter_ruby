require_relative '../../models/hashtag'

describe Hashtag do
  $client = create_db_client

  before(:each) do
    $client.query('SET FOREIGN_KEY_CHECKS = 0')
    $client.query('TRUNCATE table hashtags')
  end

  after(:all) do
    $client.query('TRUNCATE table hashtags')
    $client.query('SET FOREIGN_KEY_CHECKS = 1')
  end

  describe 'initialize' do
    context '.new' do
      it 'should create object' do
        params = {
          'id'=> 1,
          'text'=> 'ppkm'
        }

        hashtag = Hashtag.new(params)

        expect(hashtag.id).to eq(params['id'])
        expect(hashtag.text).to eq(params['text'])
      end
    end
  end

  describe 'validity' do
    context '#valid_id?' do
      it 'should valid positive integer' do
        params = {
          'id'=> 1
        }

        hashtag = Hashtag.new(params)

        expect(hashtag.valid_id?).to be_truthy
      end

      it 'should invalid negative integer' do
        params = {
          'id'=> -1
        }

        hashtag = Hashtag.new(params)

        expect(hashtag.valid_id?).to be_falsey
      end

      it 'should invalid nol integer' do
        params = {
          'id'=> 0
        }

        hashtag = Hashtag.new(params)

        expect(hashtag.valid_id?).to be_falsey
      end

      it 'should invalid if type is not integer' do
        params = {
          'id'=> 'aaa'
        }

        hashtag = Hashtag.new(params)

        expect(hashtag.valid_id?).to be_falsey
      end
    end

    context '#valid_text?' do
      it 'should valid text' do
        params = {
          'text'=> 'ppkm'
        }

        hashtag = Hashtag.new(params)

        expect(hashtag.valid_text?).to be_truthy
      end

      it 'should invalid empty string' do
        params = {
          'text'=> ''
        }

        hashtag = Hashtag.new(params)

        expect(hashtag.valid_text?).to be_falsey
      end

      it 'should invalid type not string' do
        params = {
          'text'=> 1
        }

        hashtag = Hashtag.new(params)

        expect(hashtag.valid_text?).to be_falsey
      end

      it 'should invalid exceed 999 character' do
        params = {
          'text'=> 'a' * 1000
        }

        hashtag = Hashtag.new(params)

        expect(hashtag.valid_text?).to be_falsey
      end
    end

    context '#valid_save?' do
      it 'should valid save' do
        params = {
          'text'=> 'aaa'
        }

        hashtag = Hashtag.new(params)

        expect(hashtag.valid_save?).to be_truthy
      end

      it 'should invalid save' do
        params = {
          'text'=> ''
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

        expected_hashtag_1 = Hashtag.new({ 'id'=> 1, 'text'=> 'aaa' })
        expected_hashtag_2 = Hashtag.new({ 'id'=> 2, 'text'=> 'bbb' })

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

  describe 'create' do
    context '#save' do
      it 'should receive correct query' do
        params = {
          'text'=> 'fajar'
        }

        hashtag = Hashtag.new(params)

        mock_client = double
        allow(Mysql2::Client).to receive(:new).and_return(mock_client)
        allow(mock_client).to receive(:last_id).and_return(1)

        expect(mock_client).to receive(:query).with("INSERT INTO hashtags(text) VALUES ('#{hashtag.text}')")
        expect(hashtag.save).not_to be_nil
      end

      it 'should save data to db' do
        params = {
          'text'=> 'fajar'
        }

        hashtag = Hashtag.new(params)
        hashtag.save

        result = $client.query('SELECT * FROM hashtags')
        expect(result.size).to eq(1)

        saved_hashtag = result.first

        expect(saved_hashtag['text']).to eq(params['text'])
      end
    end
  end

  describe 'read' do
    context '#find_all' do
      it 'should receive correct query' do
        mock_client = double
        allow(Mysql2::Client).to receive(:new).and_return(mock_client)

        expect(mock_client).to receive(:query).with('SELECT * FROM hashtags')
        expect(Hashtag.find_all).to eq([])
      end

      it 'should get data from db' do
        params_1 = {
          'text'=> 'aaa'
        }

        hashtag_1 = Hashtag.new(params_1)
        hashtag_1.save

        params_2 = {
          'text'=> 'bbb'
        }

        hashtag_2 = Hashtag.new(params_2)
        hashtag_2.save

        result = Hashtag.find_all
        expect(result.size).to eq(2)

        result_1 = result[0]
        expect(result_1.text).to eq(params_1['text'])

        result_2 = result[1]
        expect(result_2.text).to eq(params_2['text'])
      end
    end
    context '#find_by_id' do
      it 'should receive correct query' do
        id = 1

        mock_client = double
        allow(Mysql2::Client).to receive(:new).and_return(mock_client)

        expect(mock_client).to receive(:query).with("SELECT * FROM hashtags WHERE id = #{id}")
        expect(Hashtag.find_by_id(id)).to eq(nil)
      end

      it 'should get data from db' do
        params = {
          'text'=> 'aaa'
        }

        hashtag = Hashtag.new(params)
        hashtag.save

        result = Hashtag.find_by_id(1)
        expect(result.text).to eq(params['text'])
      end
    end
  end
end