class ColombianProduct <  Shoppe::Product
  def price_with_tax
    self.price * tax_display
  end
  private
  def tax_display
    tax_display = 0
    if self.tax_rate.nil?
      tax_display = 0
    else
      tax_display = self.tax_rate.rate
    end
    (1 + (tax_display)/100)
  end
end