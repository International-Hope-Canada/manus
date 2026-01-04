module ApplicationHelper
  def list_sort_link(param_name:, param_value:)
    return link_to('↓', { param_name => nil }, class: 'sort-control sort-control-active') if params[param_name] == param_value.to_s

    link_to_unless_current('↓', { param_name => param_value }, class: 'sort-control sort-control-inactive')
  end
end
