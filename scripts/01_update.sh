#!/bin/bash

LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/01_update.log"

registrar_log() {
    mkdir -p "$LOG_DIR"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

atualizar_sistema() {
    registrar_log "Iniciando atualização do ambiente Linux da plataforma de treinos."

    apt update >> "$LOG_FILE" 2>&1
    if [ $? -ne 0 ]; then
        registrar_log "[FALHA] Erro ao executar apt update."
        return 1
    fi

    apt upgrade -y >> "$LOG_FILE" 2>&1
    if [ $? -ne 0 ]; then
        registrar_log "[FALHA] Erro ao executar apt upgrade."
        return 1
    fi

    registrar_log "[SUCESSO] Sistema atualizado corretamente."
    return 0
}

atualizar_sistema
