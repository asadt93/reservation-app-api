class BaseService
  extend ActiveModel::Callbacks
  define_model_callbacks :run
end