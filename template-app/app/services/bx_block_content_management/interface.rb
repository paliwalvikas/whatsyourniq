module BxBlockContentManagement
  module Interface
    def need_to_implement(*method_names)
      method_names.each do |method_name|
        define_method(method_name) { |*args|
          raise I18n.t('services.bx_block_content_management.interface.not_implemented') + "#{method_name}," + I18n.t('services.bx_block_content_management.interface.please_add_method')
        }
      end
    end
  end
end
