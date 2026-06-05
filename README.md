# Trabalho 03 - Linux, Shell Script e Cloud Computing

## Sofya de Andrade
Sofya Bruzadelli Borges Seidler de Andrade

## Instituição
Unidavi - Sistemas de Informação

## Tema
**30 - Plataforma de Treinos e Exercícios Online**

## Descrição do Projeto
Este projeto simula um ambiente Linux containerizado para operação de uma aplicação de **Plataforma de Treinos e Exercícios Online**. O cenário foi adaptado ao tema do Trabalho 01, que previa uma arquitetura cloud com VPC, sub-redes pública e privada, storage para vídeos, banco relacional, banco não relacional e máquinas virtuais para exibição de treinos e análise de desempenho.

No Trabalho 03, essa ideia foi transformada em um ambiente operacional com Docker, Ubuntu, Apache e scripts Shell para automatizar rotinas comuns de DevOps, como atualização do sistema, instalação de serviços, criação de diretórios temáticos, backup, deploy, monitoramento, permissões e relatório final.

## Relação com o Tema do Trabalho 01
A adaptação temática aparece nos diretórios, arquivos, usuários, grupos, logs e no conteúdo do site:

- `/app/plataforma-treinos/usuarios`: simula dados de usuários do banco relacional.
- `/app/plataforma-treinos/programas_treino`: simula programas de treino do banco relacional.
- `/app/plataforma-treinos/videos_treino`: simula storage de vídeos de treino.
- `/app/plataforma-treinos/notificacoes_personalizadas`: simula banco não relacional para sugestões e notificações.
- `/app/plataforma-treinos/analise_desempenho`: simula VM de análise de desempenho.
- Grupo `treinos_ops` e usuário `treino_user`: simulam operação técnica da plataforma.
- Site estático em Apache: simula a VM pública de exibição dos treinos.

## Tecnologias Utilizadas
- Linux Ubuntu 24.04
- Docker
- Docker Compose
- Apache
- Shell Script
- ffmpeg, por se tratar de um tema com vídeos de treinos
- GitHub
- DockerHub

## Estrutura do Projeto

```text
trabalho03-cloud-shell/
├── Dockerfile
├── docker-compose.yml
├── README.md
├── RELATORIO_FINAL.md
├── Relatorio_Final_Trabalho_03.docx
├── scripts/
│   ├── 01_update.sh
│   ├── 02_apache.sh
│   ├── 03_estrutura.sh
│   ├── 04_backup.sh
│   ├── 05_deploy.sh
│   ├── 06_processos.sh
│   ├── 07_monitoramento.sh
│   ├── 08_usuarios_permissoes.sh
│   ├── 09_relatorio.sh
│   └── menu.sh
├── source/
│   ├── index.html
│   ├── sobre.html
│   └── assets/
│       └── style.css
├── backups/
├── logs/
└── evidencias/
```

## Como Executar o Projeto

Clone o repositório e entre na pasta:

```bash
git clone <link-do-repositorio-github>
cd trabalho03-cloud-shell
```

Suba o container:

```bash
docker compose up -d --build
```

Entre no container:

```bash
docker exec -it trabalho03-linux bash
```

Dentro do container, acesse a pasta de scripts:

```bash
cd /app/scripts
chmod +x *.sh
```

## Como Acessar o Apache no Navegador

Após executar o deploy do site, acesse:

```text
http://localhost:8080
```

## Como Executar o Menu Principal

Dentro do container:

```bash
cd /app/scripts
./menu.sh
```

O menu permite executar as rotinas principais:

```text
1 - Atualizar sistema
2 - Instalar Apache
3 - Criar estrutura do projeto
4 - Realizar backup
5 - Fazer deploy
6 - Ver processos
7 - Monitorar sistema
8 - Configurar usuários e permissões
9 - Gerar relatório
0 - Sair
```

## Scripts Disponíveis

| Script | Descrição |
|---|---|
| `01_update.sh` | Atualiza pacotes do sistema com `apt update` e `apt upgrade -y`, gerando log. |
| `02_apache.sh` | Instala e valida Apache, exibe versão e instala `ffmpeg` por causa do tema de vídeos de treino. |
| `03_estrutura.sh` | Cria a estrutura temática em `/app/plataforma-treinos`. |
| `04_backup.sh` | Gera backup `.tar.gz` com data e hora no nome, salvando em `backups/`. |
| `05_deploy.sh` | Copia os arquivos da pasta `source/` para `/var/www/html`. |
| `06_processos.sh` | Lista, busca e encerra processos com validação de PID. |
| `07_monitoramento.sh` | Monitora CPU, memória, disco e status do Apache, emitindo alertas. |
| `08_usuarios_permissoes.sh` | Cria grupo e usuário temáticos, aplica `chown` e `chmod` sem usar `777`. |
| `09_relatorio.sh` | Gera relatório operacional em `logs/relatorio_execucao.txt`. |
| `menu.sh` | Menu interativo que integra os scripts principais. |

## Execução Individual dos Scripts

```bash
./01_update.sh
./02_apache.sh
./03_estrutura.sh
./04_backup.sh
./05_deploy.sh
./06_processos.sh listar
./06_processos.sh buscar apache
./06_processos.sh matar <PID>
./07_monitoramento.sh
./08_usuarios_permissoes.sh
./09_relatorio.sh
```

## Ordem Recomendada para Teste

```bash
cd /app/scripts
chmod +x *.sh
./01_update.sh
./02_apache.sh
./03_estrutura.sh
./08_usuarios_permissoes.sh
./04_backup.sh
./05_deploy.sh
./07_monitoramento.sh
./09_relatorio.sh
```

Depois, acesse o site em:

```text
http://localhost:8080
```

## Evidências de Funcionamento

A pasta `evidencias/` contém prints ou arquivos demonstrando:

1. Container sendo executado.
2. Volume Docker configurado.
3. Scripts com permissão de execução.
4. Execução do script de atualização.
5. Instalação e validação do Apache.
6. Estrutura de diretórios criada.
7. Backup `.tar.gz` gerado.
8. Deploy realizado para `/var/www/html`.
9. Site acessível no navegador.
10. Monitoramento do sistema.
11. Usuários e permissões configurados.
12. Relatório final gerado.
13. Imagem publicada no DockerHub.

## Publicação da Imagem no DockerHub

```bash
docker login
docker compose build
docker push sofyaandrade/trabalho03-plataforma-treinos:1.0
```

Link da imagem no DockerHub:

```
https://hub.docker.com/r/sofyaandrade/trabalho03-plataforma-treinos
```

## Link do Repositório GitHub

```
https://github.com/sofyaandrade/Cloud-Computing-03.git
```