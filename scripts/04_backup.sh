#!/bin/bash

ORIGEM="/app/plataforma-treinos"
DESTINO="/app/backups"
LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/04_backup.log"
DATA_HORA=$(date '+%Y-%m-%d_%H-%M')
ARQUIVO_BACKUP="backup_plataforma_treinos_${DATA_HORA}.tar.gz"

registrar_log() {
    mkdir -p "$LOG_DIR" "$DESTINO"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

gerar_backup() {
    if [ ! -d "$ORIGEM" ]; then
        registrar_log "[FALHA] Diretório de origem não existe: $ORIGEM. Execute 03_estrutura.sh antes do backup."
        return 1
    fi

    registrar_log "Gerando backup de $ORIGEM em $DESTINO/$ARQUIVO_BACKUP."
    tar -czf "$DESTINO/$ARQUIVO_BACKUP" -C "$(dirname "$ORIGEM")" "$(basename "$ORIGEM")" >> "$LOG_FILE" 2>&1

    if [ -f "$DESTINO/$ARQUIVO_BACKUP" ]; then
        registrar_log "[SUCESSO] Backup criado: $DESTINO/$ARQUIVO_BACKUP"
        ls -lh "$DESTINO/$ARQUIVO_BACKUP" | tee -a "$LOG_FILE"
    else
        registrar_log "[FALHA] Backup não foi criado corretamente."
        return 1
    fi
}

gerar_backup
