class CookieTrackerJob < ActiveJob::Base
  queue_as :default

  def perform(state)
    state.increment_seq
    if state.seq < 4
      time  = ENV['STATE_TIMER'] || 3
      time = time.to_i
      puts " Time_now: #{Time.now.to_f}"
      puts "state: #{state}"
      # CookieTrackerJob.perform_in(time.minutes, state)
      CookieTrackerJob.perform_at(time.minutes.from_now, state)
      # CookieTrackerJob.perform_at(state.increment_seq)
    end
  end
end
