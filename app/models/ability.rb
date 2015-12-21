class Ability
  include CanCan::Ability

  def initialize(user)
  		user ||= User.new #guest. deslogado
  		#current_user.update_attribute :admin, true pra passar pra admin	
  	#if current_user?
	  	if user.admin == true  #erro #verifica se eh o admin logado
	  		can :manage, :all
	   	else			#verifica se eh congressista logado
	  		can :read, :all
	  	end
	#end
  end
end