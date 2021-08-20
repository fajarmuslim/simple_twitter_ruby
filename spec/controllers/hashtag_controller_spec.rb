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
          text: 'aaa'
        }

        HashtagController.create(params)

        result = $client.query('SELECT * FROM hashtags')
        expect(result.size).to eq(1)

        saved_hashtag = result.first

        expect(saved_hashtag['text']).to eq(params[:text])
      end
    end
  end

  describe 'read' do
    context '#find_all' do
      it 'should get data from db' do
        params_1 = {
          text: 'aaa'
        }

        hashtag_1 = Hashtag.new(params_1)
        hashtag_1.save

        params_2 = {
          text: 'bbb'
        }

        hashtag_2 = Hashtag.new(params_2)
        hashtag_2.save

        result = HashtagController.find_all
        expect(result.size).to eq(2)

        result_1 = result[0]
        expect(result_1.text).to eq(params_1[:text])

        result_2 = result[1]
        expect(result_2.text).to eq(params_2[:text])
      end
    end
  end
end