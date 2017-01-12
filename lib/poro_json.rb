require "poro_json/version"

module PoroJson
  extend ActiveSupport::Concern
  included do
    include ActiveModel::Model
  end

  module ClassMethods
    def object_attr_accessor(key, _klass)
      attr_accessor key
      eval_str = "define_method('#{key}=') { |hash| @#{key} = _klass.new(hash) }"
      instance_eval eval_str
    end

    def array_attr_accessor(key, klass = nil)
      attr_accessor key
      eval_str = "define_method('#{key}=') { |array| return @#{key} = [] if array.blank?; return @#{key} = array if klass.blank?; @#{key} = array.map{|e| klass.new(e) } }"
      instance_eval eval_str
    end
  end
end
