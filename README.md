# Script de Firewall - Gerenciamento de Regras com iptables

Este script em **Bash** foi criado para facilitar o gerenciamento de regras no firewall **iptables**. Ele permite que você verifique, crie e remova regras relacionadas ao tráfego de saída (OUTPUT) de uma máquina. O script também oferece a possibilidade de bloquear IPs ou domínios específicos.

## Funcionalidades

O script oferece um menu interativo com as seguintes funcionalidades:

1. **Verificar regras existentes**: Exibe as regras atuais configuradas no `iptables` para tráfego de saída (OUTPUT).
2. **Criar novas regras**: Permite criar regras para bloquear tráfego de saída para um determinado **IP** ou **domínio** (DNS).
3. **Remover regras específicas**: Permite a remoção de regras de tráfego de saída (OUTPUT) especificando o número da regra.
4. **Salvar e carregar regras**: Após modificar as regras, o script salva e recarrega automaticamente as configurações do `iptables` usando `netfilter-persistent`.

## Requisitos

- **iptables**: O script utiliza o comando `iptables` para gerenciar as regras de firewall.
- **netfilter-persistent**: O script utiliza o `netfilter-persistent` para salvar e recarregar as regras de firewall.

Para instalar os requisitos, use os seguintes comandos:

```bash
sudo apt-get update
sudo apt-get install iptables netfilter-persistent
