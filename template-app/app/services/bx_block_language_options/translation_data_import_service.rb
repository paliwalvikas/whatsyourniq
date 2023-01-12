module BxBlockLanguageOptions
  class TranslationDataImportService
    def store_data(xlsx)
      arr = []
      translations_data = xlsx.sheet("translations_sheet")
      unless translations_data.count > 1
        return {success: false, error: I18n.t('services.bx_block_language_options.translation_data_import_service.no_data_present')}
      end

      success, missing_headers = validate_headers(translations_data.first)
      unless success
        return {success: false, error: I18n.t('services.bx_block_language_options.translation_data_import_service.missing_headers') + "#{missing_headers}" + I18n.t('services.bx_block_language_options.translation_data_import_service.in_translations_sheet')}
      end

      translations_data.each(headers) do |row|
        arr << row
      end

      arr[1..].each do |arr2|
        return {
          success: false,
          error: I18n.t('services.bx_block_language_options.translation_data_import_service.key_not_present')
        } unless arr2[:key].present?

        return {
          success: false,
          error: I18n.t('services.bx_block_language_options.translation_data_import_service.key') + "#{ arr2[:key] }" + I18n.t('services.bx_block_language_options.translation_data_import_service.serial_number_not')
        } unless arr2[:sn].present?

        application_message = BxBlockLanguageOptions::ApplicationMessage.find_or_initialize_by(name: arr2[:key])
        I18n.available_locales.each do |locale|
          if application_message.id.present?
            translation = application_message.translations.find_or_initialize_by(locale: locale.to_s)
            translation.message = arr2[locale].to_s
            unless translation.save
              return {
                success: false,
                error: I18n.t('services.bx_block_language_options.translation_data_import_service.some_error_occured') + "#{arr2[:sn]} ->" +
                       " #{translation.errors.full_messages} "
              }
            end
          else
            application_message.translations_attributes=  [{message: arr2[locale], locale: locale.to_s}]
          end
          unless application_message.save
            return {
              success: false,
              error: I18n.t('services.bx_block_language_options.translation_data_import_service.some_error_occured') + "#{arr2[:sn]} ->" +
                     " #{application_message.errors.full_messages} "
            }
          end
        end
      end
      return {success: true}
    end

    private

    def validate_headers(sheet_headers)
      missing_headers = headers.values - sheet_headers
      [missing_headers.blank?, missing_headers.join(', ')]
    end

    def headers
      available_headers = {sn: 'sn', key: 'key'}
      BxBlockLanguageOptions::Language.pluck(:language_code).each do |language_code|
        available_headers.merge!("#{language_code}": language_code.to_s)
      end
      available_headers
    end
  end
end
