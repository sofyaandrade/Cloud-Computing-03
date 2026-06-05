#!/bin/bash

SCRIPTS_DIR="/app/scripts"

mostrar_menu() {
    clear
    echo "Criado por: Nome do Sofya de Andrade"
    echo "Instituição: Unidavi"
    echo "Tema: 30 - Plataforma de Treinos e Exercícios Online"
    echo "===== MENU DEVOPS CLOUD ====="
    echo "1 - Atualizar sistema"
    echo "2 - Instalar Apache"
    echo "3 - Criar estrutura do projeto"
    echo "4 - Realizar backup"
    echo "5 - Fazer deploy"
    echo "6 - Ver processos"
    echo "7 - Monitorar sistema"
    echo "8 - Configurar usuários e permissões"
    echo "9 - Gerar relatório"
    echo "0 - Sair"
    echo "================================"
}

executar_opcao() {
    case "$1" in
        1) bash "$SCRIPTS_DIR/01_update.sh" ;;
        2) bash "$SCRIPTS_DIR/02_apache.sh" ;;
        3) bash "$SCRIPTS_DIR/03_estrutura.sh" ;;
        4) bash "$SCRIPTS_DIR/04_backup.sh" ;;
        5) bash "$SCRIPTS_DIR/05_deploy.sh" ;;
        6)
            echo "1 - Listar processos"
            echo "2 - Buscar processo por nome"
            echo "3 - Matar processo por PID"
            read -r -p "Escolha: " SUBOPCAO
            case "$SUBOPCAO" in
                1) bash "$SCRIPTS_DIR/06_processos.sh" listar ;;
                2) read -r -p "Nome do processo: " NOME; bash "$SCRIPTS_DIR/06_processos.sh" buscar "$NOME" ;;
                3) read -r -p "PID: " PID; bash "$SCRIPTS_DIR/06_processos.sh" matar "$PID" ;;
                *) echo "Opção inválida." ;;
            esac
            ;;
        7) bash "$SCRIPTS_DIR/07_monitoramento.sh" ;;
        8) bash "$SCRIPTS_DIR/08_usuarios_permissoes.sh" ;;
        9) bash "$SCRIPTS_DIR/09_relatorio.sh" ;;
        0) echo "Saindo do menu."; exit 0 ;;
        *) echo "Opção inválida." ;;
    esac
}

while true; do
    mostrar_menu
    read -r -p "Escolha uma opção: " OPCAO
    executar_opcao "$OPCAO"
    echo ""
    read -r -p "Pressione ENTER para continuar..." _
done
