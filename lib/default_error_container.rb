require_dependency 'error_container'

module DefaultErrorContainer
  extend ActiveSupport::Concern

  # use error.add(:base, message)
  def error
    @error ||= begin
                 if respond_to?(:error_container) && error_container.is_a?(ErrorContainer)
                   error_container
                 else
                   ErrorContainer.new
                 end
               end
  end

  def merge_errors(another_errors)
    another_errors.messages.keys.each_with_index do |v, k|
      errors.add(v, another_errors.full_messages[k])
    end
  end

  alias errors error

  def error_message_simple
    errors.full_messages.uniq.select(&:present?).to_sentence
  end

  included do
    # @api private
    attr_accessor :error_container
  end
end
