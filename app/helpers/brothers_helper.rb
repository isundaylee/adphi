module BrothersHelper
  def two_digit_year(brother)
    brother.year.to_s[-2..-1]
  end

  def friendly_date(date, dow = true)
    dow ?
      date.strftime("%A, %B %-d, %Y") :
      date.strftime("%B %-d, %Y")
  end

  def friendly_time(time)
    time.strftime("%I:%M %p")
  end

  def markup_keywords(text)
    text.gsub(/\[\[(.*?)\]\]/) do |m|
      content_tag(:span, m[2...-2], class: "keywords")
    end.html_safe
  end
end
