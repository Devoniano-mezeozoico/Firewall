#!/bin/bash

# Função para verificar regras existentes
verificar_regras() {
    clear
    echo "Regras atuais no iptables (OUTPUT):"
    iptables -L OUTPUT -n --line-numbers
}

# Função para remover regras específicas
retirar_regras() {
    clear
    echo "Regras atuais no iptables (OUTPUT):"
    iptables -L OUTPUT -n --line-numbers

    while true; do
        read -p "Digite 's' para sair ou digite o número da regra que você deseja remover: " numero_da_regra

        if [[ "$numero_da_regra" == "s" || "$numero_da_regra" == "S" ]]; then
            echo "Saindo..."
            break
        elif [[ "$numero_da_regra" =~ ^[0-9]+$ ]]; then
            iptables -D OUTPUT "$numero_da_regra"
            echo "Regra número $numero_da_regra removida."
        else
            echo "Entrada inválida. Tente novamente."
        fi
    done

    netfilter-persistent save
    netfilter-persistent reload
}

# Função para criar novas regras de bloqueio
criacao_de_regras() {
    clear
    read -p "Digite aqui o IP: " IP
    read -p "Digite aqui o DNS (ou domínio): " DNS

    # Bloqueia DNS
    iptables -A OUTPUT -d "$DNS" -p tcp --dport 80 -j DROP
    iptables -A OUTPUT -d "$DNS" -p tcp --dport 443 -j DROP
    iptables -A OUTPUT -d "$DNS" -p udp --dport 80 -j DROP
    iptables -A OUTPUT -d "$DNS" -p udp --dport 443 -j DROP

    # Bloqueia IP
    iptables -A OUTPUT -d "$IP" -p tcp --dport 80 -j DROP
    iptables -A OUTPUT -d "$IP" -p tcp --dport 443 -j DROP
    iptables -A OUTPUT -d "$IP" -p udp --dport 80 -j DROP
    iptables -A OUTPUT -d "$IP" -p udp --dport 443 -j DROP

    netfilter-persistent save
    netfilter-persistent reload

    echo "IP e DNS bloqueados com sucesso."
}

# Menu principal
while true; do
    clear
    echo -e """
     ========
    //   
   //___        ( )      __        ___                       ___       //     //
  / ___        / /     //  ) )   //___) )   //  / /  / /   //   ) )   //     //
 //           / /     //        //         //  / /  / /   //   / /   //     //
//           / /     //        ((____     ((__( (__/ /   ((___( (   //     //
"""

    echo "Menu:"
    echo "1 - Verificar regras"
    echo "2 - Criar nova regra"
    echo "3 - Remover regra"
    echo "4 - Sair"
    read -p "Escolha uma opção: " opcao

    case $opcao in
        1) verificar_regras ;;
        2) criacao_de_regras ;;
        3) retirar_regras ;;
        4) echo "Encerrando script..."; break ;;
        *) echo "Opção inválida. Tente novamente."; sleep 2 ;;
    esac

    echo ""
    read -p "Pressione Enter para continuar..." dummy
done

