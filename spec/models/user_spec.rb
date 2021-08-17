require_relative '../../models/user'

describe User do
  describe 'initialize' do
    context '.new' do
      it 'should create object' do
        params = {
          id: 1,
          username: 'andi',
          email: 'andi@gmail.com',
          bio: 'andi si bolang'
        }

        user = User.new(params)

        expect(user.id).to eq(params[:id])
        expect(user.username).to eq(params[:username])
        expect(user.email).to eq(params[:email])
        expect(user.bio).to eq(params[:bio])
        expect(user.posts).to eq([])
        expect(user.comments).to eq([])
      end
    end
  end

  describe 'validity' do
    context '#id_valid?' do
      it 'should valid positive integer' do
        params = {
          id: 1
        }

        user = User.new(params)

        expect(user.valid_id?).to be_truthy
      end

      it 'should not valid negative integer' do
        params = {
          id: -1
        }

        user = User.new(params)

        expect(user.valid_id?).to be_falsey
      end

      it 'should not valid nol integer' do
        params = {
          id: 0
        }

        user = User.new(params)

        expect(user.valid_id?).to be_falsey
      end

      it 'should not valid if type is not integer' do
        params = {
          id: 'aaa'
        }

        user = User.new(params)

        expect(user.valid_id?).to be_falsey
      end
    end

    context '#username_valid?' do
      it 'should valid username' do
        params = {
          username: 'fajar'
        }

        user = User.new(params)

        expect(user.valid_username?).to be_truthy
      end

      it 'should not valid empty string' do
        params = {
          username: ''
        }

        user = User.new(params)

        expect(user.valid_username?).to be_falsey
      end

      it 'should not valid type not string' do
        params = {
          username: 1
        }

        user = User.new(params)

        expect(user.valid_username?).to be_falsey
      end

      it 'should not valid exceed 255 character' do
        params = {
          username: 'a' * 256
        }

        user = User.new(params)

        expect(user.valid_username?).to be_falsey
      end
    end
  end
end