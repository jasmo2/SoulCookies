# encoding: UTF-8

# tax rates
tax_rate = Shoppe::TaxRate.where(name: 'IVA', rate: 19).first_or_create



# categories
cat1 = Shoppe::ProductCategory.where(name: 'cookies').first_or_create


def get_file(name, content_type = 'image/png')
  file = ActionDispatch::Http::UploadedFile.new(tempfile: File.open(Rails.root.join('db', 'seeds_data', name), 'rb'))
  file.original_filename = name
  file.content_type = content_type
  file
end

descripcion_sam_cookie = 'La tradicional. Pedazos de chocolate semi amargo y nueces. Gigante y suavecita.'
descripcion_james_brown = 'Doble Chocolate; nuestra masa de cocoa y pedazos de chocolate semi amargo. Para amantes del chocolate.'
descripcion_erykah_badu = 'Nada como la combinación de mantequilla de maní, chips de chocolate y nueces.'
descripcion_barry_white = 'Pedazos del mejor chocolate blanco .'
descripcion_anita_baker = 'Galleta de avena, arándanos y nueces. Una versión recargada y deliciosa.'
descripcion_cookie_wonder = 'Nuestra tradicional masa mezclada con chips de chocolate, nueces y nutella. Sí, nutella.'
descripcion_roberta = 'Red Velvet. La perfecta unión entre chips de chocolate blanco y cocoa en nuestra masa roja.'


pro = Shoppe::Product.new(name: 'Sam Cookie', sku: 'YL-SIP-T22P', description: descripcion_sam_cookie, short_description: descripcion_sam_cookie, price: 5.000, cost_price: 4.050, tax_rate: tax_rate)
pro.product_category_ids = cat1.id
pro.default_image_file = get_file('sam-cookie.png')
if pro.save
  pro.stock_level_adjustments.create(description: 'Stock inicial', adjustment: 50)
end

pro = Shoppe::Product.new(name: 'James Brown', sku: 'YL-SIP-T23P', description: descripcion_james_brown, short_description: descripcion_james_brown, price: 5.000, cost_price: 4.050, tax_rate: tax_rate)
pro.product_category_ids = cat1.id
pro.default_image_file = get_file('james-brown.png')
if pro.save
  pro.stock_level_adjustments.create(description: 'Stock inicial', adjustment: 50)
end

pro = Shoppe::Product.new(name: 'Erykah Badu', sku: 'YL-SIP-T24P', description: descripcion_erykah_badu, short_description: descripcion_erykah_badu, price: 5.000, cost_price: 4.050, tax_rate: tax_rate)
pro.product_category_ids = cat1.id
pro.default_image_file = get_file('erykah-badu.png')
if pro.save
  pro.stock_level_adjustments.create(description: 'Stock inicial', adjustment: 50)
end

pro = Shoppe::Product.new(name: 'Barry White', sku: 'YL-SIP-T25P', description: descripcion_barry_white, short_description: descripcion_barry_white, price: 5.000, cost_price: 4.050, tax_rate: tax_rate)
pro.product_category_ids = cat1.id
pro.default_image_file = get_file('barry-white.png')
if pro.save
  pro.stock_level_adjustments.create(description: 'Stock inicial', adjustment: 50)
end

pro = Shoppe::Product.new(name: 'Anita Baker', sku: 'YL-SIP-T26P', description: descripcion_anita_baker, short_description: descripcion_anita_baker, price: 5.000, cost_price: 4.050, tax_rate: tax_rate)
pro.product_category_ids = cat1.id
pro.default_image_file = get_file('anita-baker.png')
if pro.save
  pro.stock_level_adjustments.create(description: 'Stock inicial', adjustment: 50)
end

pro = Shoppe::Product.new(name: 'Cookie Wonder', sku: 'YL-SIP-T27P', description: descripcion_cookie_wonder, short_description: descripcion_cookie_wonder, price: 5.000, cost_price: 4.050, tax_rate: tax_rate)
pro.product_category_ids = cat1.id
pro.default_image_file = get_file('cookie-wonder.png')
if pro.save
  pro.stock_level_adjustments.create(description: 'Stock inicial', adjustment: 50)
end

pro = Shoppe::Product.new(name: 'Roberta', sku: 'YL-SIP-T28P', description: descripcion_roberta, short_description: descripcion_roberta, price: 5.000, cost_price: 4.050, tax_rate: tax_rate)
pro.product_category_ids = cat1.id
pro.default_image_file = get_file('roberta.png')
if pro.save
  pro.stock_level_adjustments.create(description: 'Stock inicial', adjustment: 50)
end

Shoppe::Country.create(name: "Colombia", code2: "CO", code3: "CO", continent: "America", tld: "SA", currency: "COP", eu_member: false)

State.create(name: "orden recibida", seq: 1)
State.create(name: "Tus Galletas estan siendo elaboradas", seq: 2)
State.create(name: "Tus galletas estan en el horno",seq: 3)
State.create(name: "¡ Tus galletas van en camino !", seq: 4)

