module BrothersHelper
  def two_digit_year(brother)
    brother.year.to_s[-2..-1]
  end
end
