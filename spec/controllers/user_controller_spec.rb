require_relative '../../controllers/user_controller'

describe UserController do
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
    end
  end
end