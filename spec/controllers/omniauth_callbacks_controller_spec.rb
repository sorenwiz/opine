require 'rails_helper'
require 'devise'

describe OmniauthCallbacksController do

  describe "#facebook user" do

    before(:each) do
      stub_env_for_omniauth
    end

    it "should be asked for email if needed" do
      request.env["omniauth.auth"].info.email = nil
      get 'facebook'
      expect(subject.current_user).to be_nil
    end

    it "should be authenticated if have email" do
      request.env["omniauth.auth"].info.email = "abc@def.com"
      get 'facebook'
      expect(subject.current_user).not_to be_nil
      expect(subject).to redirect_to(root_path)
    end

    it "should not have a current_user by default" do
      expect(subject.current_user).to be_nil
    end

    it 'redirects' do
      request.env["omniauth.auth"].info.email = "abc@def.com"
      request.env["omniauth.params"] = {origin: concept_path}.stringify_keys
      get 'facebook', origin: concept_path
      expect(subject).to redirect_to(concept_path)
    end

    it 'handles utf8 in redirects' do
      request.env["omniauth.auth"].info.email = "abc@def.com"
      request.env["omniauth.params"] = {origin: '/utf8=✓&something=yes'}.stringify_keys
      get 'facebook', origin: '/utf8=✓&something=yes'
      expect(subject).to redirect_to('/utf8=&something=yes')
    end

  end

end

def stub_env_for_omniauth
  request.env["devise.mapping"] = Devise.mappings[:user]
  env = {
      "omniauth.auth" => {
          "provider" => "facebook",
          "uid" => "1234",
          "info" => {
              "first_name" => "John",
              "email" => "abc@def.com",
              "last_name" => "Doe",
              "image" => "http://graph.facebook.com/1234/picture",
          },
      }
  }
  request.env["omniauth.auth"] = OmniAuth::AuthHash.new(env["omniauth.auth"])
end