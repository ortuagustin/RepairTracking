module I18n
  def self.locales
    I18n.available_locales.reject { |each| each == :langs }
  end

  def self.locales_except_current
    locales.reject { |each| each == current_locale }
  end

  def self.current_locale
    I18n.locale
  end

  def self.translate_lang(lang)
    I18n.with_locale(:langs) { I18n.translate lang }
  end

  class << self
    alias_method :t_lang, :translate_lang
  end
end