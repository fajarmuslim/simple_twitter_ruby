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
    context '#valid_id?' do
      it 'should valid positive integer' do
        params = {
          id: 1
        }

        user = User.new(params)

        expect(user.valid_id?).to be_truthy
      end

      it 'should invalid negative integer' do
        params = {
          id: -1
        }

        user = User.new(params)

        expect(user.valid_id?).to be_falsey
      end

      it 'should invalid nol integer' do
        params = {
          id: 0
        }

        user = User.new(params)

        expect(user.valid_id?).to be_falsey
      end

      it 'should invalid if type is not integer' do
        params = {
          id: 'aaa'
        }

        user = User.new(params)

        expect(user.valid_id?).to be_falsey
      end
    end

    context '#valid_username?' do
      it 'should valid username' do
        params = {
          username: 'fajar'
        }

        user = User.new(params)

        expect(user.valid_username?).to be_truthy
      end

      it 'should invalid empty string' do
        params = {
          username: ''
        }

        user = User.new(params)

        expect(user.valid_username?).to be_falsey
      end

      it 'should invalid type not string' do
        params = {
          username: 1
        }

        user = User.new(params)

        expect(user.valid_username?).to be_falsey
      end

      it 'should invalid exceed 255 character' do
        params = {
          username: 'a' * 256
        }

        user = User.new(params)

        expect(user.valid_username?).to be_falsey
      end
    end

    context '#valid_email?' do
      it 'should valid email' do
        params = {
          email: 'fajarmuslim@domain.com'
        }

        user = User.new(params)

        expect(user.valid_email?).to be_truthy
      end

      it 'should invalid empty string' do
        params = {
          email: ''
        }

        user = User.new(params)

        expect(user.valid_email?).to be_falsey
      end

      it 'should invalid type not string string' do
        params = {
          email: 1
        }

        user = User.new(params)

        expect(user.valid_email?).to be_falsey
      end

      it 'should invalid exceed 255 character' do
        params = {
          email: 'a' * 256
        }

        user = User.new(params)

        expect(user.valid_email?).to be_falsey
      end

      it 'should invalid email pattern' do
        params = {
          email: 'domain.com'
        }

        user = User.new(params)

        expect(user.valid_email_pattern?).to be_falsey
      end
    end

    context '#valid_email_pattern?' do
      it 'should valid email pattern' do
        params = {
          email: 'fajarmuslim@domain.com'
        }

        user = User.new(params)

        expect(user.valid_email_pattern?).to be_truthy
      end

      it 'should invalid email pattern' do
        params = {
          email: '@domain.com'
        }

        user = User.new(params)

        expect(user.valid_email_pattern?).to be_falsey
      end
    end

    context '#valid_bio?' do
      it 'should valid bio' do
        params = {
          bio: 'bio description'
        }

        user = User.new(params)

        expect(user.valid_bio?).to be_truthy
      end

      it 'should invalid not string' do
        params = {
          bio: 1
        }

        user = User.new(params)

        expect(user.valid_bio?).to be_falsey
      end

      it 'should invalid exceed 1000 char' do
        params = {
          bio: 'a' * 1001
        }

        user = User.new(params)

        expect(user.valid_bio?).to be_falsey
      end
    end
  end

  context '#valid_save?' do
    it 'should valid save' do
      params = {
        username: 'fajar',
        email: 'fajar@domain.com',
        bio: 'fajar bio'
      }

      user = User.new(params)

      expect(user.valid_save?).to be_truthy
    end

    it 'should invalid save' do
      params = {
        username: 'fajar',
        email: 'domain.com',
        bio: 'fajar bio'
      }

      user = User.new(params)

      expect(user.valid_save?).to be_falsey
    end
  end

  describe 'create' do
    context '#save' do
      it 'should receive correct query' do
        params = {
          username: 'fajar',
          email: 'fajar@domain.com',
          bio: 'fajar bio'
        }

        user = User.new(params)

        mock_client = double
        allow(Mysql2::Client).to receive(:new).and_return(mock_client)
        allow(mock_client).to receive(:last_id).and_return(1)

        expect(mock_client).to receive(:query).with("INSERT INTO users(username, email, bio) VALUES ('#{user.username}', '#{user.email}', '#{user.bio}')")
        expect(user.save).not_to be_nil
      end
    end
  end
end