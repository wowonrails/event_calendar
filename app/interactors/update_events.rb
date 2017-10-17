class UpdateEvents
  include Interactor

  def call
    Event.where(["title = ? and start > ?", context.old_event.title, context.old_event.start])
         .destroy_all

    CreateEvents.call(event: context.event)
  end
end
