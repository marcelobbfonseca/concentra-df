class Ability
  include CanCan::Ability

  def initialize(user)
  		user ||= User.new #guest. deslogado
  		#current_user.update_attribute :admin, true pra passar pra admin	

	  	if user.admin?  #erro #verifica se eh o admin logado
	  		can :manage, :all
	   	else			#verifica se eh congressista logado
	  		can :manage, Vacancy #pode escolher a vaga
	  		can :read, :all
	  	end
  end
end