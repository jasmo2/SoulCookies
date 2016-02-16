class CookieTrackerJob < ActiveJob::Base
  queue_as :default

  def perform(state)
    state.increment_seq
    if state.seq < 5
      time  = ENV['STATE_TIMER'] || 1
      CookieTrackerJob.perform_in(time.to_i.minute, state)
    end
  end
end
