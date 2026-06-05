#!/bin/bash

LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/02_apache.log"

registrar_log() {
    mkdir -p "$LOG_DIR"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

instalar_apache() {
    registrar_log "Instalando Apache e ffmpeg para suporte a mídia/vídeos de treino."
    apt update >> "$LOG_FILE" 2>&1
    apt install -y apache2 ffmpeg >> "$LOG_FILE" 2>&1

    if [ $? -eq 0 ]; then
        registrar_log "[SUCESSO] Apache e ffmpeg instalados."
    else
        registrar_log "[FALHA] Erro na instalação do Apache ou ffmpeg."
        return 1
    fi
}

verificar_apache() {
    if command -v apache2 > /dev/null 2>&1; then
        registrar_log "[OK] Apache está instalado."
        if pgrep apache2 > /dev/null 2>&1; then
            registrar_log "[OK] Apache está em execução."
        else
            registrar_log "Apache instalado, tentando iniciar serviço."
            apachectl start >> "$LOG_FILE" 2>&1
            if pgrep apache2 > /dev/null 2>&1; then
                registrar_log "[OK] Apache iniciado com sucesso."
            else
                registrar_log "[ALERTA] Apache instalado, mas não foi possível confirmar execução."
            fi
        fi
    else
        registrar_log "[FALHA] Apache não encontrado."
        return 1
    fi
}

versao_apache() {
    registrar_log "Versão do Apache instalada:"
    apache2 -v | tee -a "$LOG_FILE"
    registrar_log "Versão do ffmpeg instalada:"
    ffmpeg -version | head -n 1 | tee -a "$LOG_FILE"
}

instalar_apache && verificar_apache && versao_apache
