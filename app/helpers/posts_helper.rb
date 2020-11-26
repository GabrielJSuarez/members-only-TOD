module PostsHelper

  def flash_messages_bootstrap
    content = content_tag(:button, content_tag(:span, '&times;'.html_safe, 'aria-hidden' => 'true'), type: 'button', class: 'close', 'data-dismiss' => 'alert', 'aria-label' => 'Close')
    2
    if flash[:notice]
      content_tag(:div, nil, class: 'alert alert-success alert-dismissible fade show', role: 'alert') do
        content_tag(:strong, flash[:notice]) + content

      end
    elsif flash[:alert]
      content_tag(:div, nil, class: 'alert alert-danger alert-dismissible fade show', role: 'alert') do
        content_tag(:strong, flash[:alert]) + content
      end
    end
  end

  def member?(post_user_name)
    user_signed_in? ? post_user_name : 'UNDERCOVER MEMBER'
  end

  def navbar_user_session
    if user_signed_in?
      content_tag(:li, (link_to 'Log out', destroy_user_session_path, method: :delete, class: 'nav-link'), class: 'nav-item')
    else
      content_tag(:li, (link_to 'Sign Up', new_user_registration_path, class: 'nav-link'), class: 'nav-item') +
        content_tag(:li, (link_to 'Sign In', new_user_session_path, class: 'nav-link'), class: 'nav-item')
    end
  end

  def show_creation
    if user_signed_in?
      content_tag(:div, (render 'posts/profile'), class: 'col-md-3') +
          content_tag(:div, (render 'posts/new-post', post: @post), class: 'col-md-6') +
          content_tag(:div, (render 'posts/members'), class: 'col-md-3')
    end
  end

  def post_errors?(post)
    if post.errors.any?
      content_tag(:div, nil, class: 'alert alert-danger text-center col-md-4 mx-auto', role: 'alert') do
        content_tag(:h4, "#{pluralize(post.errors.count, 'error')} prohibited this post from being saved: ")
      end
    end
  end

  def show_posts(posts)
    posts.each do |p|
      concat(
        content_tag(:div, nil, class: 'card col-md-5 mx-auto my-3') do
          content_tag(:h5, "@#{member?(p.user.name)}", class: 'card-header text-primary') +
              content_tag(:div, nil, class: 'card-body') do
                    content_tag(:p, p.content, class: 'card-content font-weight-bold content-font') +
                    if user_signed_in?
                      (link_to 'Show Post', p, class: 'btn btn-primary text-light mr-2') +
                          if p.user == current_user
                            (link_to 'Edit Post', edit_post_path(p), class: 'btn btn-warning text-dark mr-2') +
                            (link_to 'Delete Post', post_path(p), method: :delete, data: { confirm: 'Are you sure?'}, class: 'btn btn-danger text-light mr-2')
                          end
                    end

              end
        end
      )
    end
  end

  def user_post?
    content_tag(:h6, nil, class: 'card-text pt-2') do
      if current_user.posts.any?
        current_user.posts.last.content
      else
        'Nothing to show'
      end
    end
  end

  def user_post_time?
    content_tag(:p, nil, class: 'card-text') do
      content_tag(:small, nil, class: 'text-light') do
        if current_user.posts.any?
          "#{time_ago_in_words(current_user.posts.last.created_at)} Ago"
        else
          'Nothing created'
        end
      end
    end
  end

  def show_members
    @user = User.all
    content_tag(:div, nil, class: 'card') do
      content_tag(:div, 'Member List', class: 'card-header') +
          content_tag(:ul, nil, class: 'list-group list-group-flush') do
            @user.each do |user|
              concat(content_tag(:li, "@#{user.name}", class: 'list-group-item'))
            end
          end
    end
  end
end


