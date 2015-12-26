class Ability
  include CanCan::Ability

  def initialize(user)
  		user ||= User.new #guest. deslogado

	  	if user.admin?  #erro #verifica se eh o admin logado
	  		can :manage, :all
	   	else			#verifica se eh congressista logado. :create :update :destroy
	  		can :manage, Vacancy #pode escolher a vaga
	  		#can :update, User do |user|
	  		#	this.user == user
	  		can :read, :all
	  	end
  end
end