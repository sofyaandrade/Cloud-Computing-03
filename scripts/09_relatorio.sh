#!/bin/bash

PROJETO="Trabalho 03 - Linux, Shell Script e Cloud Computing"
TEMA="30 - Plataforma de Treinos e Exercícios Online"
BASE_DIR="/app/plataforma-treinos"
LOG_DIR="/app/logs"
RELATORIO="$LOG_DIR/relatorio_execucao.txt"

registrar_secao() {
    echo "" >> "$RELATORIO"
    echo "===== $1 =====" >> "$RELATORIO"
}

gerar_relatorio() {
    mkdir -p "$LOG_DIR"
    : > "$RELATORIO"

    echo "$PROJETO" >> "$RELATORIO"
    echo "Tema: $TEMA" >> "$RELATORIO"
    echo "Data e hora: $(date '+%Y-%m-%d %H:%M:%S')" >> "$RELATORIO"

    registrar_secao "Espaço em disco"
    df -h >> "$RELATORIO"

    registrar_secao "Uso dos diretórios do projeto"
    du -sh /app/* 2>/dev/null >> "$RELATORIO"

    registrar_secao "Status do Apache"
    if pgrep apache2 > /dev/null 2>&1; then
        echo "[OK] Apache em execução" >> "$RELATORIO"
    else
        echo "[ALERTA] Apache não está em execução" >> "$RELATORIO"
    fi

    registrar_secao "Últimos backups"
    ls -lh /app/backups 2>/dev/null | tail -n 10 >> "$RELATORIO"

    registrar_secao "Últimos logs"
    ls -lh /app/logs 2>/dev/null | tail -n 15 >> "$RELATORIO"

    registrar_secao "Arquivos publicados no Apache"
    ls -la /var/www/html 2>/dev/null >> "$RELATORIO"

    registrar_secao "Usuários e permissões principais"
    getent passwd treino_user >> "$RELATORIO" 2>/dev/null || echo "Usuário treino_user ainda não criado." >> "$RELATORIO"
    getent group treinos_ops >> "$RELATORIO" 2>/dev/null || echo "Grupo treinos_ops ainda não criado." >> "$RELATORIO"
    ls -ld "$BASE_DIR" "$BASE_DIR"/* 2>/dev/null >> "$RELATORIO"

    echo "[SUCESSO] Relatório gerado em $RELATORIO"
    cat "$RELATORIO"
}

gerar_relatorio
