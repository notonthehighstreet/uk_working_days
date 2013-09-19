require 'holidays'

module UkWorkingDays
  # regions as known to the holidays gem
  REGIONS = {
    'GB' => :gb_eng, # by convention we use English public holidays
    'DE' => :de_ # the trailing underscore means all states
  }

  def self.region
    @@region
  end

  def self.region=(region)
    @@region = region
    require "holidays/#{region.downcase}"
    rescue LoadError
      raise "Fail to load region '#{region}' for holidays gem"
  end

  # Extensions to the Date and DateTime classes
  module DateExtensions
    # Returns true if this day is in the week
    def weekday?
      ! weekend?
    end

    # Returns true if this day is on the weekend
    def weekend?
      wday == 0 || wday == 6
    end

    # Returns true if this day is a bank holiday
    def public_holiday?
      Date.public_holidays(year).include?(to_date)
    end

    # Returns true if this day is a normal weekday
    def working_day?
      weekday? && ! public_holiday?
    end

    # Returns the next (or count'th) working day
    def next_working_day(count = 1)
      return self if count == 0
      negative = count < 0
      count = count.abs
      date = negative ? yesterday : tomorrow

      loop do
        count -= 1 if date.working_day?
        return date if count.zero?

        date += (negative ? -1 : 1).day
      end
    end

    # The previous (or count'th) working day
    def previous_working_day(count = 1)
      next_working_day(-count)
    end

    module ClassMethods
      # An Array of all public holidays for the given year
      def public_holidays(year)
        year_start = Date.civil(year, 1, 1)
        year_end = Date.civil(year, 12, 31)
        region = UkWorkingDays.region
        holidays = Holidays.between(year_start, year_end, REGIONS.fetch(region), :observed).
          map{|h| h[:date]}.
          reject(&:weekend?) # Easter is always a Sunday so we don't need to include that
        if self == DateTime
          holidays.map(&:to_datetime)
        else
          holidays
        end
      end
    end
  end
end
