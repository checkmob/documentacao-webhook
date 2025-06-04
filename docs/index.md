# Webhook - Checkmob

## O que é Webhook?

Webhook é um método de comunicação entre sistemas que permite que um sistema envie automaticamente dados para outro sistema em tempo real quando um evento específico ocorre. É como um "callback" ou "notificação" que um sistema envia para outro através de uma requisição HTTP POST.

### Principais características:
- **Comunicação em tempo real**: Os dados são enviados instantaneamente quando um evento ocorre
- **Automação**: Não requer intervenção manual para o envio das informações
- **Eficiência**: Reduz a necessidade de consultas constantes (polling) ao sistema
- **Flexibilidade**: Pode ser configurado para diferentes tipos de eventos

O webhook será chamado sempre que ocorrerem eventos relevantes no sistema, de acordo com os tipos de dados descritos abaixo.

## Estrutura Geral da Requisição

```json
{
  "Tipo": 1,
  "Data": [
    {
      // Dados específicos do tipo
    }
  ]
}
```

- **Tipo**: Define o tipo de evento.
- **Data**: Lista com os objetos do evento.

## Tipos de Evento

### Tipo 1 - Criação e Edição de Cliente

Enviado sempre que um cliente é criado ou editado no sistema.

#### Estrutura dos dados:
Inclui informações como código, nome, documentos, contatos, localização, segmentos e campos personalizados.

#### Exemplo de JSON:

```json
{
  "Tipo": 1,
  "Data": [
    {
      "Tipo": 1,
      "cliente": {
        "IdCliente": 12345678,
        "Nome": "Cliente Exemplo",
        "Cnpj": "12.345.678/0001-90",
        "Cpf": "123.456.789-00",
        "Telefone": "(11) 99999-9999",
        "TelefoneSecundario": "(11) 98888-8888",
        "IdUltimoServico": 987654,
        "DataProximoAcompanhamento": "2025-06-10T00:00:00",
        "AvaliacaoIA": "Aguardando",
        "Responsavel": "Responsável Exemplo",
        "Ativo": true,
        "DataCadastro": "2025-06-04T16:00:00",
        "DataAtualizacao": "2025-06-04T17:00:00",
        "IdEndereco": 11223344,
        "Rua": "Rua Exemplo",
        "Numero": "100",
        "Complemento": "Sala 10",
        "Bairro": "Centro",
        "Cep": 12345678,
        "Cidade": "Cidade Exemplo",
        "Estado": "Estado Exemplo",
        "Pais": "Brasil",
        "Latitude": -23.55052,
        "Longitude": -46.633308,
        "CampoPersonalizado": [
          {
            "Nome": "Campo 1",
            "ValorCampo": "Valor Exemplo"
          },
          {
            "Nome": "Campo 2",
            "ValorCampo": "10/06/2025"
          },
          {
            "Nome": "Campo 3",
            "ValorCampo": "Texto Exemplo"
          }
        ]
      }
    }
  ]
}
```

### Tipo 2 - Registro Realizado

Enviado quando um registro (check-in, atendimento ou execução de serviço) é realizado no aplicativo.

#### Estrutura dos dados:
Inclui informações como código, status, cliente, localização, horários, observações e dados operacionais.

#### Exemplo de JSON:

```json
{
  "Tipo": 2,
  "Data": [
    {
      // Dados específicos do tipo
    }
  ]
}
```

### Tipo 3 - Checklist Respondido

Enviado quando um checklist é respondido no aplicativo.

#### Estrutura dos dados:
Inclui informações como identificador, nome, datas de vigência, cabeçalho, rodapé, configurações e descrição.

#### Exemplo de JSON:

```json
{
  "Tipo": 3,
  "Data": [
    {
      // Dados específicos do tipo
    }
  ]
}
```

## Observações

- O webhook envia os dados sempre dentro de um array na propriedade Data, mesmo que haja apenas um item.
- O campo Tipo permite identificar rapidamente o tipo de evento recebido.
- O formato dos dados em Data varia conforme o valor de Tipo.

## Configuração e Suporte

### Configuração do Webhook
Para receber as notificações dos eventos, é necessário configurar a URL do webhook nas configurações do sistema Checkmob. Esta URL será o endpoint que receberá todas as notificações dos eventos configurados.

### Suporte Técnico
Em caso de dúvidas sobre a implementação, configuração ou funcionamento do webhook, nossa equipe de suporte está disponível para auxiliar. Entre em contato através dos canais de suporte da Checkmob.

## Conclusão
Para garantir o melhor funcionamento, recomendamos:

- Implementar tratamento de erros adequado
- Configurar timeouts apropriados
- Manter um log das requisições recebidas


Esta documentação fornece todas as informações necessárias para implementar e utilizar o webhook da Checkmob. O sistema foi projetado para ser robusto, seguro e fácil de integrar, permitindo que você receba atualizações em tempo real sobre eventos importantes do seu negócio.


