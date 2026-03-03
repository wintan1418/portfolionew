class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAILER_FROM", "hello@wintan.dev")
  layout "mailer"
end
