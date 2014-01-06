module ApplicationHelper
  def translater text
    if current_user.country.short_name != 'nl'
      require 'bing_translator'

      translator = BingTranslator.new('dmec-grp4', 'jqoPbCnQliqVj0dTqiLc3V7hoYA138EDKqWftkt6GFo=',true)

      translation = translator.translate text, :from => 'nl', :to => current_user.country.short_name
      translation
    else
      text
    end
  end
end
