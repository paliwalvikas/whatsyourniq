module BxBlockCatalogue
  class ApplicationMailer < BuilderBase::ApplicationMailer
    default from: ENV.fetch("MAILER_EMAIL")
    layout 'mailer'
  end
end
