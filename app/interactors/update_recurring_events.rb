class UpdateRecurringEvents < CreateRecurringEvents
  delegate :old_event, to: :context

  def call
    Event.where(["title = ? and start > ?", old_event.title, old_event.start])
         .destroy_all

    super
  end
end
