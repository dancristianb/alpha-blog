require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(
      username: 'dan2',
      email: 'dan2@example.com',
      password: 'password'
    )

    sign_in_as(@user)
  end

  test 'create article' do
    article_title = 'IT article'

    get new_article_path
    assert_response :success
    assert_match("Creating a new article", response.body)
    assert_difference('Article.count', 1) do
      post articles_path, params: {
        article: {
          title: article_title,
          description: 'integration test description',
          category_ids: []
        }
      }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_match("Article was successfully created", response.body)
    assert_match(article_title, response.body)
    assert_match("by #{@user.username}", response.body)
  end
end
