require_relative '../../controllers/hashtag_controller'

describe HashtagController do
  $client = create_db_client

  before(:each) do
    $client.query('SET FOREIGN_KEY_CHECKS = 0')
    $client.query('TRUNCATE table hashtags')
  end

  after(:all) do
    $client.query('TRUNCATE table hashtags')
    $client.query('SET FOREIGN_KEY_CHECKS = 1')
  end

  describe 'create' do
    context '#save' do
      it 'should save data to db' do
        params = {
          'text'=> 'aaa'
        }

        HashtagController.create(params)

        result = $client.query('SELECT * FROM hashtags')
        expect(result.size).to eq(1)

        saved_hashtag = result.first

        expect(saved_hashtag['text']).to eq(params['text'])
      end
    end
  end

  describe 'read' do
    context '#find_all' do
      it 'should get data from db' do
        params_1 = {
          'text'=> 'aaa'
        }
        expected_data_1 = {
          text: params_1['text']
        }

        hashtag_1 = Hashtag.new(params_1)
        hashtag_1.save

        params_2 = {
          'text'=> 'bbb'
        }
        expected_data_2 = {
          text: params_2['text']
        }

        expected_data = { 'hashtag': [expected_data_1, expected_data_2] }
        hashtag_2 = Hashtag.new(params_2)
        hashtag_2.save

        status, message, data = HashtagController.find_all
        expect(status).to eq(OK)
        expect(message).to eq('success')
        expect(data).to eq(expected_data)
      end
    end

    context '#find_by_id' do
      it 'should get data from db' do
        params = {
          'text'=> 'aaa'
        }
        expected_data = {
          text: params['text']
        }
        id = 1

        hashtag = Hashtag.new(params)
        hashtag.save

        status, message, data = HashtagController.find_by_id(id)
        expect(status).to eq(OK)
        expect(message).to eq('success')
        expect(data).to eq(expected_data)
      end

      it 'should get data from db' do
        params = {
          'text'=> 'aaa'
        }
        id = 2

        hashtag = Hashtag.new(params)
        hashtag.save

        status, message, data = HashtagController.find_by_id(id)
        expect(status).to eq(NOT_FOUND)
        expect(message).to eq('cannot find your hashtag id')
        expect(data).to eq(nil)
      end
    end
  end
end