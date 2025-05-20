# Segurança do Webhook

## Visão Geral

A segurança é um aspecto crucial ao implementar webhooks. Este guia descreve as melhores práticas para garantir que suas integrações de webhook sejam seguras e confiáveis.

## Verificação de Assinatura

### Como Funciona

1. A Checkmob gera uma assinatura HMAC-SHA256 usando sua chave secreta
2. A assinatura é enviada no cabeçalho `X-Checkmob-Signature`
3. Seu servidor deve verificar a assinatura antes de processar o webhook

### Exemplo de Implementação

```javascript
const crypto = require('crypto');

function verifyWebhookSignature(payload, signature, secret) {
    const hmac = crypto.createHmac('sha256', secret);
    const calculatedSignature = hmac.update(JSON.stringify(payload)).digest('hex');
    return crypto.timingSafeEqual(
        Buffer.from(signature),
        Buffer.from(calculatedSignature)
    );
}

app.post('/webhook', (req, res) => {
    const signature = req.headers['x-checkmob-signature'];
    
    if (!verifyWebhookSignature(req.body, signature, process.env.WEBHOOK_SECRET)) {
        return res.status(401).json({ error: 'Assinatura inválida' });
    }
    
    // Processa o webhook
    res.status(200).json({ received: true });
});
```

## Lista de IPs Permitidos

### Configuração

1. Acesse o painel da Checkmob
2. Vá para Configurações > Integrações > Webhooks
3. Adicione os IPs da Checkmob à sua lista de IPs permitidos

### IPs da Checkmob

```
203.0.113.1
203.0.113.2
203.0.113.3
```

## SSL/TLS

### Requisitos

- Use HTTPS para todos os endpoints de webhook
- Mantenha certificados SSL atualizados
- Configure redirecionamentos HTTP para HTTPS
- Use TLS 1.2 ou superior

### Configuração do Servidor

```nginx
server {
    listen 443 ssl;
    server_name seu-dominio.com;

    ssl_certificate /caminho/para/certificado.crt;
    ssl_certificate_key /caminho/para/chave.key;
    
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    
    location /webhook {
        proxy_pass http://localhost:3000;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## Boas Práticas

### 1. Validação de Dados

- Valide todos os dados recebidos
- Verifique tipos de dados e formatos
- Implemente limites de tamanho para payloads
- Sanitize dados antes do processamento

### 2. Tratamento de Erros

- Registre todas as tentativas de acesso
- Implemente rate limiting
- Monitore padrões suspeitos
- Mantenha logs de segurança

### 3. Monitoramento

- Configure alertas para falhas de autenticação
- Monitore taxas de erro
- Acompanhe tempos de resposta
- Verifique regularmente os logs

## Checklist de Segurança

- [ ] Implementar verificação de assinatura
- [ ] Configurar lista de IPs permitidos
- [ ] Usar HTTPS em todos os endpoints
- [ ] Implementar validação de dados
- [ ] Configurar monitoramento
- [ ] Manter certificados SSL atualizados
- [ ] Implementar rate limiting
- [ ] Configurar logs de segurança 