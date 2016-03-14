module  Api
  class BaseController < ApplicationController
    protect_from_forgery with: :null_session
    def i18n_attributes(klass, instance)
      i18l_hash = {}
      instance.errors.messages.each do |k,v|
        i18l_hash["#{klass.human_attribute_name(k)}"] = v.first
      end
      i18l_hash
    end
    helper_method :i18n_attributes
  end
end