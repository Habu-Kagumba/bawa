module ApplicationHelper
  def full_title(page_title = "")
    base_title = "Bawa"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def parse_html(html, xpath)
    Nokogiri::HTML(html).at_xpath(xpath)
  end
end
