require_relative '../../controllers/user_controller'

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
          username: 'fajar',
          email: 'fajar@domain.com',
          bio: 'fajar bio'
        }

        UserController.create(params)

        result = $client.query('SELECT * FROM users')
        expect(result.size).to eq(1)

        saved_user = result.first

        expect(saved_user['username']).to eq(params[:username])
        expect(saved_user['email']).to eq(params[:email])
        expect(saved_user['bio']).to eq(params[:bio])
      end

      it 'should error username' do
        params = {
          username: 'fajar',
          email: 'fajar@domain.com',
          bio: 'fajar bio'
        }

        UserController.create(params)

        begin
          UserController.create(params)
        rescue Mysql2::Error => exception
          response = exception.message
        ensure
          expect(response).to eq("Duplicate entry '#{params[:username]}' for key 'users.username'")
        end
      end

      it 'should error email' do
        params_1 = {
          username: 'aaa',
          email: 'fajar@domain.com',
          bio: 'fajar bio'
        }

        params_2 = {
          username: 'bbb',
          email: 'fajar@domain.com',
          bio: 'fajar bio'
        }

        UserController.create(params_1)

        begin
          UserController.create(params_2)
        rescue Mysql2::Error => exception
          response = exception.message
        ensure
          expect(response).to eq("Duplicate entry '#{params_1[:email]}' for key 'users.email'")
        end
      end
    end
  end

  describe 'read' do
    context '#find_all' do
      it 'should get all user in db' do
        params_1 = {
          username: 'fajar1',
          email: 'fajar1@domain.com',
          bio: 'fajar1 bio'
        }

        user_1 = User.new(params_1)
        user_1.save

        params_2 = {
          username: 'fajar2',
          email: 'fajar2@domain.com',
          bio: 'fajar2 bio'
        }

        user_2 = User.new(params_2)
        user_2.save

        result = UserController.find_all
        expect(result.size).to eq(2)

        result_1 = result[0]
        expect(result_1.username).to eq(params_1[:username])
        expect(result_1.email).to eq(params_1[:email])
        expect(result_1.bio).to eq(params_1[:bio])

        result_2 = result[1]
        expect(result_2.username).to eq(params_2[:username])
        expect(result_2.email).to eq(params_2[:email])
        expect(result_2.bio).to eq(params_2[:bio])
      end
    end

    context '#find_by_id' do
      it 'should get data from db' do
        params = {
          username: 'fajar1',
          email: 'fajar1@domain.com',
          bio: 'fajar1 bio'
        }
        id = 1

        user = User.new(params)
        user.save

        result = UserController.find_by_id(id)
        expect(result.username).to eq(params[:username])
        expect(result.email).to eq(params[:email])
        expect(result.bio).to eq(params[:bio])
      end
    end
  end
end