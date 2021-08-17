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
      it 'should not valid negative integer' do
        params = {
          id: -1
        }

        user = User.new(params)
        puts user.valid_id?
        expect(user.valid_id?).to be_falsey
      end
    end
  end
end