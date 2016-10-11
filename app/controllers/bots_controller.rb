class BotsController < ApplicationController
	before_action :connect_ai, only: [:create]

	def create
		@message = current_user.messages.build(bot_params)
  	@message.save
	end

	private
	def bot_params
		response = @client.text_request params[:bot][:body]
		params[:bot][:body] = response[:result][:fulfillment][:speech]
		params.require(:bot).permit(:body, :status)		
	end

	def connect_ai
		@client = ApiAiRuby::Client.new(
		  client_access_token: ENV['AI_API_ACCESS']
		)
	end
end
