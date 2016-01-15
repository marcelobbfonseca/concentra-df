class GerencianetController < ApplicationController
  require "gerencianet"
  require "date"

  #--------------------------------------------------------------------------
  #duas etapas. 1-fazer transacao e 2-escolha se boleto ou cartao
  #--------------------------------------------------------------------------
  # token: f5fb957d43ad3050d9c1b4cc3f6fe160 
  # client_id: "Client_Id_2bad46375dd5d0081c39bbace297682e968821b2" 
  # client_secret: "Client_Secret_6b5fb0c68919ec003aebcaaa2c96fd9987692635"
  #
  #--------------------------------------------------------------------------
  #
  #dados obrigatorios:
  # => Token: Chave de integração com 32 char gerada na conta
  # => NomeRazaoSocial: Nome do cliente ou razao social da empresa
  # => cpfcnpj: Meio obvio esse. Deve conter 11 ou 14 char sendo apenas numeros
  # => cel: Celular do cliente com DDD. 10 ou 11 digitos.
  # => Descricao: descricao do item envolvido
  # => valor: Valor do item em centavos
  # => qtde: QUantidade desse item
  #
  #
  def transacao #inicia uma transacao
    # id e segredo da minha conta de API no gerencianet(marcelinho)
    options = {
      client_id: "Client_Id_2bad46375dd5d0081c39bbace297682e968821b2", 
      client_secret: "Client_Secret_6b5fb0c68919ec003aebcaaa2c96fd9987692635",
      sandbox: true #modo teste verdadeiro. NAO TROCA ESSA PORRA!
    }
    #IMPORTANTE: VALORES SAO EM CENTAVOS: 150 = R$1,50
    #precisa de descricao da modalidade(nome), valor e quantidade(no caso 1)
    body = {
      items: [{
        name: "Vaga EJ federada",
        value: 1000,
        amount: 1
      }],
      metadata: {
        custom_id: "Client_Id_2bad46375dd5d0081c39bbace297682e968821b2",
        notification_url: "http://localhost:3000" #receber notificacao
      },
      post_office_service: {
        send_to: "customer" #pode ser seller ou customer. Seller: manda pra mim <3
      },
      shippings: [{
        name: "",   #nao tem frete
        value: 0    #valor do frete
      }]
    }
     
    gerencianet = Gerencianet.new(options)
    resposta = gerencianet.create_charge(body: body)   #PEGANDO A resposta aqui!!
    resposta.inspect
    #precisa linkar uma view! missing template!
    #redirect_to boleto 
  end

  def boleto #boleto.
     
    # id e segredo da minha conta de API no gerencianet(marcelinho)
    options = { 
      client_id: "Client_Id_2bad46375dd5d0081c39bbace297682e968821b2", 
      client_secret: "Client_Secret_6b5fb0c68919ec003aebcaaa2c96fd9987692635",
      sandbox: true #POR OBSEQUIO, NAO TROCAR ISSO PRA FALSO.
    }
     
    tomorrow = Date.today + 1  
     
    params = {
      id: 4000 # id da charge a ser paga
    }
     #precisa de  User: Nome, email.  Complemento:cpf, nascimento e telefone
    body = {
      payment: {
        banking_billet: {
          expire_at: tomorrow.strftime,
          customer: {
            name: "Paulo Guina",
            email: "oldbuck@gerencianet.com.br",
            cpf: "04267484171",
            birth: "1977-01-15",
            phone_number: "5144916523"
          }
        }
      }
    }
     
    gerencianet = Gerencianet.new(options)
    gerencianet.pay_charge(params: params, body: body)

  end

  def gerar_boleto
    #xml a ser enviado
    xml = "<boleto>  
            <token>OBR</token>
            <clientes>
              <cliente>OBR</cliente>
              <nomeRazaoSocial>OBR</nomeRazaoSocial>
              <cpfcnpj>OBR</cpfcnpj>
              <cel>OBR</cel>
              <opcionais>
                <cep></cep>
                <rua></rua>
                <numero></numero>
                <bairro></bairro>
                <complemento></complemento>
                <cidade></cidade>
                <estado></estado>
                <retorno></retorno>
              </opcionais>
            </clientes>
            <itens>
              <item>
                <valor>OBR</valor>
                <descricao>OBR</descricao>
                <valor>OBR</valor>
                <qtde>OBR</qtde>
                <desconto>OPT</desconto>
              </item>
            </itens>
            <vencimento>OPT</vencimento>
          </boleto>"
    xml.gsub(/[ \t\n]/, '')                                                 #retirar espaçamentos. precisa ta cru
    url = "https://testeintegracao.gerencianet.com.br/xml/boleto/emite/xml" #URL onde fará a requisicao via post
    token = "f5fb957d43ad3050d9c1b4cc3f6fe160"                              #token da aplicacao
    #fazer requisicao POST para testeintegracao
  end
end