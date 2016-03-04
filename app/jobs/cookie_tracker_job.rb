class CookieTrackerJob < ActiveJob::Base
  queue_as :default

  def perform(state)
    state.increment_seq
    if state.seq < 4
      time  = ENV['STATE_TIMER'] || 3
      time = time.to_i
      # CookieTrackerJob.perform_in(time.minutes, state)
      CookieTrackerJob.set(wait: time.minutes).perform_later(state.increment_seq)
    end
  end
end
