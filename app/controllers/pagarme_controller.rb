class PagarmeController < ApplicationController
	require "pagarme"
	#TESTE
	#chave de API: ak_test_XEzUxY3hjKReOSCMX1LtXjT7SEP2To
	#chave integração(encription key): ek_test_8Iii0BHIsQNJTQ8XPp3ZlLboun312Z

			
	def paginacartao
		render 'cartao' 	#carrega a pagina pro preenchimento do form
	end


	def transacao
		PagarMe.api_key = "ak_test_XEzUxY3hjKReOSCMX1LtXjT7SEP2To";


	    #encontra a modalidade pela vaga do usuario
	    vaga = Vacancy.find_by_user_id(idUsuario)
	    mf = ModalityFiliation.find(vaga.modality_filiation_id)

	    #validando entrada, caso o usuario nao tenha vaga vai cair aqui
	    unless vaga
	      abort "voce nao tem uma vaga!"
	    end

	    # ".to_i" e o "* 100" sao pra corrigir o valor pro padrao do pagarme. NAO TROQUE ISSO 
      	precoCerto = mf.price * 100
      	precoCerto.to_i


		transaction = PagarMe::Transaction.new({
		    :amount => precoCerto, #Ex: R$14,99 = 1499
		    :card_hash => "{CARD_HASH}"
		})

		transaction.charge

		status = transaction.status # status da transação
		
	end


end