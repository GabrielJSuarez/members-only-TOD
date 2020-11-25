module PostsHelper

  def member?(post)
    user_signed_in? ? post.user.name : 'RESTRICTED'
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

  def display_propper_flash
    if flash[:notice]
      content_tag(:div, nil, class: 'row mt-3') do
        content_tag(:div, content_tag(:div, flash[:notice], class: 'alert alert-success', role: 'alert'), class: 'col-8 mx-auto')
      end
    elsif flash[:alert]
      content_tag(:div, flash[:alert], class: 'alert alert-danger', role: 'alert')
    end
  end
end
