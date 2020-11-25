module PostsHelper

  def member?(post)
    user_signed_in? ? post.user.name : 'RESTRICTED'
  end

  def navbar_signed_in?
    user_signed_in? ? "#{(current_user.username).capitalize}'s session" : 'Log in'
  end

  def navbar_user_session
    if user_signed_in?
      content_tag(:li, (link_to 'Log out', destroy_user_session_path, method: :delete, class: 'nav-link'), class: 'nav-item')
    else
      content_tag(:li, (link_to 'Sign Up', new_user_registration_path, class: 'nav-link'), class: 'nav-item') +
          content_tag(:li, (link_to 'Sign In', new_user_session_path, class: 'nav-link'), class: 'nav-item')
    end
  end

  def show_posts(post)
    content_tag(:tbody) do
      post.each do |p|
        concat(content_tag(:tr) do
          content_tag(:td, "#{p.title}") +
              content_tag(:td, "#{p.content}") +
              content_tag(:td, "#{member?(p)}") +
              content_tag(:td) do
                link_to 'Show', p
              end +
              content_tag(:td) do
                link_to 'Edit', edit_post_path(p)
              end +
              content_tag(:td) do
                link_to 'Destroy', p, method: :delete, data: { confirm: 'Are you sure?' }
              end
        end)
      end
    end
  end

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
end


