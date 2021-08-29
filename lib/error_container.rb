# @see ActiveModel::Errors#add
class ErrorContainer
  def initialize
    @errors = ActiveModel::Errors.new(self)
  end

  delegate :full_messages, :messages, :add, :blank?, :present?, :clear, to: :errors

  def error
    errors
  end

  def self.human_attribute_name(attribute, *)
    attribute.to_s.humanize
  end

  private

  attr_reader :errors
end
