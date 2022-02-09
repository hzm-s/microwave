require 'string_compatible_type'

ActiveRecord::Type.register(:name, StringCompatibleType[:Name])
