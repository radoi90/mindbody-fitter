require 'mindbody-api'

include MindBody::Services

module MindBody
  module Models
    # Monkey patch Base class to add to_json to all Models
    class Base
      def to_json(_options = {})
        hash = {}
        instance_variables.each do |var|
          hash[var.to_s[1..-1]] = instance_variable_get var
        end
        hash.to_json
      end
    end
  end
end

module MindBody
  module Services
    # Monkey patch ClassService with extra functionality
    class ClassService
      operation :add_clients_to_classes
    end
  end
end
