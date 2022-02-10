module ComponentHelper
  include TagAttributeHelper

  COMPONENT_ATTRIBUTES = {
    rv_container: {
      data: { controller: 'reveal', reveal_hidden_class: 'hidden' },
    },
    rv_trigger: {
      data: { action: 'click->reveal#toggle' },
    },
    rv_target: {
      data: { reveal_target: 'item' },
      class: 'hidden',
    },
    dd_container: {
      data: { controller: 'reveal', reveal_hidden_class: 'hidden' },
      class: 'relative inline-block',
    },
    dd_trigger: {
      data: { action: 'click->reveal#toggle' },
    },
    dd_target: {
      data: { reveal_target: 'item' },
      class: 'transition hidden absolute z-50',
    },
    dd_container_pending: {
      data: { controller: 'dropdown' },
      class: 'relative inline-block',
    },
    dd_trigger_pending: {
      data: { action: 'dropdown#toggle click@window->dropdown#hide' },
    },
    dd_target_pending: {
      data: {
        dropdown_target: 'menu',
      },
      class: 'transition hidden absolute z-50',
    },
    dd_target_left: {
      data: {},
      class: 'origin-top-left left-0',
    },
    dd_target_right: {
      data: {},
      class: 'origin-top-right right-0',
    },
  }

  def component_attrs(*args)
    attr_sets = args.map do |arg|
      if arg.is_a?(Symbol)
        COMPONENT_ATTRIBUTES[arg]
      else
        arg
      end
    end

    first, *rest = *attr_sets
    return first if rest.empty?

    rest.reduce(first) { |a, e| merge_tag_attrs(a, e) }
  end

  def sort_list_options(extra = {})
    url = extra.dup.delete(:url)
    group = extra.dup.delete(:group)

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
end
