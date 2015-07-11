require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @name = name
    @class_name = options[:class_name] || name.to_s.singularize.camelcase
    @foreign_key = options[:foreign_key] || "#{name.to_s.underscore}_id".to_sym
    @primary_key = options[:primary_key] || :id
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @name = name
    @class_name = options[:class_name] || name.to_s.singularize.camelcase
    foreign = self_class_name.underscore
    @foreign_key = options[:foreign_key] || "#{foreign}_id".to_sym
    @primary_key = options[:primary_key] || :id
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    assoc_options[name] = BelongsToOptions.new(name, options)
    define_method(name) do
      options = self.class.assoc_options[name]
      f = options.foreign_key
      options.model_class.where({options.primary_key => attributes[f]}).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.to_s, options)
    define_method(name) do
      id = options.primary_key
      options.model_class.where({options.foreign_key => attributes[id]})
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
