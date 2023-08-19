require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe "associations" do
    it { should have_many(:comments).with_foreign_key(:author_id) }
    it { should have_many(:likes).with_foreign_key(:author_id) }
    it { should have_many(:posts).with_foreign_key(:author_id) }
  end

  describe "methods" do
    let(:user) { create(:user) }

    it "returns recent posts" do
      user.posts.create(title: "Post 1", text: "Text 1")
      user.posts.create(title: "Post 2", text: "Text 2")
      user.posts.create(title: "Post 3", text: "Text 3")
      user.posts.create(title: "Post 4", text: "Text 4")
      user.posts.create(title: "Post 5", text: "Text 5")
      
      recent_posts = user.recent_posts(2)
      expect(recent_posts.size).to eq(2)

      recent_posts = user.recent_posts()
      expect(recent_posts.size).to eq(3)
    end
  end
end
