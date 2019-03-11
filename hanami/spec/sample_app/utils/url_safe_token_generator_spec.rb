RSpec.describe Utils::UrlSafeTokenGenerator do
  describe '.call' do
    subject { described_class.call }

    it { is_expected.not_to be_empty }
    it { is_expected.not_to be_match(URI::UNSAFE) }
  end
end
