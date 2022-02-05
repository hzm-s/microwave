module ComponentHelper
  def dd_container_options(extra = {})
    merge_options_with_css_class(
      { data: { controller: 'dropdown' }, class: 'relative inline-block' },
      extra
    )
  end

  def dd_trigger_options(extra = {})
    merge_options_with_css_class(
      { data: { action: 'dropdown#toggle click@window->dropdown#hide' } },
      extra
    )
  end

  def dd_dropdown_options(extra = {})
    merge_options_with_css_class(
      {
        data: {
          dropdown_target: 'menu',
          transition_enter_from: 'opacity-0 scale-95',
          transition_enter_to: 'opacity-100 scale-100',
          transition_leave_from: 'opacity-100 scale-100',
          transition_leave_to: 'opacity-0 scale-95',
        },
        class: 'hidden transition transform origin-top-right absolute right-0',
      },
      extra
    )
  end

  private

  def merge_options_with_css_class(default, extra)
    css_class = default.delete(:class) || ''
    extra_css_class = extra.delete(:class)
    css_class << " #{extra_css_class}" if extra_css_class

    default.deep_merge(extra).merge(class: css_class)
  end
end
