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
    return datetime.strftime("%-I:%M%p") if datetime.today?
    return datetime.strftime("%b %-d") if datetime.year == Date.today.year
    datetime.strftime("%b %-d, %Y")
  end

  def render_pagy
    @pagy.series_nav.html_safe if @pagy.pages > 1
  end
end
