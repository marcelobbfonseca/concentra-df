class Ability
  include CanCan::Ability

  def initialize(user)
  		user ||= User.new #guest. deslogado
	  	if user.admin?  #erro #verifica se eh o admin logado
	  		can :manage, :all
	   	else			#verifica se eh congressista logado. :create :update :destroy
	  		if User.exists?(user) #funciona mas faz query no bd. mais lento
	  		#if user.encrypted_password # vai verificar se o padrao devise de senha existe pra instancia usuario. Se o bd nao tiver zoado, isso so retorna valor se o cara tiver logado 
	  			can :manage, Vacancy #pode escolher a vaga
	  			
	  		end	  		
	  		can :read, :all
	  	
	  	end

	  	#se deslogado
	  	#cannot :read, Vacancy
  end
end