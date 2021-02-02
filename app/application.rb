class Application

  @@items = ["Apples","Carrots","Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end


# require_relative './spec_helper'

# describe "Shopping Cart Rack App" do
#   def app()
#     Application.new
#   end
#   describe "/cart" do
#     it "responds with empty cart message if the cart is empty" do
#       Application.class_variable_set(:@@cart, [])
#       get '/cart'
#       expect(last_response.body).to include("Your cart is empty")
#     end

#     it "responds with a cart list if there is something in there" do
#       Application.class_variable_set(:@@cart, ["Apples","Oranges"])
#       get '/cart'
#       expect(last_response.body).to include("Apples\nOranges")
#     end
#   end

#   describe "/add" do

#     it 'Will add an item that is in the @@items list' do
#       Application.class_variable_set(:@@items, ["Figs","Oranges"])
#       get '/add?item=Figs'
#       expect(last_response.body).to include("added Figs")
#       expect(Application.class_variable_get(:@@cart)).to include("Figs")
#     end

#     it 'Will not add an item that is not in the @@items list' do
#       Application.class_variable_set(:@@items, ["Figs","Oranges"])
#       get '/add?item=Apples'
#       expect(last_response.body).to include("We don't have that item")
#     end
#   end
# end
