class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = ["Oatmeal", "Salmon", "Rice", "Chicken Breast"]

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

    if req.path.match(/cart/)
      if @@cart.length == 0
        resp.write "Your cart is empty"
      else
        @@cart.each do |cart_item|
          resp.write "#{cart_item}\n"
        end
      end
    end

    if req.path.match(/add/)
      search_item = req.params["item"]

      if @@items.include?(search_item)
        @@cart << search_item
        resp.write "added #{search_item}"
      else
        resp.write "We don't have that item"
      end

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
