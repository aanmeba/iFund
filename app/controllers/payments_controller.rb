class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]
  
  def success
    # @order = Project.find_by(listing_id: params[:id])
    # pp @order
    puts "==========="
  end

  def support_session
    
    @project = Project.find(params[:id])
    @project.amount = params[:price]

    if @project.amount
      puts "GREAT!!!!"
      pp params
    
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        customer_email: current_user && current_user.email,
        line_items: [
          {
            name: @project.title,
            description: @project.description,
            amount: @project.amount,
            # amount: @project.amount,
            currency: 'aud',
            quantity: 1
          }
        ],
        payment_intent_data: {
          metadata: {
            user_id: current_user && current_user.id,
            project_id: @project.id
          }
        },
        success_url: "#{root_url}/payments/success/#{@project.id}",
        cancel_url: root_url
      )
      
      @session_id = session.id
      pp @session_id
    else
      puts "what the...."
    end
  end
end
