#!/bin/bash

ORIGEM="/app/source"
DESTINO="/var/www/html"
LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/05_deploy.log"

registrar_log() {
    mkdir -p "$LOG_DIR"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

limpar_destino() {
    registrar_log "Limpando diretório de publicação do Apache: $DESTINO"
    rm -rf "$DESTINO"/*
}

realizar_deploy() {
    if [ ! -d "$ORIGEM" ]; then
        registrar_log "[FALHA] Pasta source não encontrada: $ORIGEM"
        return 1
    fi

    limpar_destino
    registrar_log "Copiando arquivos estáticos da plataforma de treinos para o Apache."
    cp -r "$ORIGEM"/* "$DESTINO"/

    registrar_log "Arquivos publicados:"
    ls -la "$DESTINO" | tee -a "$LOG_FILE"

    if [ -f "$DESTINO/index.html" ]; then
        registrar_log "[SUCESSO] Deploy concluído. index.html encontrado em $DESTINO."
    else
        registrar_log "[FALHA] Deploy incompleto. index.html não encontrado."
        return 1
    fi
}

realizar_deploy
