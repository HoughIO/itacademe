module ApplicationHelper
  def sanitize_html str
    # Sanitize.clean(Markdown.new(str).to_html,
    #                ITAcademe::SANITIZE_FILTER).html_safe
    # Markdown.new(str).to_html.html_safe
    Sanitize.clean(str, ITAcademe::SANITIZE_FILTER).html_safe
  end
end
