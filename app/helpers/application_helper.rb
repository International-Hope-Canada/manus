module ApplicationHelper
  def list_sort_link(param_name:, param_value:)
    if param_value.nil?
      # Default is on
      return tag.span(class: "sort-control sort-control-active sort-control-unremovable") { "↓" } if params[param_name].nil?
      # Default is not on
      return link_to("↓", request.query_parameters.merge(param_name => param_value), class: "sort-control sort-control-inactive", "data-turbo-frame" => "_self")
    end
    return link_to("↓", request.query_parameters.merge(param_name => nil), class: "sort-control sort-control-active", "data-turbo-frame" => "_self") if params[param_name] == param_value.to_s

    link_to_unless_current("↓", request.query_parameters.merge(param_name => param_value), class: "sort-control sort-control-inactive", "data-turbo-frame" => "_self")
  end

  def list_filter_control(scope:, column:, control_type:, options: [])
    param_name = "#{scope}[#{column}]"
    param_value = params.dig(scope, column)
    tag.span(class: "filter-control #{'filter-control-active' if param_value.present?}") do
      filter_toggle = tag.span(class: "filter-toggle") { "ᗊ" }

      params_without_this_filter = request.query_parameters.dup
      if params_without_this_filter[scope]
        params_without_this_filter[scope] = params_without_this_filter[scope].dup
        params_without_this_filter[scope]&.delete(column)
      end

      filter_form = tag.form(class: "filter-detail") {
        selectable = case control_type
        when :select
                       select_tag(param_name, options_for_select(options, param_value))
        when :grouped_select
                       select_tag(param_name, grouped_options_for_select(options, param_value))
        when :year
                       text_field_tag(param_name, param_value, inputmode: :numeric, placeholder: "YYYY", size: 4, autocomplete: :off)
        else
                       raise "Unknown control_type #{control_type}"
        end

        hidden_fields = params_without_this_filter.map do |k, v|
          if v.is_a?(Hash)
            v.map { |subk, subv| tag.input(type: "hidden", name: "#{k}[#{subk}]", value: subv) }
          else
            tag.input(type: "hidden", name: k, value: v)
          end
        end

        submit = tag.input(type: "submit", value: "→", class: "filter-apply")
        if param_value
          clear = tag.a(href: url_for(**params_without_this_filter, only_path: true), class: "filter-clear") { "✖" }
        else
          clear = ""
        end
        ([ selectable ] + hidden_fields + [ submit ] + [ clear ]).flatten.join.html_safe
      }

      filter_toggle + filter_form
    end
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
    tag.div(class: :pagination) do
      rv = @pagy.info_tag
      if @pagy.pages > 1
        rv += " | "
        rv += link_to("View all", request.query_parameters.merge(view_all: 1, page: nil))
        rv += @pagy.series_nav
      elsif params[:view_all] == "1"
        rv += " | "
        rv += link_to("View paged", request.query_parameters.merge(view_all: nil))
      end
      rv.html_safe
    end
  end

  def render_boolean(b)
    b ? "Yes" : "No"
  end

  def render_user(user)
    return "" unless user

    tag.span(title: user.name) { user.initials }
  end
end
