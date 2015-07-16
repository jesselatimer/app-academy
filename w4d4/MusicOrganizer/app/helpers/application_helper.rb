module ApplicationHelper
  def auth_token
    html = <<-HTM
      <input type='hidden'
             name='authenticity_token'
             value='#{h(form_authenticity_token)}'
    HTM
    html.html_safe
  end
end
