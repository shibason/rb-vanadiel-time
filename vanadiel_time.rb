class VanadielTime
  EPOC_TIME = 1009810800
  EPOC_YEAR = 886
  EPOC_MONTH = 1
  EPOC_DAY = 1

  SEC_YEAR = 31104000
  SEC_MONTH = 2592000
  SEC_PHASE = 604800
  SEC_DAY = 86400

  REAL_SEC_YEAR = 1244160
  REAL_SEC_MONTH = 103680
  REAL_SEC_PHASE = 24192
  REAL_SEC_DAY = 3456

  attr_reader :real_time,
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
      @time_sec = (@real_time.to_i - EPOC_TIME) * 25
    else
      @time_sec = vanadiel_time.to_i
      @real_time = Time.at(@time_sec / 25 + EPOC_TIME)
    end
    @year = @time_sec / SEC_YEAR + EPOC_YEAR
    @month = @time_sec / SEC_MONTH % 12 + EPOC_MONTH
    @day = @time_sec / SEC_DAY % 30 + EPOC_DAY
    @hour = @time_sec % SEC_DAY / 3600
    @min = @time_sec % 3600 / 60
    @sec = @time_sec % 60
    @wday = @time_sec / SEC_DAY % 8
    @phase = @time_sec / SEC_PHASE % 12
  end

  def to_i
    @time_sec
  end

  def to_s
    "%d-%02d-%02d %02d:%02d:%02d" % [ @year, @month, @day, @hour, @min, @sec ]
  end

  def ==(time)
    case time
    when Integer
      @real_time.to_i == time
    when Time
      @real_time.to_i == time.to_i
    when VanadielTime
      to_i == time.to_i
    else
      false
    end
  end

  def +(time)
    self.class.at(@real_time + time.to_i)
  end

  def -(time)
    if time.is_a?(VanadielTime)
      @real_time - time.real_time
    else
      self.class.at(@real_time - time.to_i)
    end
  end

  def next_day
    self.class.at_vanadiel(@time_sec - @time_sec % SEC_DAY + SEC_DAY)
  end

  def next_phase
    self.class.at_vanadiel(@time_sec - @time_sec % SEC_PHASE + SEC_PHASE)
  end
end
