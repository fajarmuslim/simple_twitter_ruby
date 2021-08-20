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
end