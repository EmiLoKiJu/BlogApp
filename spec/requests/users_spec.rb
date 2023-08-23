require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    subject { User.new(name: 'Monika', posts_counter: 0) }
    before { subject.save }

    it "works" do
      get users_path
      expect(response).to have_http_status(200)
    end

    it "renders the correct template" do
      get users_path
      expect(response).to render_template(:index)
    end

    it "includes correct placeholders in body" do
      get users_path
      expect(response.body).to include("Monika")
    end
  end

  describe "GET /user" do
    subject { User.new(name: 'Monika', posts_counter: 0) }
    before { subject.save }

    it "works" do
      get user_path(subject.id)
      expect(response).to have_http_status(200)
    end

    it "renders the correct template" do
      get user_path(subject.id)
      expect(response).to render_template(:show)
    end

    it "includes correct placeholders in body" do
      get user_path(subject.id)
      expect(response.body).to include("Monika")
    end
  end
end
