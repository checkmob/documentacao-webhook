# Eventos do Webhook

Os webhooks da Checkmob suportam vários eventos aos quais você pode se inscrever. Cada evento contém dados específicos relevantes para o tipo de evento.

## Estrutura do Evento

Todos os eventos de webhook seguem esta estrutura básica:

```json
{
    "event": "nome_do_evento",
    "timestamp": "2024-03-14T12:00:00Z",
    "data": {
        // Dados específicos do evento
    }
}
```

## Eventos Disponíveis

### Eventos de Lead

#### `lead.created`
Disparado quando um novo lead é criado.

```json
{
    "event": "lead.created",
    "timestamp": "2024-03-14T12:00:00Z",
    "data": {
        "lead_id": "12345",
        "name": "João Silva",
        "email": "joao@exemplo.com",
        "phone": "+5511999999999",
        "source": "website",
        "created_at": "2024-03-14T12:00:00Z"
    }
}
```

#### `lead.updated`
Disparado quando as informações de um lead são atualizadas.

```json
{
    "event": "lead.updated",
    "timestamp": "2024-03-14T12:00:00Z",
    "data": {
        "lead_id": "12345",
        "changes": {
            "name": "João Silva Atualizado",
            "email": "joao.atualizado@exemplo.com"
        },
        "updated_at": "2024-03-14T12:00:00Z"
    }
}
```

### Eventos de Campanha

#### `campaign.started`
Disparado quando uma campanha é iniciada.

```json
{
    "event": "campaign.started",
    "timestamp": "2024-03-14T12:00:00Z",
    "data": {
        "campaign_id": "789",
        "name": "Promoção de Verão",
        "start_date": "2024-03-14T12:00:00Z",
        "target_leads": 1000
    }
}
```

#### `campaign.completed`
Disparado quando uma campanha é concluída.

```json
{
    "event": "campaign.completed",
    "timestamp": "2024-03-14T12:00:00Z",
    "data": {
        "campaign_id": "789",
        "name": "Promoção de Verão",
        "end_date": "2024-03-14T12:00:00Z",
        "total_leads": 950,
        "success_rate": 95
    }
}
```

### Eventos de Mensagem

#### `message.sent`
Disparado quando uma mensagem é enviada para um lead.

```json
{
    "event": "message.sent",
    "timestamp": "2024-03-14T12:00:00Z",
    "data": {
        "message_id": "msg_123",
        "lead_id": "12345",
        "type": "sms",
        "content": "Olá! Esta é uma mensagem de teste.",
        "sent_at": "2024-03-14T12:00:00Z"
    }
}
```

#### `message.delivered`
Disparado quando uma mensagem é entregue ao destinatário.

```json
{
    "event": "message.delivered",
    "timestamp": "2024-03-14T12:00:00Z",
    "data": {
        "message_id": "msg_123",
        "lead_id": "12345",
        "delivered_at": "2024-03-14T12:00:01Z"
    }
}
```

## Melhores Práticas para Tratamento de Eventos

1. **Idempotência**
   - Processe cada evento apenas uma vez
   - Use IDs de eventos para rastrear eventos processados
   - Implemente lógica de deduplicação

2. **Tratamento de Erros**
   - Registre todos os eventos recebidos
   - Implemente tratamento adequado de erros
   - Retorne códigos de status apropriados

3. **Desempenho**
   - Processe eventos de forma assíncrona quando possível
   - Responda rapidamente às requisições do webhook
   - Implemente enfileiramento adequado para eventos de alto volume

## Testando Eventos

Você pode testar cada tipo de evento usando o painel da Checkmob:

1. Vá para Configurações de Webhook
2. Selecione "Testar Evento"
3. Escolha o tipo de evento
4. Envie um evento de teste para seu endpoint

## Histórico de Eventos

Acesse o histórico de eventos do seu webhook no painel da Checkmob:

- Visualize todos os eventos enviados para seu webhook
- Verifique o status de entrega
- Revise os payloads dos eventos
- Monitore taxas de sucesso/falha 