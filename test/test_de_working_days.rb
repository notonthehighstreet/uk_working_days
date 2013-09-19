require 'helper'

class TestDeWorkingDays < Test::Unit::TestCase
  context "Region DE" do
    setup { UkWorkingDays.region = 'DE' }

    should "return the public holidays in the year 2010" do
      expected = [Date.parse("Fri, 01 Jan 2010"), # new year's
                  Date.parse("Wed, 06 Jan 2010"), # epiphany
                  Date.parse("Fri, 02 Apr 2010"), # good friday
                  Date.parse("Mon, 05 Apr 2010"), # easter monday
                  Date.parse("Thu, 13 May 2010"), # ascension day
                  Date.parse("Mon, 24 May 2010"), # pentecost monday
                  Date.parse("Thu, 03 Jun 2010"), # corpus christi
                  Date.parse("Mon, 01 Nov 2010"), # all saints
                  Date.parse("Wed, 17 Nov 2010")] # day of repentance and prayer
      # note: the following are on a weekend so are not included:
      # - assumption day
      # - international worker's day
      # - germany unity day
      # - reformation day
      # - christmas day
      # - boxing day
      assert_equal expected, Date.public_holidays(2010)
    end

    should "return the public holidays in the year 2013" do
      expected = [Date.parse("Tue, 01 Jan 2013"), # new year's
                  Date.parse("Fri, 29 Mar 2013"), # good friday
                  Date.parse("Mon, 01 Apr 2013"), # easter monday
                  Date.parse("Wed, 01 May 2013"), # international worker's day
                  Date.parse("Thu, 09 May 2013"), # ascension day
                  Date.parse("Mon, 20 May 2013"), # pentecost monday
                  Date.parse("Thu, 30 May 2013"), # corpus christi
                  Date.parse("Thu, 15 Aug 2013"), # assumption day
                  Date.parse("Thu, 03 Oct 2013"), # german unity day
                  Date.parse("Thu, 31 Oct 2013"), # reformation day
                  Date.parse("Fri, 01 Nov 2013"), # all saints
                  Date.parse("Wed, 20 Nov 2013"), # day of repentance and prayer
                  Date.parse("Wed, 25 Dec 2013"), # christmas day
                  Date.parse("Thu, 26 Dec 2013")] # boxing day
      # note: the following are on a weekend so are not included:
      # - epiphany
      assert_equal expected, Date.public_holidays(2013)
    end
  end
end
