module ApplicationHelper
  def list_sort_link(param_name:, param_value:)
    if param_value.nil?
      # Default is on
      return tag.span(class: "sort-control sort-control-active sort-control-unremovable") { "↓" } if params[param_name].nil?
      # Default is not on
      return link_to("↓", { param_name => param_value }, class: "sort-control sort-control-inactive", "data-turbo-frame" => "_self")
    end
    return link_to("↓", { param_name => nil }, class: "sort-control sort-control-active", "data-turbo-frame" => "_self") if params[param_name] == param_value.to_s

    link_to_unless_current("↓", { param_name => param_value }, class: "sort-control sort-control-inactive", "data-turbo-frame" => "_self")
  end

  def render_datetime(datetime)
    return nil unless datetime

    display_text = if datetime.today?
      datetime.strftime("%H:%M")
    elsif datetime.year == Date.today.year
      datetime.strftime("%b %-d")
    else
      datetime.strftime("%b %-d '%y")
    end

    tag.span(title: datetime.strftime("%B %-d, %Y %-I:%M%p")) { display_text }
  end

  def render_full_date(datetime)
    datetime.strftime("%B %-d, %Y")
  end

  def render_pagy
    rv = @pagy.info_tag
    rv += @pagy.series_nav if @pagy.pages > 1
    rv.html_safe
  end

  def render_boolean(b)
    b ? "Yes" : "No"
  end

  def render_user(user)
    return "" unless user

    tag.span(title: user.name) { user.initials }
  end
end
