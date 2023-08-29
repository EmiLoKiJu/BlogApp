require 'rails_helper'

RSpec.describe 'Users index', type: :system do
  fixtures :users, :posts, :comments, :likes

  it 'displays the username of all users' do
    visit users_path
    sleep(1)

    expect(page).to have_text('username1')
    expect(page).to have_text('username2')
  end

  it 'displays the profile picture for each user' do
    visit users_path

    expect(page).to have_selector('img[alt="Profile photo"]', count: 2)
  end

  it 'displays the number of posts each user has written' do
    visit users_path

    expect(page).to have_text("posts counter: #{users(:one).posts_counter}")
  end

  it 'redirects to the user show page' do
    visit users_path
    click_link users(:one).name

    expect(page).to have_current_path(user_path(users(:one)))
  end
end
