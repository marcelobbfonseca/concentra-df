class PagarmeController < ApplicationController
	#TESTE
	#chave de API: ak_test_XEzUxY3hjKReOSCMX1LtXjT7SEP2To
	#chave integração(encription key): ek_test_8Iii0BHIsQNJTQ8XPp3ZlLboun312Z
	require "pagarme"
	skip_before_action :verify_authenticity_token #pra arrumar ActionController::InvalidAuthenticityToken
	

	def paginacartao
		render 'cartao' 	#carrega a pagina pro preenchimento do form
	end


	def transacao
		PagarMe.api_key = "ak_test_XEzUxY3hjKReOSCMX1LtXjT7SEP2To";

	    #encontra a modalidade pela vaga do usuario
	    vaga = Vacancy.find_by_user_id(current_user.id)
	    mf = ModalityFiliation.find(vaga.modality_filiation_id)
	    
	    #byebug

	    #validando entrada, caso o usuario nao tenha vaga vai cair aqui
	    unless vaga
	      abort "voce nao tem uma vaga!"
	    end

	    if vaga.transacao_id
	    	notificar
	    else 

		    # ".to_i" e o "* 100" sao pra corrigir o valor pro padrao do pagarme. NAO TROQUE ISSO 
	      	precoCerto = mf.price * 100
	      	precoCerto.to_i


			transaction = PagarMe::Transaction.new({
			    :amount => precoCerto, #Ex: R$14,99 = 1499
			    :card_hash => params[:card_hash]
			})

			transaction.charge

			status = transaction.status # status da transação


			#ATENCAO!!!!
			#vaga do usuario recebe o id da transacao do cartao. isso SE o status retornar como pago
			#isso serve pra validação pro cara não acabar fazendo uma segunda transacao e pagar duas vezes
			#<<SELO Critico para teste!!!>> Retirar esse comentario apos confirmação de que funciona
			status.to_s
			if status.eql? "paid"
	      		vaga.update_attribute(:transacao_id, transaction['tid'])
	      	end

			render 'sucesso'
		end
	end
	def notificar
		abort "olar, voce ja pagou!"
		render 'sucesso'
	end

end