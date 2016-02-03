class Complement < ActiveRecord::Base
	#belongs_to :users
    def cpf? #acho que verifica campo de cpf vazio(usado para validar campo do boleto)
      self.cpf.blank?
    end
end
