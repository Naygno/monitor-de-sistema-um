# Script de Monitoramento de Sistema - DevOps Toolkit

## 📋 Visão Geral
Script Bash interativo para monitoramento completo de sistemas Linux. Ferramenta essencial para administradores de sistemas e profissionais de DevOps que precisam de insights rápidos sobre performance e troubleshooting.

## 🚀 Funcionalidades

### 🔍 **Monitoramento em Tempo Real**
- **CPU**: Top 10 processos por consumo com filtro por nome
- **Memória**: Lista personalizável (1-99 processos) por uso de RAM  
- **Processos**: Verificação de status com timestamp

### 📊 **Análise Avançada de Logs**
- Suporte a 8 níveis de prioridade do systemd
- Período personalizável (horas anteriores)
- Quantidade de linhas ajustável
- *Exportação CSV em desenvolvimento*

## 🛠️ Instalação e Uso

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/monitor-de-sistema-um.git

# Torne executável
chmod +x monitor-de-sistema.sh

# Execute
./monitor-de-processo
```

## 💡 Características Técnicas

### ✅ **Robusto e Confiável**
- Validação completa de entradas
- Tratamento abrangente de erros
- Limpeza automática de recursos temporários

### 🎯 **User-Friendly** 
- Interface interativa com navegação por setas
- Mensagens de erro claras e acionáveis
- Fluxo intuitivo com rotas de saída sempre disponíveis

### 🔧 **Tecnologias**
- Bash Script puro
- Comandos nativos: `ps`, `journalctl`, `pgrep`, `grep`
- Compatível com maioria das distribuições Linux

## 🎯 Casos de Uso

### Para DevOps:
- Diagnóstico rápido de problemas de performance
- Monitoramento de consumo de recursos
- Análise de logs para troubleshooting

### Para Desenvolvedores:
- Identificação de memory leaks
- Monitoramento de aplicações em produção
- Debug de problemas de sistema

## 📈 Próximas Funcionalidades

- [ ] Exportação de relatórios em CSV
- [ ] Agendamento automático via cron
- [ ] Dashboard web integrado
- [ ] Alertas por email

## 🤝 Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para:
- Reportar bugs
- Sugerir novas funcionalidades  
- Enviar pull requests

## 📄 Licença

MIT License - veja o arquivo LICENSE para detalhes.

---

**Desenvolvido por:** Naygno Barbosa Noia  
**Manutenido por:** Naygno Barbosa Noia

*"Ferramentas simples resolvem problemas complexos quando bem elaboradas."*