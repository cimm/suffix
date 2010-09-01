module DatesHelper

  def ordinalize(datetime)
    datetime.strftime("%b #{datetime.day.ordinalize}")
  end

  def reaction_time(datetime)
    distance_of_time_in_words(datetime, Time.now)
  end

end
