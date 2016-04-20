class CookieTrackerJob < ActiveJob::Base
  queue_as :default

  def perform(state)
    puts "Before state: #{state.seq}"
    state.increment_seq
    if state.seq < 4
      time  = ENV['STATE_TIMER'] || 3
      time = time.to_i
      puts " Time_now: #{Time.now.to_f}"
      puts "state: #{state.seq}"
      # CookieTrackerJob.perform_at(time.minutes.from_now, state)
      CookieTrackerJob.set(wait: time.seconds).perform_later(state)
    end
  end
end
