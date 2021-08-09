class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only:[:webhook]
    def success
    end 
    def webhook
        payment_id = params[:data][:object][:payment_intent]
        payment = Stripe::PaymentIntent.retrieve(payment_id)
        event_id = payment.metadata.event_id
        #user_id = payment.metadata.user_id
        p "Event id " + event_id 
        #p "user id " + user_id 
        render plain: "success"
    end
    def page
    #     @product = Product.find(params[:product_id])
    #     Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
    #   session = Stripe::Checkout::Session.create({ 
    #     payment_method_types: [
    #     'card',
    #     ], 
    #      customer_email: current_user ? current_user.email : nil,
    #      line_items: [{
    #       price_data: { 
    #        unit_amount: (@product.price * 100).to_i,
    #         currency: "aud",
    #         product_data: {
    #         name: @product.name,
    #         description: @product.desription
    #        }
    #     },
    #      quantity: 1,
    #    }],
    #    payment_intent_data:{ 
    #      metadata: { 
    #        product_id: @product.id,
    #      }
    #    },
    #   mode: 'payment',
    #    success_url: "#{root_url}payments/success",
    #    cancel_url: "#{root_url}products",
    #  })
    #  @session_id = session.id
    end 
end



  

