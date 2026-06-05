#!/bin/bash

LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/07_monitoramento.log"
LIMITE_CPU=80
LIMITE_MEMORIA=80
LIMITE_DISCO=80

registrar_log() {
    mkdir -p "$LOG_DIR"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

uso_cpu() {
    CPU=$(top -bn1 | grep "Cpu" | awk '{print 100 - $8}' | cut -d'.' -f1)
    CPU=${CPU:-0}
    registrar_log "Uso de CPU: ${CPU}%"
    if [ "$CPU" -ge "$LIMITE_CPU" ]; then
        registrar_log "[ALERTA] Uso de CPU acima de ${LIMITE_CPU}%."
    else
        registrar_log "[OK] Uso de CPU dentro do esperado."
    fi
}

uso_memoria() {
    MEMORIA=$(free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100)}')
    registrar_log "Uso de memória RAM: ${MEMORIA}%"
    if [ "$MEMORIA" -ge "$LIMITE_MEMORIA" ]; then
        registrar_log "[ALERTA] Uso de memória acima de ${LIMITE_MEMORIA}%."
    else
        registrar_log "[OK] Uso de memória dentro do esperado."
    fi
}

uso_disco() {
    DISCO=$(df / | awk 'NR==2 {gsub("%", "", $5); print $5}')
    registrar_log "Uso de disco: ${DISCO}%"
    if [ "$DISCO" -ge "$LIMITE_DISCO" ]; then
        registrar_log "[ALERTA] Uso de disco acima de ${LIMITE_DISCO}%."
    else
        registrar_log "[OK] Uso de disco dentro do esperado."
    fi
}

status_apache() {
    if pgrep apache2 > /dev/null 2>&1; then
        registrar_log "[OK] Apache em execução."
    else
        registrar_log "[ALERTA] Apache não está em execução."
    fi
}

coletar_monitoramento() {
    registrar_log "Coleta de monitoramento da plataforma de treinos iniciada."
    uso_cpu
    uso_memoria
    uso_disco
    status_apache
    registrar_log "Coleta de monitoramento finalizada."
}

coletar_monitoramento
