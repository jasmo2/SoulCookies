class OrderMailer < ApplicationMailer


  def  send_new_order_admin(user, order_id)
    @order_id = order_id
    puts "email: #{user.email_address}"
    mail :from => Shoppe.settings.outbound_email_address, :to => user.email_address, :subject => 'Nueva Cookie pedida! '
  end
  def new_order_admin(users,order_id)
    # mail :from => Shoppe.settings.outbound_email_address, :to => 'rafael.matadero@gmail.com', :subject => 'Nueva Cookie pedida! '
    # mail :from => Shoppe.settings.outbound_email_address, :to => 'hola@heyjoe.com.co', :subject => 'Nueva Cookie pedida! '
    puts ""
    users.each do |user|
      send_new_order_admin(user,order_id).deliver
    end

  end

  def received_order(order)
    # image_url('/email/images/image-ae4e44a8be29773b3d3bc518489f6ce3c25bb269.png', :style => "border: 0; display: block; height: 159px; line-height: 0px; max-height: 159px; max-width: 160px; min-height: 159px; min-width: 160px; width: 160px")
    #
    # image_url('image-ae4e44a8be29773b3d3bc518489f6ce3c25bb269.png')
    attachments.inline['image1.png'] = File.read("#{Rails.root}/public/email/images/image-1.png")
    attachments.inline['image2.png'] = File.read("#{Rails.root}/public/email/images/image-2.png")
    attachments.inline['image3.png'] = File.read("#{Rails.root}/public/email/images/image-3.png")
    attachments.inline['image4.png'] = File.read("#{Rails.root}/public/email/images/image-4.png")
    attachments.inline['image5.png'] = File.read("#{Rails.root}/public/email/images/image-5.png")

    attachments.inline['image6.png'] = File.read("#{Rails.root}/public//email/images/image-6.png")
    attachments.inline['image7.png'] = File.read("#{Rails.root}/public/email/images/image-7.png")
    attachments.inline['image8.png'] = File.read("#{Rails.root}/public/email/images/image-8.png")
    attachments.inline['image9.png'] = File.read("#{Rails.root}/public/email/images/image-9.png")
    attachments.inline['image10.png'] = File.read("#{Rails.root}/public/email/images/image-10.png")

    attachments.inline['image11.png'] = File.read("#{Rails.root}/public/email/images/image-11.png")
    attachments.inline['image12.png'] = File.read("#{Rails.root}/public/email/images/image-12.png")
    attachments.inline['image13.png'] = File.read("#{Rails.root}/public/email/images/image-13.png")
    attachments.inline['image14.png'] = File.read("#{Rails.root}/public/email/images/image-14.png")
    attachments.inline['image15.png'] = File.read("#{Rails.root}/public/email/images/image-15.png")

    attachments.inline['image16.png'] = File.read("#{Rails.root}/public/email/images/image-16.png")
    attachments.inline['image17.png'] = File.read("#{Rails.root}/public/email/images/image-17.png")
    attachments.inline['image18.png'] = File.read("#{Rails.root}/public/email/images/image-18.png")
    attachments.inline['image19.png'] = File.read("#{Rails.root}/public/email/images/image-19.png")

    @order = order
    mail :from => Shoppe.settings.outbound_email_address, :to => order.email_address, :subject => I18n.t('shoppe.order_mailer.received.subject', :default => "Confirmación de  Orden")
  end

end
