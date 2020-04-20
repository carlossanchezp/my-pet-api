class DeactivateWatchingHardWorker
  include Sidekiq::Worker

  def perform(*args)

    return 0 unless args[0].present?
    library_id = args[0].to_i

    library   = set_library(library_id)

    if library.present?
      library.active = false
      library.save!
    end
  end

  private

  def set_library(library_id)
    Library.where(id: library_id).first
  end
end