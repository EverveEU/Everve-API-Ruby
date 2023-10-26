require 'net/http'
require 'uri'
require 'json'

class EverveAPI
  def initialize(api_key)
    @api_key = api_key
    @base_url = 'https://api.everve.net/v3/'
  end

  def make_request(endpoint, params = {})
    params[:api_key] = @api_key
    params[:format] = 'json'
    uri = URI.parse(@base_url + endpoint)
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def get_user
    make_request('user')
  end

  def get_socials
    make_request('socials')
  end

  def get_categories(id = nil)
    endpoint = id ? "categories/#{id}" : 'categories'
    make_request(endpoint)
  end

  def create_order(params)
    make_request('orders', params)
  end

  def get_orders(id = nil)
    endpoint = id ? "orders/#{id}" : 'orders'
    make_request(endpoint)
  end

  def update_order(id, params)
    params[:id] = id
    make_request("orders/#{id}", params)
  end

  def delete_order(id)
    make_request("orders/#{id}", _method: 'DELETE')
  end
end

# EXAMPLE
# api = EverveAPI.new('your_api_key_here')
# user_info = api.get_user
# puts "User Info: #{user_info}"