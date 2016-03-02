class OrderMailer < ApplicationMailer
  def received_order(order)
    @order = order
    mail :from => Shoppe.settings.outbound_email_address, :to => order.email_address, :subject => I18n.t('shoppe.order_mailer.received.subject', :default => "Confirmación de  Orden")
  end

end
