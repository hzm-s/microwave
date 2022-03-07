require 'string_compatible_type'

ActiveRecord::Type.register(:name, StringCompatibleType['Name'])
ActiveRecord::Type.register(:short_sentence, StringCompatibleType['Sentence::Short'])
ActiveRecord::Type.register(:long_sentence, StringCompatibleType['Sentence::Long'])

ActiveRecord::Type.register(:email, StringCompatibleType['Email'])
