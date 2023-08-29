require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase

  #########################
  # Tests for post index
  #########################

  test 'display the user profile picture' do
    visit user_posts_path(users(:one))
    sleep(1)

    assert_selector('img[alt="Profile photo"]', count: 1)
  end

  test 'display the user username' do
    visit user_posts_path(users(:one))

    assert_text 'username1'
  end

  test 'display the number of posts the user has written' do
    visit user_posts_path(users(:one))

    assert_text "posts counter: #{users(:one).posts_counter}"
  end

  test 'display a post title and body' do
    visit user_posts_path(users(:one))
    users(:one).posts.first(1).each do |post|
      assert_text post.title
      assert_text post.text.slice(0, 165)
    end
  end

  test 'display the first comments on a post' do
    visit user_posts_path(users(:one))

    users(:one).posts.first(2).each do |post|
      first_comment = post.comments.first
      assert_text first_comment.text.slice(0, 165) if first_comment
    end
  end

  test 'display how many comments a post has' do
    visit user_posts_path(users(:one))

    users(:one).posts.first(2).each do |post|
      assert_text "Comments: #{post.comments_counter}"
    end
  end

  test 'display how many likes a post has' do
    visit user_posts_path(users(:one))

    users(:one).posts.first(2).each do |post|
      assert_text "Likes: #{post.likes_counter}"
    end
  end

  test 'display a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(users(:one))

    assert_selector('button', text: 'Next Page')
  end

  test 'when click on a post, it redirects me to that post show page' do
    visit user_posts_path(users(:one))

    post1 = users(:one).posts.first
    click_link post1.title
    assert_current_path(user_post_path(users(:one), post1))
  end

  #########################
  # Tests for post show
  #########################

  # I can see the post's title.
  test 'display the post title' do
    visit user_post_path(users(:one), posts(:one))
    sleep(1)

    assert_text posts(:one).title
  end
  # I can see who wrote the post.
  test 'display who wrote the post' do
    visit user_post_path(users(:one), posts(:one))

    assert_text posts(:one).title
  end

  # I can see how many comments it has.

  # I can see how many likes it has.

  # I can see the post body.

  # I can see the username of each commentor.

  # I can see the comment each commentor left.

end