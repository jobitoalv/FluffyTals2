module ProductsHelper
     def render_buy_button(current_user, product)
        if current_user
             button = "<button data-stripe=\"payment\" class='btn btn-primary p-3'> Buy: $#{product.price}</button>"
        else
             button = "<button class=\"btn btn-primary\" disabled>Log In To Buy</button>"
        end 
        return button.html_safe
     end
end
