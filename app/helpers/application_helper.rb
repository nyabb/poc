module ApplicationHelper
  def translate text
    require 'bing_translator'

    translator = BingTranslator.new('dmec-grp4', 'jqoPbCnQliqVj0dTqiLc3V7hoYA138EDKqWftkt6GFo=',true)

    translation = translator.translate text, :from => 'nl', :to => 'en'
    translation
  end

end
