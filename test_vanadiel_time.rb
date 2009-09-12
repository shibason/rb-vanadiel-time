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

  def test_initialize
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

  def test_to_i
    assert_equal(0, VanadielTime.at(Time.utc(2001, 12, 31, 15)).to_i)
    assert_equal(291600000, VanadielTime.at(Time.utc(2002, 5, 15, 15)).to_i)
    assert_equal(1017360000, VanadielTime.at(Time.utc(2003, 4, 16, 15)).to_i)
    assert_equal(2136240000, VanadielTime.at(Time.utc(2004, 9, 15, 15)).to_i)
    assert_equal(3391200000, VanadielTime.at(Time.utc(2006, 4, 19, 15)).to_i)
    assert_equal(4646160000, VanadielTime.at(Time.utc(2007, 11, 21, 15)).to_i)
  end

  def test_calculate
    time = VanadielTime.now
    assert_equal(time.to_i + 25, (time + 1).to_i)
    assert_equal(time.to_i - 25, (time - 1).to_i)
    assert_equal(time.to_i + 1500, (time + 60).to_i)
    assert_equal(time.to_i - 1500, (time - 60).to_i)
  end

  def test_next_day
    time = VanadielTime.at_vanadiel(38127)
    assert_equal(886, time.year)
    assert_equal(1, time.month)
    assert_equal(1, time.day)
    assert_equal(10, time.hour)
    assert_equal(35, time.min)
    assert_equal(27, time.sec)
    assert_equal(0, time.wday)
    assert_equal(0, time.phase)
    next_time = time.next_day
    assert_equal(886, next_time.year)
    assert_equal(1, next_time.month)
    assert_equal(2, next_time.day)
    assert_equal(0, next_time.hour)
    assert_equal(0, next_time.min)
    assert_equal(0, next_time.sec)
    assert_equal(1, next_time.wday)
    assert_equal(0, next_time.phase)
  end

  def test_next_phase
    time = VanadielTime.at_vanadiel(5032874329)
    assert_equal(1047, time.year)
    assert_equal(10, time.month)
    assert_equal(21, time.day)
    assert_equal(20, time.hour)
    assert_equal(38, time.min)
    assert_equal(49, time.sec)
    assert_equal(2, time.wday)
    assert_equal(5, time.phase)
    next_time = time.next_phase
    assert_equal(1047, next_time.year)
    assert_equal(10, next_time.month)
    assert_equal(25, next_time.day)
    assert_equal(0, next_time.hour)
    assert_equal(0, next_time.min)
    assert_equal(0, next_time.sec)
    assert_equal(6, next_time.wday)
    assert_equal(6, next_time.phase)
  end
end
