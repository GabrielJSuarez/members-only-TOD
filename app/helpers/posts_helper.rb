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

  def member?(post)
    user_signed_in? ? post.user.name : 'RESTRICTED'
  end

  def navbar_signed_in?
    user_signed_in? ? "#{current_user.username.capitalize}'s session" : 'Log in'
  end

  def navbar_user_session
    if user_signed_in?
      content_tag(:li, (link_to 'Log out', destroy_user_session_path, method: :delete, class: 'nav-link'), class: 'nav-item')
    else
      content_tag(:li, (link_to 'Sign Up', new_user_registration_path, class: 'nav-link'), class: 'nav-item') +
        content_tag(:li, (link_to 'Sign In', new_user_session_path, class: 'nav-link'), class: 'nav-item')
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
        content_tag(:div, nil, class: 'card col-md-5 mx-auto my-4') do
          content_tag(:h5, member?(p), class: 'card-header') +
              content_tag(:div, nil, class: 'card-body') do
                content_tag(:h5, p.title, class: 'card-title') +
                    content_tag(:p, p.content, class: 'card-content') +
                    (link_to 'Show Post', p, class: 'btn btn-primary text-light')
              end
        end
      )
    end
  end
end



