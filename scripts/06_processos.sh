#!/bin/bash

listar_processos() {
    echo "Processos ativos no ambiente Linux da plataforma de treinos:"
    ps aux --sort=-%mem | head -n 15
}

buscar_processo() {
    NOME_PROCESSO="$1"
    if [ -z "$NOME_PROCESSO" ]; then
        echo "[ERRO] Informe o nome do processo. Exemplo: ./06_processos.sh buscar apache"
        return 1
    fi
    echo "Buscando processo por nome: $NOME_PROCESSO"
    ps aux | grep -i "$NOME_PROCESSO" | grep -v grep
}

matar_processo() {
    PID="$1"
    if [ -z "$PID" ]; then
        echo "[SEGURANÇA] Nenhum PID informado. Operação cancelada."
        echo "Uso correto: ./06_processos.sh matar 1234"
        return 1
    fi

    if ! [[ "$PID" =~ ^[0-9]+$ ]]; then
        echo "[ERRO] PID inválido. Informe apenas números."
        return 1
    fi

    echo "[ATENÇÃO] Encerrando processo PID $PID. Use apenas quando tiver certeza."
    kill "$PID" 2>/dev/null

    if [ $? -eq 0 ]; then
        echo "[SUCESSO] Processo $PID encerrado."
    else
        echo "[FALHA] Não foi possível encerrar o processo $PID."
        return 1
    fi
}

case "$1" in
    listar)
        listar_processos
        ;;
    buscar)
        buscar_processo "$2"
        ;;
    matar)
        matar_processo "$2"
        ;;
    *)
        echo "Uso: ./06_processos.sh {listar|buscar <nome>|matar <PID>}"
        ;;
esac
