require 'rails_helper'

RSpec.describe 'Post show', type: :system do
  fixtures :users, :posts, :comments, :likes

  it 'displays the post title' do
    visit user_post_path(users(:one), posts(:one))
    sleep(1)

    expect(page).to have_text(posts(:one).title)
  end

  it 'displays who wrote the post' do
    visit user_post_path(users(:one), posts(:one))

    expect(page).to have_text(posts(:one).title)
  end

  it 'displays how many comments it has' do
    visit user_post_path(users(:one), posts(:one))

    expect(page).to have_text("Comments: #{posts(:one).comments_counter}")
  end

  it 'displays how many likes it has' do
    visit user_post_path(users(:one), posts(:one))

    expect(page).to have_text("Likes: #{posts(:one).likes_counter}")
  end

  it 'displays the post body' do
    visit user_post_path(users(:one), posts(:one))

    expect(page).to have_text(posts(:one).text)
  end

  it 'displays the username and the comment of each commentor' do
    visit user_post_path(users(:one), posts(:one))

    posts(:one).comments.each do |comment|
      expect(page).to have_text(comment.author.name)
      expect(page).to have_text(comment.text)
    end
  end
end
