module DatesHelper

  def ordinalize(datetime)
    datetime.strftime("%b #{datetime.day.ordinalize}")
  end

end
