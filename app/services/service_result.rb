ServiceResult = ImmutableStruct.new :data, :errors, :message do
  def success?
    !errors.present? || message.blank?
  end
end
