class PagarmeController < ApplicationController
	require "pagarme"
	#TESTE
	#chave de API: ak_test_XEzUxY3hjKReOSCMX1LtXjT7SEP2To
	#chave integração: ek_test_8Iii0BHIsQNJTQ8XPp3ZlLboun312Z

	def paginacartao
		render 'cartao' 	#carrega a pagina pro preenchimento do form
	end
end