module AccountBlock
  class ApplicationMailer < BuilderBase::ApplicationMailer
    default from: "hello@superfoodsvalley.com"
    layout 'mailer'
  end
end
