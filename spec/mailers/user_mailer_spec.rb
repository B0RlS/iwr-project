require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) do
    double('John Doe', name: 'John', email: 'johndoe@email.com',
      activation_token: 'igtRo_75YGooIuRbOCesyw',
      reset_token: 'OkTq_stL9VmJNBV4P7v8jg')
  end

  context "account_activation" do
    subject { described_class.account_activation(user) }

    it "renders the headers" do
      expect(subject.subject).to eq("Account activation")
      expect(subject.to).to eq(["johndoe@email.com"])
      expect(subject.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(subject.body.encoded).to match("Hello,")
    end
  end

  context "password_reset" do
    subject { described_class.password_reset(user) }

    it "renders the headers" do
      expect(subject.subject).to eq("Password reset")
      expect(subject.to).to eq(["johndoe@email.com"])
      expect(subject.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(subject.body.encoded).to match("To reset")
    end
  end

end
