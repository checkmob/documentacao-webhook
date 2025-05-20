# Configuração do Webhook

## Configurando Seu Webhook

### 1. Criar um Endpoint

Primeiro, crie um endpoint em seu servidor que possa receber requisições HTTP POST. Aqui está um exemplo usando Node.js:

```javascript
const express = require('express');
const app = express();

app.use(express.json());

app.post('/webhook', (req, res) => {
    const event = req.body;
    
    // Processa o webhook
    console.log('Webhook recebido:', event);
    
    // Sempre responda com um código de status 2xx
    res.status(200).json({ received: true });
});

app.listen(3000, () => {
    console.log('Servidor webhook rodando na porta 3000');
});
```

### 2. Configurar no Painel da Checkmob

1. Faça login no painel da Checkmob
2. Navegue até Configurações > Integrações > Webhooks
3. Clique em "Adicionar Novo Webhook"
4. Digite sua URL de webhook
5. Selecione os eventos que deseja receber
6. Salve sua configuração

### 3. Requisitos da URL do Webhook

- Deve ser HTTPS (exceto para localhost durante o desenvolvimento)
- Deve ser publicamente acessível
- Deve responder dentro de 5 segundos
- Deve retornar um código de status 2xx

## Configurações do Webhook

### Política de Nova Tentativa

Se seu servidor não responder com sucesso, a Checkmob tentará reenviar o webhook:

- Primeira tentativa: 1 minuto após a falha
- Segunda tentativa: 5 minutos após a falha
- Terceira tentativa: 15 minutos após a falha
- Tentativa final: 1 hora após a falha

### Segurança

Ative estes recursos de segurança nas configurações do webhook:

- **Chave Secreta**: Gere uma chave secreta para verificar assinaturas do webhook
- **Lista de IPs Permitidos**: Restrinja chamadas de webhook a endereços IP específicos
- **Verificação SSL**: Garanta que todas as chamadas de webhook usem HTTPS

## Testando Seu Webhook

Use o recurso "Testar Webhook" no painel da Checkmob para enviar um evento de teste para seu endpoint. O payload de teste será assim:

```json
{
    "event": "test",
    "timestamp": "2024-03-14T12:00:00Z",
    "data": {
        "message": "Este é um webhook de teste"
    }
}
```

## Monitoramento

Monitore a saúde do seu webhook no painel da Checkmob:

- Taxa de sucesso
- Tempos de resposta
- Entregas com falha
- Tentativas de nova entrega

## Solução de Problemas

Problemas comuns e soluções:

1. **Erros de Timeout**
   - Garanta que seu servidor responda dentro de 5 segundos
   - Otimize o processamento do webhook

2. **Erros de SSL**
   - Verifique se seu certificado SSL é válido
   - Verifique a configuração adequada de HTTPS

3. **Falhas de Autenticação**
   - Verifique se sua chave secreta está configurada corretamente
   - Verifique a lógica de verificação de assinatura

4. **Problemas de Conexão**
   - Garanta que seu servidor seja publicamente acessível
   - Verifique as configurações do firewall 