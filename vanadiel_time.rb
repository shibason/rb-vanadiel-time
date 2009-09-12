class VanadielTime
  EPOC_TIME = 1009810800
  EPOC_YEAR = 886
  EPOC_MONTH = 1
  EPOC_DAY = 1

  attr_reader :time, :real_time,
              :year, :month, :day,
              :hour, :min, :sec,
              :wday, :phase

  class << self
    alias :newobj :new
    def new
      newobj(Time.now)
    end
    alias :now :new

    def at(time)
      time = Time.at(time) unless time.is_a?(Time)
      newobj(time)
    end

    def at_vanadiel(vanadiel_time)
      newobj(nil, vanadiel_time)
    end
  end

  def initialize(time, vanadiel_time = nil)
    if time
      @real_time = time
      @time = (@real_time.to_i - EPOC_TIME) * 25
    else
      @time = vanadiel_time.to_i
      @real_time = Time.at(@time / 25 + EPOC_TIME)
    end
    @year = @time / 31104000 + EPOC_YEAR
    @month = @time / 2592000 % 12 + EPOC_MONTH
    @day = @time / 86400 % 30 + EPOC_DAY
    @hour = @time % 86400 / 3600
    @min = @time % 3600 / 60
    @sec = @time % 60
    @wday = @time / 86400 % 8
    @phase = @time / 604800 % 12
  end

  def to_i
    @time
  end

  def +(time)
    self.class.at(@real_time + time.to_i)
  end

  def -(time)
    self.class.at(@real_time - time.to_i)
  end

  def next_day
    self.class.at_vanadiel((@time / 86400 + 1) * 86400)
  end

  def next_phase
    self.class.at_vanadiel((@time / 604800 + 1) * 604800)
  end
end
