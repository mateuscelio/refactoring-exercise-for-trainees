FactoryBot.define do
  factory :address_params, class: Hash do
    initialize_with do
      {
        address_1: 'address_1',
        address_2: 'address_2',
        city: 'city',
        state: 'state',
        country: 'country',
        zip: 'zip'
      }
    end
  end
end
