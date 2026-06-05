#!/bin/bash

GRUPO="treinos_ops"
USUARIO="treino_user"
BASE_DIR="/app/plataforma-treinos"
LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/08_usuarios_permissoes.log"

registrar_log() {
    mkdir -p "$LOG_DIR"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

validar_root() {
    if [ "$(id -u)" -ne 0 ]; then
        registrar_log "[FALHA] Execute este script como root dentro do container."
        exit 1
    fi
}

criar_grupo_usuario() {
    if ! getent group "$GRUPO" > /dev/null; then
        groupadd "$GRUPO"
        registrar_log "Grupo criado: $GRUPO"
    else
        registrar_log "Grupo já existe: $GRUPO"
    fi

    if ! id "$USUARIO" > /dev/null 2>&1; then
        useradd -r -g "$GRUPO" -d "$BASE_DIR" -s /usr/sbin/nologin "$USUARIO"
        registrar_log "Usuário de sistema criado: $USUARIO"
    else
        registrar_log "Usuário já existe: $USUARIO"
    fi
}

aplicar_permissoes() {
    mkdir -p "$BASE_DIR"/{videos_treino,programas_treino,analise_desempenho,logs,backups}

    chown -R "$USUARIO:$GRUPO" "$BASE_DIR/videos_treino" "$BASE_DIR/programas_treino" "$BASE_DIR/analise_desempenho"
    chmod -R 750 "$BASE_DIR/videos_treino" "$BASE_DIR/programas_treino" "$BASE_DIR/analise_desempenho"

    chown -R root:"$GRUPO" "$BASE_DIR/logs" "$BASE_DIR/backups"
    chmod -R 770 "$BASE_DIR/logs" "$BASE_DIR/backups"

    registrar_log "Permissões aplicadas sem uso de chmod 777."
    registrar_log "Diretórios principais:"
    ls -ld "$BASE_DIR" "$BASE_DIR/videos_treino" "$BASE_DIR/programas_treino" "$BASE_DIR/analise_desempenho" "$BASE_DIR/logs" "$BASE_DIR/backups" | tee -a "$LOG_FILE"
}

validar_root
criar_grupo_usuario
aplicar_permissoes
