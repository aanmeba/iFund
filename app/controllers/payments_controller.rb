class PaymentsController < ApplicationController
  #
  skip_before_action :verify_authenticity_token, only: [:webhook]
  before_action :set_project_params, only: [:round_amount, :support_session, :success]
  before_action :round_amount, only: [:support_session]
  
  def success
    puts "********** payment_controller - success ***************"
    @support = Support.where(project_id: params[:id]).last
    @project.update(total_amount: (@project.total_amount += @project.amount))
  end

  def support_session
    puts "********** Payment_controller - support_session ***********"
    pp @project.id
    pp @project.title
    pp @project.amount
    
    begin
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        customer_email: current_user && current_user.email,
        line_items: [
          {
            name: @project.title,
            description: @project.description,
            amount: @project.amount,
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
        success_url: "#{root_url}payments/success/#{@project.id}",
        cancel_url: "#{root_url}projects/#{@project.id}"
      )
      
      @session_id = session.id
    rescue Stripe::InvalidRequestError => e
      redirect_to project_path(@project.id), notice: "Please enter the amount you want to support"
    end
  end

  def webhook
    puts "********** Payment_controller - webhook starts! ***********"

    begin
      payload = request.raw_post
      header = request.headers['HTTP_STRIPE_SIGNATURE']
      secret = Rails.application.credentials.dig(:stripe, :webhook_signing_secret)
      event = Stripe::Webhook.construct_event(payload, header, secret)
    rescue Stripe::SignatureVerificationError => e 
      render json: {error: "Unauthorised"}, status: 403
      return 
    rescue JSON::ParserError => e
      render json: {error: "Bad request"}, status: 422
      return
    end

    payment_intent_id = event.data.object.payment_intent
    payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
    project_id = payment.metadata.project_id
    @project = Project.find(project_id)
    supporter_id = payment.metadata.user_id
    receipt_url = payment.charges.data[0].receipt_url
    
    puts "********** Payment_controller - webhook ***********"
    pp event
    pp receipt_url

    # create Support entry and track extra info
    Support.create(project_id: project_id, supporter_id: supporter_id, payment_id: payment_intent_id, receipt_url: receipt_url)

    # update Project to sum up the total amount
    @project.update(amount: event.data.object.amount_total)
  end

  private

  def round_amount
    # input validation - round
    @project.amount = ((params[:price]).to_f).round(-2)
    puts "************ payment_controller - round_amount ***********"
    pp params[:price]
    pp @project.amount
  end

  def set_project_params
    @project = Project.find(params[:id])
    puts "********** Payment_controller - set_project_params ***********"
    pp @project.id
    pp @project.title
  end
end
