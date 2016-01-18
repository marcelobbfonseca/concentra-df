class Complement < ActiveRecord::Base

    def cpf? #acho que verifica campo de cpf vazio(usado para validar campo do boleto)
      self.cpf.blank?
    end
end
