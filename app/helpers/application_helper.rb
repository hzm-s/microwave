module ApplicationHelper
  include IconHelper
  include ComponentHelper

  WEB_FONT_URL = 'https://fonts.googleapis.com/earlyaccess/roundedmplus1c.css'.freeze

  def web_font_link_tag
    return if Rails.env.test?

    stylesheet_link_tag(WEB_FONT_URL, media: 'all')
  end
end
