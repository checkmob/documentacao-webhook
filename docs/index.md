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

Todas as notificações são enviadas como `POST` com corpo `application/json`, no formato:

```json
{
  "Tipo": 1,
  "Data": {
    // Dados específicos do tipo
  }
}
```

- **Tipo**: número que identifica o evento (ver tabela abaixo).
- **Data**: objeto com os dados do evento. O formato varia conforme o valor de `Tipo`.

### Convenções

- Os nomes dos campos são enviados em **PascalCase**, exatamente como descritos nesta página.
- Datas seguem o formato ISO 8601 (`2025-06-04T16:00:00`) e estão em **UTC**.
- Campos sem valor são enviados como `null`. Listas sem itens são enviadas como `[]`.
- Novos campos podem ser adicionados ao payload no futuro. Sua integração deve ignorar campos que não conhece.


## Tipos de Evento

| Tipo | Evento | Quando é enviado |
|------|--------|------------------|
| 1 | Cliente criado | Um cliente é cadastrado pela plataforma web ou pelo aplicativo. |
| 2 | Cliente editado | Um cliente é editado pela plataforma web ou pelo aplicativo. |
| 3 | Registro criado/atualizado | Um registro é enviado ou atualizado pelo aplicativo (check-in, check-out, mudança de status), ou é agendado/editado pela plataforma web. |
| 4 | Checklist respondido | Um checklist é enviado pelo aplicativo, seja parcial ou completo. |


### Tipo 1 - Cliente criado

Enviado sempre que um cliente é cadastrado, pela plataforma web ou pelo aplicativo.

### Tipo 2 - Cliente editado

Enviado sempre que um cliente é editado, pela plataforma web ou pelo aplicativo. O payload é idêntico ao do Tipo 1 e traz o cliente já com os dados atualizados.

#### Exemplo de JSON (Tipos 1 e 2):

```json
{
  "Tipo": 1,
  "Data": {
    "IdCliente": 12345678,
    "Codigo": 1020,
    "Nome": "Cliente Exemplo",
    "RazaoSocial": "Cliente Exemplo LTDA",
    "NomeFantasia": "Cliente Exemplo",
    "CodigoFiscal": "12345678000190",
    "Cnpj": "12.345.678/0001-90",
    "Cpf": null,
    "TipoCliente": "Varejo",
    "Telefone": "(11) 99999-9999",
    "TelefoneSecundario": "(11) 98888-8888",
    "Site": "https://www.exemplo.com.br",
    "Linkedin": "https://www.linkedin.com/company/exemplo",
    "QrCode": null,
    "InformacoesAdicionais": "Atendimento somente no período da manhã",
    "Responsavel": "Responsável Exemplo",
    "EmailResponsavel": "responsavel@exemplo.com.br",
    "TelefoneResponsavel": "(11) 3333-3333",
    "CelularResponsavel": "(11) 97777-7777",
    "CargoResponsavel": "Gerente",
    "IdUltimoServico": 987654,
    "DataProximoAcompanhamento": "2025-06-10T00:00:00",
    "CicloVisita": 30,
    "AvaliacaoIA": null,
    "RangeCheckin": 200,
    "IdEtapa": 55,
    "Etapa": "Negociação",
    "IdSetorMercado": 12,
    "SetorMercado": "Alimentos",
    "IdTemperatura": 3,
    "Temperatura": "Quente",
    "IdCategoria": 8,
    "Categoria": "Categoria A",
    "ValorNegocio": 15000.00,
    "DataEsperadaFechamento": "2025-07-01T00:00:00",
    "Ativo": true,
    "CriadoMobile": false,
    "DataCadastro": "2025-06-04T16:00:00",
    "DataAtualizacao": "2025-06-04T17:00:00",
    "IdEndereco": 11223344,
    "Rua": "Rua Exemplo",
    "Numero": "100",
    "Complemento": "Sala 10",
    "Bairro": "Centro",
    "Cep": 12345678,
    "Cidade": "São Paulo",
    "Estado": "São Paulo",
    "Pais": "Brasil",
    "Latitude": -23.55052,
    "Longitude": -46.633308,
    "Segmentos": [
      {
        "IdSegmento": 333444,
        "Nome": "Segmento Exemplo"
      }
    ],
    "Contatos": [
      {
        "IdPessoa": 445566,
        "Nome": "Contato Exemplo",
        "Email": "contato@exemplo.com.br",
        "Telefone": "(11) 3333-4444",
        "Celular": "(11) 96666-6666"
      }
    ],
    "CampoPersonalizado": [
      {
        "IdCampo": 901,
        "Nome": "Campo 1",
        "ValorCampo": "Valor Exemplo"
      },
      {
        "IdCampo": 902,
        "Nome": "Campo 2",
        "ValorCampo": "10/06/2025 00:00:00"
      }
    ]
  }
}
```

#### Campos:

| Campo | Tipo | Descrição |
|-------|------|-----------|
| IdCliente | número | Identificador interno do cliente. |
| Codigo | número \| null | Código do cliente exibido na plataforma. |
| Nome | texto | Nome do cliente. |
| RazaoSocial | texto \| null | Razão social. |
| NomeFantasia | texto \| null | Nome fantasia. |
| CodigoFiscal | texto \| null | Identificador fiscal sem máscara (CNPJ, CPF ou equivalente de outro país). |
| Cnpj | texto \| null | CNPJ. |
| Cpf | texto \| null | CPF. |
| TipoCliente | texto \| null | Tipo do cliente. |
| Telefone | texto \| null | Telefone principal. |
| TelefoneSecundario | texto \| null | Telefone secundário. |
| Site | texto \| null | Site. |
| Linkedin | texto \| null | Perfil no LinkedIn. |
| QrCode | texto \| null | Conteúdo do QR Code vinculado ao cliente. |
| InformacoesAdicionais | texto \| null | Informações adicionais. |
| Responsavel | texto \| null | Nome do responsável. |
| EmailResponsavel | texto \| null | E-mail do responsável. |
| TelefoneResponsavel | texto \| null | Telefone do responsável. |
| CelularResponsavel | texto \| null | Celular do responsável. |
| CargoResponsavel | texto \| null | Cargo do responsável. |
| IdUltimoServico | número \| null | Identificador do último registro feito no cliente. |
| DataProximoAcompanhamento | data \| null | Data do próximo acompanhamento. |
| CicloVisita | número \| null | Ciclo de visita, em dias. |
| AvaliacaoIA | número \| null | Avaliação do cliente feita pela IA. |
| RangeCheckin | número | Distância máxima (em metros) para check-in/check-out. |
| IdEtapa / Etapa | número / texto \| null | Etapa do funil (CRM). |
| IdSetorMercado / SetorMercado | número / texto \| null | Setor de mercado (CRM). |
| IdTemperatura / Temperatura | número / texto \| null | Temperatura (CRM). |
| IdCategoria / Categoria | número / texto \| null | Categoria (CRM). |
| ValorNegocio | número \| null | Valor do negócio (CRM). |
| DataEsperadaFechamento | data \| null | Data esperada de fechamento (CRM). |
| Ativo | booleano | Indica se o cliente está ativo. |
| CriadoMobile | booleano | Indica se o cliente foi criado pelo aplicativo. |
| DataCadastro | data | Data de cadastro. |
| DataAtualizacao | data | Data da última atualização. |
| IdEndereco, Rua, Numero, Complemento, Bairro, Cep, Cidade, Estado, Pais, Latitude, Longitude | — | Endereço principal do cliente. Todos `null` quando não há endereço. `Cep` é numérico, sem máscara. |
| Segmentos | lista | Segmentos aos quais o cliente está vinculado. |
| Contatos | lista | Contatos (pessoas) vinculados ao cliente. |
| CampoPersonalizado | lista | Campos personalizados do cliente. `ValorCampo` traz o texto digitado, o nome da opção selecionada ou a data, conforme o tipo do campo. |


### Tipo 3 - Registro criado/atualizado

Enviado quando um registro (check-in, atendimento ou execução de serviço) é criado ou atualizado:

- **Aplicativo**: a cada envio do registro (check-in, check-out, mudança de status). Um mesmo registro pode gerar várias notificações ao longo da execução.
- **Plataforma web**: ao agendar um registro, ao editar um agendamento e ao editar os detalhes de um registro.

Use o campo `Id` para identificar o registro e `IdStatus`/`NomeStatus` para saber em que etapa ele está.

#### Exemplo de JSON:

```json
{
  "Tipo": 3,
  "Data": {
    "Id": 7654321,
    "Codigo": 12345678,
    "IdCliente": 87654321,
    "CodigoCliente": 1020,
    "NomeCliente": "Cliente Exemplo",
    "IdPessoa": 445566,
    "NomePessoa": "Contato Exemplo",
    "IdGrupo": 111222,
    "NomeGrupo": "Grupo Exemplo",
    "IdSegmento": 333444,
    "NomeSegmento": "Segmento Exemplo",
    "IdOrdemServico": 555666,
    "IdObjetivo": 777888,
    "NomeObjetivo": "Objetivo Exemplo",
    "Observacao": "Observação de exemplo",
    "Instrucoes": "Levar o equipamento de medição",
    "EnderecoAproximado": "Rua Exemplo 100, Bairro Centro, Cidade Exemplo, Estado, 12345-678, Brasil",
    "IdUsuario": 999000,
    "NomeUsuario": "Usuário Exemplo",
    "Latitude": -23.55052,
    "Longitude": -46.633308,
    "DataCheckIn": "2025-06-04T09:00:00",
    "DataCheckOut": "2025-06-04T09:30:00",
    "IdStatus": 1234,
    "NomeStatus": "Realizado",
    "DataAlteracaoStatus": "2025-06-04T09:30:00",
    "MotivoReprovacao": null,
    "Incompleto": false,
    "CheckoutForcado": false,
    "DataEnvio": "2025-06-04T09:31:00",
    "IdUsuarioCriador": 999000,
    "Agendado": true,
    "DataInicioEsperada": "2025-06-04T09:00:00",
    "DataConclusaoEsperada": "2025-06-04T10:00:00",
    "Ativo": true,
    "Excluido": false,
    "DataAtualizacao": "2025-06-04T09:31:00"
  }
}
```

#### Campos:

| Campo | Tipo | Descrição |
|-------|------|-----------|
| Id | número | Identificador interno do registro. |
| Codigo | número | Código sequencial do registro exibido na plataforma. |
| IdCliente / NomeCliente | número / texto | Cliente do registro. |
| CodigoCliente | número \| null | Código do cliente exibido na plataforma. |
| IdPessoa / NomePessoa | número / texto \| null | Contato do cliente vinculado ao registro. |
| IdGrupo / NomeGrupo | número / texto \| null | Equipe. |
| IdSegmento / NomeSegmento | número / texto \| null | Segmento. |
| IdOrdemServico | número \| null | Ordem de serviço à qual o registro pertence. |
| IdObjetivo / NomeObjetivo | número / texto \| null | Objetivo (tipo de serviço). |
| Observacao | texto \| null | Observação registrada pelo usuário. |
| Instrucoes | texto \| null | Instruções do agendamento. |
| EnderecoAproximado | texto \| null | Endereço aproximado do registro. |
| IdUsuario / NomeUsuario | número / texto | Usuário responsável pela execução. |
| Latitude / Longitude | número \| null | Coordenadas do registro. |
| DataCheckIn | data \| null | Data do check-in. |
| DataCheckOut | data | Data do check-out. Só é significativa quando `Incompleto` é `false`. |
| IdStatus / NomeStatus | número / texto | Status atual do registro. |
| DataAlteracaoStatus | data | Data da última mudança de status. |
| MotivoReprovacao | texto \| null | Motivo, quando o registro foi reprovado. |
| Incompleto | booleano | `true` enquanto o registro ainda não tem check-out (em andamento). |
| CheckoutForcado | booleano | Indica se o registro foi encerrado com o status "Checkout forçado". |
| DataEnvio | data | Data de envio do registro. |
| IdUsuarioCriador | número \| null | Usuário que criou o registro. |
| Agendado | booleano | Indica se o registro nasceu de um agendamento. |
| DataInicioEsperada / DataConclusaoEsperada | data \| null | Janela prevista do agendamento. |
| Ativo | booleano | Em agendamentos, `false` indica que o registro ainda não foi enviado ao usuário ("A enviar"). |
| Excluido | booleano | Indica se o registro foi excluído. |
| DataAtualizacao | data \| null | Data da última atualização. |


### Tipo 4 - Checklist respondido

Enviado quando um checklist é enviado pelo aplicativo. O mesmo checklist pode ser enviado mais de uma vez (salvamento parcial e depois completo). Use `Id` para identificar o checklist e `Situacao` para saber se ele está completo.

#### Exemplo de JSON:

```json
{
  "Tipo": 4,
  "Data": {
    "Id": 3344556,
    "Numero": 150,
    "IdQuestionario": 4321,
    "NomeQuestionario": "Checklist de Instalação",
    "Situacao": 1,
    "DataCadastro": "2025-06-04T09:10:00",
    "DataAtualizacao": "2025-06-04T09:25:00",
    "IdUsuario": 999000,
    "NomeUsuario": "Usuário Exemplo",
    "IdCliente": 87654321,
    "CodigoCliente": 1020,
    "NomeCliente": "Cliente Exemplo",
    "IdServico": 7654321,
    "CodigoServico": 12345678,
    "Respostas": [
      {
        "NumeroSecao": 1,
        "IdQuestao": 9001,
        "NumeroQuestao": "1.1",
        "NomeQuestao": "O equipamento foi instalado?",
        "IdItemQuestao": 70001,
        "NumeroItemQuestao": "1.1.1",
        "NomeItemQuestao": "Sim",
        "Resposta": "true",
        "Observacao": null
      },
      {
        "NumeroSecao": 1,
        "IdQuestao": 9001,
        "NumeroQuestao": "1.1",
        "NomeQuestao": "O equipamento foi instalado?",
        "IdItemQuestao": 70002,
        "NumeroItemQuestao": "1.1.2",
        "NomeItemQuestao": "Não",
        "Resposta": "false",
        "Observacao": null
      },
      {
        "NumeroSecao": 1,
        "IdQuestao": 9002,
        "NumeroQuestao": "1.2",
        "NomeQuestao": "Número de série",
        "IdItemQuestao": 70003,
        "NumeroItemQuestao": "1.2.1",
        "NomeItemQuestao": "Número de série",
        "Resposta": "SN-000123",
        "Observacao": "Etiqueta parcialmente apagada"
      }
    ]
  }
}
```

#### Campos:

| Campo | Tipo | Descrição |
|-------|------|-----------|
| Id | número | Identificador interno do checklist respondido. |
| Numero | número \| null | Número sequencial do checklist exibido na plataforma. |
| IdQuestionario / NomeQuestionario | número / texto | Modelo de checklist respondido. |
| Situacao | número | `0` = parcial, `1` = completo, `2` = a fazer. |
| DataCadastro / DataAtualizacao | data | Datas de criação e da última atualização. |
| IdUsuario / NomeUsuario | número / texto \| null | Usuário que respondeu. |
| IdCliente / CodigoCliente / NomeCliente | número / número \| null / texto | Cliente do registro ao qual o checklist pertence. `CodigoCliente` é o código exibido na plataforma. |
| IdServico / CodigoServico | número | Registro (Tipo 3) ao qual o checklist pertence. |
| Respostas | lista | Uma linha por item respondido, ordenada por seção, questão e item. |

Campos de cada item de `Respostas`:

| Campo | Tipo | Descrição |
|-------|------|-----------|
| NumeroSecao | número \| null | Número da seção. |
| IdQuestao / NumeroQuestao / NomeQuestao | número / texto / texto | Questão (pergunta). |
| IdItemQuestao / NumeroItemQuestao / NomeItemQuestao | número / texto / texto | Item da questão (a opção, em questões de seleção). |
| Resposta | texto | Em itens de seleção: `"true"` (marcado) ou `"false"` (não marcado). Nos demais: o valor digitado. |
| Observacao | texto \| null | Comentário do usuário no item. |

> Fotos e assinaturas não fazem parte deste payload: o aplicativo envia as imagens depois das respostas, então elas ainda não estão disponíveis no momento da notificação.


## Entrega

- As notificações são enviadas logo após a Checkmob concluir a operação, de forma assíncrona. Podem chegar alguns segundos depois do evento.
- O endpoint deve responder com status **2xx**. Qualquer outro status é tratado como falha.
- **Não há reenvio automático**: uma notificação que falhar (timeout, erro 4xx/5xx, URL inválida) não é repetida.
- A ordem de chegada não é garantida. Para eventos do mesmo registro ou cliente, use `DataAtualizacao` para saber qual é o mais recente.


## Configuração e Suporte

### Configuração do Webhook
Para receber as notificações dos eventos, é necessário configurar a URL do webhook nas configurações do sistema Checkmob. Esta URL será o endpoint que receberá todas as notificações dos eventos configurados.

### Suporte Técnico
Em caso de dúvidas sobre a implementação, configuração ou funcionamento do webhook, nossa equipe de suporte está disponível para auxiliar. Entre em contato através dos canais de suporte da Checkmob.

## Conclusão
Para garantir o melhor funcionamento, recomendamos:

- Responder rapidamente com 2xx e processar a notificação de forma assíncrona do seu lado
- Tratar notificações repetidas do mesmo registro ou checklist (idempotência pelo campo `Id`)
- Implementar tratamento de erros adequado
- Manter um log das requisições recebidas
