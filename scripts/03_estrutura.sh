#!/bin/bash

BASE_DIR="/app/plataforma-treinos"
LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/03_estrutura.log"

registrar_log() {
    mkdir -p "$LOG_DIR"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

remover_estrutura_antiga() {
    if [ -d "$BASE_DIR" ]; then
        registrar_log "Removendo estrutura antiga com segurança: $BASE_DIR"
        rm -rf "$BASE_DIR"
    fi
}

criar_estrutura_treinos() {
    registrar_log "Criando estrutura temática da plataforma de treinos."
    mkdir -p "$BASE_DIR"/{usuarios,administradores,exercicios,programas_treino,videos_treino,analise_desempenho,notificacoes_personalizadas,dados,publicacao,logs,backups}

    touch "$BASE_DIR/usuarios/usuarios_relacionais.txt"
    touch "$BASE_DIR/programas_treino/programas_relacionais.txt"
    touch "$BASE_DIR/notificacoes_personalizadas/sugestoes_nosql.json"
    touch "$BASE_DIR/videos_treino/catalogo_videos.txt"
    touch "$BASE_DIR/analise_desempenho/metricas_vm_analise.txt"

    echo "Plataforma de Treinos e Exercícios Online" > "$BASE_DIR/README_AMBIENTE.txt"
    echo "Diretórios simulam VPC, sub-redes, storage, bancos e VMs do tema." >> "$BASE_DIR/README_AMBIENTE.txt"

    registrar_log "[SUCESSO] Estrutura criada em $BASE_DIR."
    find "$BASE_DIR" -maxdepth 2 -type d | tee -a "$LOG_FILE"
}

remover_estrutura_antiga
criar_estrutura_treinos
