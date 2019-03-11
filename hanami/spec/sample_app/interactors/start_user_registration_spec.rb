RSpec.describe StartUserRegistration, type: :interactor do
  let(:interactor) {
    described_class.new(
      mailer: mailer, repository: repository, token_generator: token_generator
    )
  }
  let(:token_generator) { -> { 'generated_token' } }

  context 'when an invalid email is specified' do
    let(:params) { { email: 'invalid' } }
    let(:mailer) { double('mailer') }
    let(:repository) { double('repository') }

    describe 'result' do
      subject { interactor.call(params) }

      it 'should not be successful' do
        expect(subject.successful?).to eq false
      end

      it 'should record some errors' do
        expect(subject.errors).to eq ['Email is invalid']
      end
    end
  end

  context 'when a valid email is specified' do
    let(:params) { { email: 'test@example.com' } }
    let(:mailer) { double('mailer', deliver: nil) }
    let(:repository) { double('repository') }

    before do
      allow(repository).to receive(:transaction).and_yield
      allow(repository).to receive(:create) { |data| UserRegistration.new(data) }
    end

    describe 'result' do
      subject { interactor.call(params) }

      it 'should be successful' do
        expect(subject.successful?).to eq true
      end
    end

    describe 'mailer' do
      subject { mailer }

      let(:expected_user_registration) {
        an_object_having_attributes(
          email: params[:email],
          confirmation_token: token_generator.call
        )
      }

      before do
        interactor.call(params)
      end

      it { is_expected.to have_received(:deliver).once.with(user_registration: expected_user_registration) }
    end

    describe 'repository' do
      subject { repository }

      let(:expected_data) {
        { email: params[:email], confirmation_token: token_generator.call }
      }

      before do
        interactor.call(params)
      end

      it { is_expected.to have_received(:create).once.with(expected_data) }
    end
  end
end
