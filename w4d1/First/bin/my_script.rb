require 'addressable/uri'
require 'rest-client'

# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users.html',
#   query_values: {
#     'some_category[a]' => 'another value',
#     'some_category[b]' => 'whatever'
#   }
# ).to_s
#
# puts RestClient.get(url)

def update_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s

  puts RestClient.patch(
    url,
    { user: { name: 'Breakfast'} }
  )
end

User.find(5).update_user
