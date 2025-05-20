# Exemplos de Implementação

Esta página contém exemplos práticos de como implementar webhooks da Checkmob em diferentes linguagens de programação.

## Node.js

### Exemplo Básico

```javascript
const express = require('express');
const crypto = require('crypto');
const app = express();

app.use(express.json());

// Verifica a assinatura do webhook
function verifyWebhookSignature(payload, signature, secret) {
    const hmac = crypto.createHmac('sha256', secret);
    const calculatedSignature = hmac.update(JSON.stringify(payload)).digest('hex');
    return crypto.timingSafeEqual(
        Buffer.from(signature),
        Buffer.from(calculatedSignature)
    );
}

// Endpoint do webhook
app.post('/webhook', (req, res) => {
    const signature = req.headers['x-checkmob-signature'];
    
    // Verifica a assinatura
    if (!verifyWebhookSignature(req.body, signature, process.env.WEBHOOK_SECRET)) {
        return res.status(401).json({ error: 'Assinatura inválida' });
    }
    
    // Processa o evento
    const event = req.body;
    
    switch (event.event) {
        case 'lead.created':
            handleLeadCreated(event.data);
            break;
        case 'message.sent':
            handleMessageSent(event.data);
            break;
        default:
            console.log('Evento não tratado:', event.event);
    }
    
    res.status(200).json({ received: true });
});

function handleLeadCreated(data) {
    console.log('Novo lead criado:', data);
    // Implemente sua lógica aqui
}

function handleMessageSent(data) {
    console.log('Mensagem enviada:', data);
    // Implemente sua lógica aqui
}

app.listen(3000, () => {
    console.log('Servidor webhook rodando na porta 3000');
});
```

## Python

### Exemplo com Flask

```python
from flask import Flask, request, jsonify
import hmac
import hashlib
import os

app = Flask(__name__)

def verify_webhook_signature(payload, signature, secret):
    expected = hmac.new(
        secret.encode('utf-8'),
        payload,
        hashlib.sha256
    ).hexdigest()
    return hmac.compare_digest(expected, signature)

@app.route('/webhook', methods=['POST'])
def webhook():
    # Obtém a assinatura do cabeçalho
    signature = request.headers.get('X-Checkmob-Signature')
    
    # Verifica a assinatura
    if not verify_webhook_signature(
        request.get_data(),
        signature,
        os.environ['WEBHOOK_SECRET']
    ):
        return jsonify({'error': 'Assinatura inválida'}), 401
    
    # Processa o evento
    event = request.json
    
    if event['event'] == 'lead.created':
        handle_lead_created(event['data'])
    elif event['event'] == 'message.sent':
        handle_message_sent(event['data'])
    else:
        print(f'Evento não tratado: {event["event"]}')
    
    return jsonify({'received': True})

def handle_lead_created(data):
    print('Novo lead criado:', data)
    # Implemente sua lógica aqui

def handle_message_sent(data):
    print('Mensagem enviada:', data)
    # Implemente sua lógica aqui

if __name__ == '__main__':
    app.run(port=3000)
```

## PHP

### Exemplo com Laravel

```php
<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class WebhookController extends Controller
{
    public function handle(Request $request)
    {
        // Verifica a assinatura
        $signature = $request->header('X-Checkmob-Signature');
        $payload = $request->getContent();
        
        if (!$this->verifySignature($payload, $signature)) {
            return response()->json(['error' => 'Assinatura inválida'], 401);
        }
        
        // Processa o evento
        $event = $request->json()->all();
        
        switch ($event['event']) {
            case 'lead.created':
                $this->handleLeadCreated($event['data']);
                break;
            case 'message.sent':
                $this->handleMessageSent($event['data']);
                break;
            default:
                Log::info('Evento não tratado: ' . $event['event']);
        }
        
        return response()->json(['received' => true]);
    }
    
    private function verifySignature($payload, $signature)
    {
        $expected = hash_hmac(
            'sha256',
            $payload,
            env('WEBHOOK_SECRET')
        );
        
        return hash_equals($expected, $signature);
    }
    
    private function handleLeadCreated($data)
    {
        Log::info('Novo lead criado:', $data);
        // Implemente sua lógica aqui
    }
    
    private function handleMessageSent($data)
    {
        Log::info('Mensagem enviada:', $data);
        // Implemente sua lógica aqui
    }
}
```

## Boas Práticas nos Exemplos

1. **Verificação de Segurança**
   - Todos os exemplos incluem verificação de assinatura
   - Uso de variáveis de ambiente para chaves secretas
   - Validação de dados recebidos

2. **Tratamento de Eventos**
   - Estrutura organizada para diferentes tipos de eventos
   - Logging adequado
   - Respostas apropriadas

3. **Configuração**
   - Uso de HTTPS
   - Configuração de timeouts
   - Tratamento de erros

## Testando os Exemplos

1. Configure sua chave secreta:
   ```bash
   export WEBHOOK_SECRET=sua_chave_secreta
   ```

2. Inicie o servidor:
   ```bash
   # Node.js
   node app.js
   
   # Python
   python app.py
   
   # PHP/Laravel
   php artisan serve
   ```

3. Use o painel da Checkmob para enviar eventos de teste

4. Verifique os logs para confirmar o recebimento e processamento dos eventos 