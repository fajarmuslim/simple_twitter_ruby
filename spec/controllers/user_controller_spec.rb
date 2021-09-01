require_relative '../../controllers/user_controller'
require_relative '../../constant/status_code'

describe UserController do
  $client = create_db_client

  before(:each) do
    $client.query('SET FOREIGN_KEY_CHECKS = 0')
    $client.query('TRUNCATE table users')
  end

  after(:all) do
    $client.query('TRUNCATE table users')
    $client.query('SET FOREIGN_KEY_CHECKS = 1')
  end

  describe 'create' do
    context '#create' do
      it 'should create user in db' do
        params = {
          'username'=> 'fajar',
          'email'=> 'fajar@domain.com',
          'bio'=> 'fajar bio'
        }

        expected_data = {
          username: params['username'],
          email: params['email'],
          bio: params['bio']
        }

        status, message, data = UserController.create(params)
        expect(status).to eq(CREATED)
        expect(message).to eq("success created user")
        expect(data).to eq(expected_data)


        result = $client.query('SELECT * FROM users')
        expect(result.size).to eq(1)

        saved_user = result.first

        expect(saved_user['username']).to eq(params['username'])
        expect(saved_user['email']).to eq(params['email'])
        expect(saved_user['bio']).to eq(params['bio'])
      end

      it 'should error username' do
        params = {
          'username'=> 'fajar',
          'email'=> 'fajar@domain.com',
          'bio'=> 'fajar bio'
        }

        UserController.create(params)

        status, message, data = UserController.create(params)
        expect(status).to eq(BAD_REQUEST)
        expect(message).to eq("Duplicate entry '#{params['username']}' for key 'users.username'")
        expect(data).to eq(nil)
      end

      it 'should error email' do
        params_1 = {
          'username'=> 'aaa',
          'email'=> 'fajar@domain.com',
          'bio'=> 'fajar bio'
        }

        params_2 = {
          'username'=> 'bbb',
          'email'=> 'fajar@domain.com',
          'bio'=> 'fajar bio'
        }

        UserController.create(params_1)

        status, message, data = UserController.create(params_2)
        expect(status).to eq(BAD_REQUEST)
        expect(message).to eq("Duplicate entry '#{params_1['email']}' for key 'users.email'")
        expect(data).to eq(nil)
      end
    end
  end

  describe 'read' do
    context '#find_all' do
      it 'should get all user in db' do
        params_1 = {
          'username'=> 'fajar1',
          'email'=> 'fajar1@domain.com',
          'bio'=> 'fajar1 bio'
        }
        expected_data_1 = {
          username: params_1['username'],
          email: params_1['email'],
          bio: params_1['bio']
        }

        user_1 = User.new(params_1)
        user_1.save

        params_2 = {
          'username'=> 'fajar2',
          'email'=> 'fajar2@domain.com',
          'bio'=> 'fajar2 bio'
        }

        expected_data_2 = {
          username: params_2['username'],
          email: params_2['email'],
          bio: params_2['bio']
        }
        expected_data = {'users': [expected_data_1, expected_data_2]}

        user_2 = User.new(params_2)
        user_2.save

        status, message, data = UserController.find_all
        expect(status).to eq(OK)
        expect(message).to eq('success')
        expect(data).to eq(expected_data)
      end
    end

    context '#find_by_id' do
      it 'should get data from db' do
        params = {
          'username'=> 'fajar1',
          'email'=> 'fajar1@domain.com',
          'bio'=> 'fajar1 bio'
        }
        expected_data = {
          username: params['username'],
          email: params['email'],
          bio: params['bio']
        }
        id = 1

        user = User.new(params)
        user.save

        status, message, data = UserController.find_by_id(id)
        expect(status).to eq(OK)
        expect(message).to eq('success')
        expect(data).to eq(expected_data)
      end

      it 'should empty result' do
        params = {
          'username'=> 'fajar',
          'email'=> 'fajar@domain.com',
          'bio'=> 'fajar bio'
        }
        id = 2

        user = User.new(params)
        user.save

        status, message, data = UserController.find_by_id(id)
        expect(status).to eq(NOT_FOUND)
        expect(message).to eq("cannot find your user id")
        expect(data).to eq(nil)
      end
    end
  end
end