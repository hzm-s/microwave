module ComponentHelper
  include TagAttributeHelper

  DROPDOWN_POSITION_CLASSES = {
    left: 'origin-top-left left-0',
    right: 'origin-top-right right-0',
  }

  def sort_list_options(extra = {})
    url = extra.delete(:url)
    group = extra.delete(:group)

    merge_tag_attrs(
      {
        data: {
          controller: 'sort-list',
          sort_list_url: url,
          sort_list_group: group,
        },
      },
      extra
    )
  end

  def dd_container_options(extra = {})
    merge_tag_attrs(
      { data: { controller: 'dropdown' }, class: 'relative inline-block' },
      extra
    )
  end

  def dd_trigger_options(extra = {})
    merge_tag_attrs(
      { data: { action: 'dropdown#toggle click@window->dropdown#hide' } },
      extra
    )
  end

  def dd_target_options(extra = {})
    position_css_class = DROPDOWN_POSITION_CLASSES[extra.delete(:position) || :left]
    merge_tag_attrs(
      {
        data: { dropdown_target: 'menu' },
        class: "hidden absolute z-50 #{position_css_class}",
      },
      extra
    )
  end

  def rv_container_options(extra = {})
    merge_tag_attrs(
      { data: { controller: 'reveal', reveal_hidden_class: 'hidden' } },
      extra
    )
  end

  def rv_trigger_options(extra = {})
    merge_tag_attrs(
      { data: { action: 'click->reveal#toggle' } },
      extra
    )
  end

  def rv_target_options(extra = {})
    merge_tag_attrs(
      { data: { reveal_target: 'item' }, class: 'hidden' },
      extra
    )
  end

  def transition_options(extra = {})
    merge_tag_attrs(
      {
        data: {
          transition_enter_from: 'opacity-0 scale-95',
          transition_enter_to: 'opacity-100 scale-100',
          transition_leave_from: 'opacity-100 scale-100',
          transition_leave_to: 'opacity-0 scale-95',
        },
        class: 'transition',
      },
      extra
    )
  end
end
