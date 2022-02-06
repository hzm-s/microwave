module ComponentHelper
  DROPDOWN_POSITION_CLASSES = {
    left: 'origin-top-left left-0',
    right: 'origin-top-right right-0',
  }

  def dd_container_options(extra = {})
    build_dom_options(
      { data: { controller: 'dropdown' }, class: 'relative inline-block' },
      extra
    )
  end

  def dd_trigger_options(extra = {})
    build_dom_options(
      { data: { action: 'dropdown#toggle click@window->dropdown#hide' } },
      extra
    )
  end

  def dd_dropdown_options(extra = {})
    position_css_class = DROPDOWN_POSITION_CLASSES[extra.delete(:position) || :left]

    build_dom_options(
      {
        data: {
          dropdown_target: 'menu',
          transition_enter_from: 'opacity-0 scale-95',
          transition_enter_to: 'opacity-100 scale-100',
          transition_leave_from: 'opacity-100 scale-100',
          transition_leave_to: 'opacity-0 scale-95',
        },
        class: "hidden transition transform absolute #{position_css_class}",
      },
      extra
    )
  end

  private

  def build_dom_options(default, extra)
    css_class = default.delete(:class) || ''
    extra_css_class = extra.delete(:class)
    css_class << " #{extra_css_class}" if extra_css_class

    default.deep_merge(extra).merge(class: css_class)
  end
end
