class BoletoGerencianet < ActionController
  require "gerencianet"
  require "date"
  #duas etapas. 1-fazer transacao e 2-escolha se boleto ou cartao
  def transacao #inicia uma transacao
    # id e segredo da minha conta de API no gerencianet(marcelinho)
    options = {
      client_id: "Client_Id_2bad46375dd5d0081c39bbace297682e968821b2", 
      client_secret: "Client_Secret_6b5fb0c68919ec003aebcaaa2c96fd9987692635",
      sandbox: true #modo teste verdadeiro. NAO TROCA ESSA PORRA!
    }
     
    body = {
      items: [{
        name: "Product 1",
        value: 1000,
        amount: 2
      }],
      shippings: [{
        name: "Default Shipping Cost",
        value: 100
      }]
    }
     
    gerencianet = Gerencianet.new(options)
    gerencianet.create_charge(body: body)
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
      id: 2365 # id da charge a ser paga
    }
     
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
end