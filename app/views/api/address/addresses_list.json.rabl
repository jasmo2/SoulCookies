object @address
attributes :id
node(:full_address) do |address|
  "#{address.address1},  #{address.address3}, #{address.postcode}, Colombia"
end