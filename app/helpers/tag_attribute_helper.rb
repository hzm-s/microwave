module TagAttributeHelper
  def merge_tag_attrs(default, extra)
    css_class = default.delete(:class) || ''
    extra_css_class = extra.delete(:class)
    css_class << " #{extra_css_class}" if extra_css_class

    default.deep_merge(extra).merge(class: css_class)
  end
end
