class RelationshipsController < ApplicationController
	
	def create
		followed = User.find(params[:followed_id])
		new_relationship = current_user.relationships.new(followed_id: followed.id)
		if new_relationship.save
			
		else
		
		end

	end

end
