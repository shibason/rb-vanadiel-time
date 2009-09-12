#!/usr/bin/env ruby
require 'test/unit'
require 'vanadiel_time'

class TC_VanadielTime < Test::Unit::TestCase
  def check_vanadiel_time(name, real_times, vana_times)
    time = VanadielTime.at(Time.utc(*real_times))
    assert_equal(vana_times[0], time.year, "check year of #{name}")
    assert_equal(vana_times[1], time.month, "check month of #{name}")
    assert_equal(vana_times[2], time.day, "check day of #{name}")
    assert_equal(vana_times[3], time.hour, "check hour of #{name}")
    assert_equal(vana_times[4], time.min, "check min of #{name}")
    assert_equal(vana_times[5], time.sec, "check sec of #{name}")
    assert_equal(vana_times[6], time.wday, "check wday of #{name}")
    assert_equal(vana_times[7], time.phase, "check phase of #{name}")
  end

  def test_times
    check_vanadiel_time('epoc',
      [ 2001, 12, 31, 15, 0, 0 ],
      [ 886, 1, 1, 0, 0, 0, 0, 0 ])
    check_vanadiel_time('sample1',
      [ 2002, 5, 15, 15, 0, 0 ],
      [ 895, 5, 16, 0, 0, 0, 7, 2 ])
    check_vanadiel_time('sample2',
      [ 2002, 7, 22, 15, 0, 0 ],
      [ 900, 2, 6, 0, 0, 0, 3, 5 ])
    check_vanadiel_time('sample3',
      [ 2002, 9, 16, 15, 0, 0 ],
      [ 903, 12, 26, 0, 0, 0, 3, 1 ])
    check_vanadiel_time('sample4',
      [ 2009, 9, 12, 15, 0, 0 ],
      [ 1081, 4, 11, 0, 0, 0, 4, 10 ])
    check_vanadiel_time('sample4',
      [ 2009, 9, 12, 19, 13, 5 ],
      [ 1081, 4, 15, 9, 27, 5, 0, 11 ])
    check_vanadiel_time('sample4',
      [ 2009, 9, 12, 19, 16, 23 ],
      [ 1081, 4, 15, 10, 49, 35, 0, 11 ])
  end
end
