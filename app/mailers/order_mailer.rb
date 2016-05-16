class OrderMailer < ApplicationMailer

  def new_order_admin(user,order_id)
    # mail :from => Shoppe.settings.outbound_email_address, :to => 'rafael.matadero@gmail.com', :subject => 'Nueva Cookie pedida! '
    # mail :from => Shoppe.settings.outbound_email_address, :to => 'hola@heyjoe.com.co', :subject => 'Nueva Cookie pedida! '
    puts ""
    @order_id = order_id
    mail :from => Shoppe.settings.outbound_email_address, :to => user.email_address, :subject => 'Nueva Cookie pedida! '

  end

  def customer_order(order)
    # image_url('/email/images/image-ae4e44a8be29773b3d3bc518489f6ce3c25bb269.png', :style => "border: 0; display: block; height: 159px; line-height: 0px; max-height: 159px; max-width: 160px; min-height: 159px; min-width: 160px; width: 160px")
    #
    # image_url('image-ae4e44a8be29773b3d3bc518489f6ce3c25bb269.png')
    attachments.inline['logoemail.png'] = File.read("#{Rails.root}/public/email/images/logo-email.png")

    @order = order
    mail :from => Shoppe.settings.outbound_email_address, :to => order.email_address, :subject => I18n.t('shoppe.order_mailer.received.subject', :default => "Confirmación de  Orden")
  end

end
