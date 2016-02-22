class GerencianetController < ApplicationController
  require "gerencianet"
  require "date"

  #--------------------------------------------------------------------------
  #duas etapas. 1-fazer transacao e 2-escolha se boleto ou cartao
  #--------------------------------------------------------------------------
  # salvação: http://suporte.mikweb.com.br/kb/articles/4-integrar-com-gerencianet
  # nome:concentradf token:afd498372043769ffe9114cd5601c030
  #
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
  # => valor: Valor do item em centavos .IMPORTANTE: VALORES SAO EM CENTAVOS: 150 = R$1,50
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
    #Em ordem
    #1.Descricao
    #2.Valor
    #3.Quantidade comprada
    #4.Frete(no caso nao tem)
    #5.Valor deo frete(no caso nao tem)

  #se o congressista nao gerou nenhum boleto antes faca isso:(verificar se tem complemento charge_id)
    
    idUsuario = params[:id_user]
    
    #encontra a modalidade pela vaga do usuario
    vaga = Vacancy.find_by_user_id(idUsuario)
    modalidade = ModalityFiliation.find_by_filiation_id(vaga.modality_filiation_id)

    #validando entrada, caso o usuario nao tenha vaga vai cair aqui
    unless vaga
      abort "voce nao tem uma vaga!"
    end

    #se o usuario ja tem uma transacao ele cai para notificacao
    if vaga.transacao_id

      abort "testar essa parte no heroku"
      notificar

    else

      # ".to_i" e o "* 100" sao pra corrigir o valor pro padrao do gerencianet. NAO TROQUE ISSO 
      precoCerto = modalidade.price * 100
      precoCerto.to_i

      body = {
        items: [{
          name: modalidade.name,  # modalidade.nome
          value: precoCerto,             
          amount: 1                     
        }],
        shippings: [{
          name: "sem frete",   
          value: 0    
        }]
      }
       
      gerencianet = Gerencianet.new(options)
      @resposta = gerencianet.create_charge(body: body)   #PEGANDO A resposta aqui!!
      #TRANSACAO CRIADA! fim da transacao 

      prazo = Date.today + 7  
      
      nome = params[:nome_usuario]
      cpf = params[:cpf]
      email = params[:email]

      params = {
        id: @resposta['data']['charge_id'] #4000 # id da charge a ser paga 
      }

      body = {
        payment: {
          banking_billet: {
            expire_at: prazo.strftime,    # 7 dias
            customer: {
              name: nome, #OBR
              email: email,
              cpf: cpf, #OBR
              birth: "1977-01-15",
              phone_number: "5144916523"
            }
          }
        }
      }
       
      gerencianet = Gerencianet.new(options)
      @resposta_boleto = gerencianet.pay_charge(params: params, body: body)
      #completo etapa 2

      #render 'transacao' usado para testes

      #vaga do usuario recebe o charge_id(id de transacao do boleto)
      vaga.update_attribute(:transacao_id, @resposta['data']['charge_id'])

      redirect_to @resposta_boleto['data']['link']
    end
  end

  def notificar
    #se der ruim, adicionar o charge id aos params que nem na linha 83/85
    params = {
      token: "http://concentradf.nomedosite.com.br/confirmar_fatura_gn" #@resposta_boleto['data']['status']
    }
     
    gerencianet = Gerencianet.new(options)
    @resposta_notificacao = gerencianet.get_notification(params: params)

  end
=begin
  def gerar_boleto
   
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
          </boleto>"@complemento.transacao_id = @resposta['data']['charge_id']
    xml.gsub(/[ \t\n]/, '')                                                 #retirar espaçamentos. precisa ta cru
    url = "https://testeintegracao.gerencianet.com.br/xml/boleto/emite/xml" #URL onde fará a requisicao via post
    token = "f5fb957d43ad3050d9c1b4cc3f6fe160"                              #token da aplicacao
    #fazer requisicao POST para testeintegracao
  end
=end
end