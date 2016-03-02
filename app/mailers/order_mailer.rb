class OrderMailer < ApplicationMailer
  def received_order(order)
    # image_url('/email/images/image-ae4e44a8be29773b3d3bc518489f6ce3c25bb269.jpg', :style => "border: 0; display: block; height: 159px; line-height: 0px; max-height: 159px; max-width: 160px; min-height: 159px; min-width: 160px; width: 160px")
    #
    # image_url('image-ae4e44a8be29773b3d3bc518489f6ce3c25bb269.jpg')
    attachments.inline['image1.jpg'] = File.read("#{Rails.root}/public/email/images/image-ae4e44a8be29773b3d3bc518489f6ce3c25bb269.jpg")
    attachments.inline['image2.jpg'] = File.read("#{Rails.root}/public/email/images/image-061532f273678d044b44fb8e8925a4429f829e8b.jpg")
    attachments.inline['image3.jpg'] = File.read("#{Rails.root}/public/email/images/image-d8280e229c60d95a55af8b75d9453a6aab325697.jpg")
    attachments.inline['image4.jpg'] = File.read("#{Rails.root}/public/email/images/image-6230e1703f8e79f1117923de133856b799f70088.jpg")
    attachments.inline['image5.jpg'] = File.read("#{Rails.root}/public/email/images/image-335bd7a2fa7a687f09d6d97b33f22baea5cdd9b0.jpg")

    attachments.inline['image6.jpg'] = File.read("#{Rails.root}/public//email/images/image-7f0e8f27f82bf5906a8378f67c034c8ee2ad63b2.jpg")
    attachments.inline['image7.jpg'] = File.read("#{Rails.root}/public/email/images/image-94a6475c400e7bddf674b7d39dc6967747b5376e.jpg")
    attachments.inline['image8.jpg'] = File.read("#{Rails.root}/public/email/images/image-2b4417b5cb9992e1458848ae8c5467607a79dc40.jpg")
    attachments.inline['image9.jpg'] = File.read("#{Rails.root}/public/email/images/image-8ddfb5b16d976d0d1fdc5b66d69f83906bd515ad.jpg")
    attachments.inline['image10.jpg'] = File.read("#{Rails.root}/public/email/images/image-2a194e1d17e2179e865bce35b4d02d306e26bcec.jpg")

    attachments.inline['image11.jpg'] = File.read("#{Rails.root}/public/email/images/image-2fdb0f7fb62cb18cf2e0c2f2927213c97008c60e.jpg")
    attachments.inline['image12.jpg'] = File.read("#{Rails.root}/public/email/images/image-84299f04becf483757c12fbce7b3955cc8addf63.jpg")
    attachments.inline['image13.jpg'] = File.read("#{Rails.root}/public/email/images/image-4e21fd25712cdcc3abbc8e4baee5977f9d4db30a.jpg")
    attachments.inline['image14.jpg'] = File.read("#{Rails.root}/public/email/images/image-b15349943664a349f48d52133c41d8bb5f125d21.jpg")
    attachments.inline['image15.jpg'] = File.read("#{Rails.root}/public/email/images/image-4d688cb936565bc0a8104db2bd52a220f817acc8.jpg")

    attachments.inline['image16.jpg'] = File.read("#{Rails.root}/public/email/images/image-b2ef3c2ea1812fc50ff701c290a16b91a82f89be.jpg")
    attachments.inline['image17.jpg'] = File.read("#{Rails.root}/public/email/images/image-99f3975cd6aa6fe29bdf619848d1b26f2a060b70.jpg")
    attachments.inline['image18.jpg'] = File.read("#{Rails.root}/public/email/images/image-636f3683dc3cfac109818e2f65372ea56fabe1ea.jpg")
    attachments.inline['image19.jpg'] = File.read("#{Rails.root}/public/email/images/image-a3274d5ce1fad2134316b7ac1ea70cb807c9ed62.jpg")

    @order = order
    mail :from => Shoppe.settings.outbound_email_address, :to => order.email_address, :subject => I18n.t('shoppe.order_mailer.received.subject', :default => "Confirmación de  Orden")
  end

end
