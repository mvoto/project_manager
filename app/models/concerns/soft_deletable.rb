module SoftDeletable
  def soft_delete
    write_attribute(:archived, true)
    write_attribute(:archived_at, Time.zone.now)

    save
  end
end
