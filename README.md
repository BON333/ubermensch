# Übermensch

> *«O homem é uma corda estendida entre o animal e o super-homem — uma corda sobre um abismo.»*
> — Nietzsche, *Assim Falou Zaratustra*

Um modo de concentração para Hyprland. Carregas em `SUPER + U` e o ambiente transforma-se:
o ecrã fica a preto e branco, as distrações calam-se, o terminal enche-se de relâmpagos
e o Nietzsche aparece para te lembrar porque estás aqui. Voltas a carregar e tudo regressa
ao que era.

Nasceu no [BonVel OS](https://github.com/BON333/BonVel-linux), onde já vem instalado,
e funciona no [Omarchy](https://omarchy.org) ou em qualquer Hyprland com a mesma estrutura de temas.

## O que muda quando o modo está ligado

| | Antes | No modo Übermensch |
|---|---|---|
| **Fundo** | O do tema | `End.jpg` |
| **Cores do ecrã** | Normais | Preto e branco (shader `grayscale.glsl`) |
| **Janelas** | Bordas e espaços do tema | Bordas brancas, mais espaço, sem animações nem blur |
| **Terminal Ghostty** | O do tema | Preto com relâmpagos brancos (shader `relampagos.glsl`) |
| **Notificações** | Normais | "Não incomodar" (os avisos do próprio modo continuam a passar) |
| **Energia** | O perfil atual | `performance` (volta ao anterior quando desligas) |
| **Waybar** | — | Indicador **Ü** (clicar desliga o modo) |
| **Ecrã de bloqueio** | — | Uma frase de Nietzsche |

As janelas do Ghostty que já estão abertas mudam na hora; não precisas de as fechar.

## Instalar

```bash
git clone https://github.com/BON333/ubermensch
cd ubermensch
./install.sh
```

O comando fica em `~/.local/bin/ubermensch` e os dados em `~/.local/share/bonvel/ubermensch/`.
A pasta clonada pode ser apagada depois.

Para atualizar, faz `git pull` e volta a correr `./install.sh`.
Para remover: `./install.sh desinstalar` (desliga o modo primeiro, se estiver ligado).

### Requisitos

- **Obrigatórios:** Hyprland, `swaybg` e a estrutura de temas do Omarchy (`~/.config/omarchy/current/`).
- **Opcionais** (cada um ativa uma parte do modo): Ghostty, waybar, mako, hyprlock,
  fastfetch, `powerprofilesctl`, libnotify (`notify-send`).

### Ligar às tuas configurações

O `install.sh` não mexe em nenhum ficheiro teu. Copia o que quiseres da pasta [`exemplos/`](exemplos):

| Ficheiro | Junta a | Para quê |
|---|---|---|
| [`hyprland.conf`](exemplos/hyprland.conf) | `~/.config/hypr/bindings.conf` | Atalhos `SUPER + U` e `SUPER + ALT + O` |
| [`ghostty.conf`](exemplos/ghostty.conf) | `~/.config/ghostty/config` | Fundo preto e relâmpagos no terminal |
| [`waybar.jsonc`](exemplos/waybar.jsonc) | `~/.config/waybar/config.jsonc` | Indicador **Ü** na barra |
| [`waybar.css`](exemplos/waybar.css) | `~/.config/waybar/style.css` | Estilo do indicador |
| [`hyprlock.conf`](exemplos/hyprlock.conf) | `~/.config/hypr/hyprlock.conf` | Frase no ecrã de bloqueio |

Depois de mudar os atalhos, corre `hyprctl reload`.

## Atalhos

| Teclas | O que faz |
|---|---|
| `SUPER + U` | Liga ou desliga o modo |
| `SUPER + ALT + O` | Tira ou repõe só os relâmpagos do Ghostty (o resto do modo fica igual) |

Os relâmpagos são bonitos, mas cansam a vista ao fim de algum tempo. Com `SUPER + ALT + O`
o terminal fica só preto. A escolha é guardada: da próxima vez que ligares o modo, os
relâmpagos continuam desligados até voltares a carregar no atalho.

(`SUPER + O` não foi usado porque no Omarchy já serve para destacar uma janela.)

## Comandos

| Comando | O que faz |
|---|---|
| `ubermensch` | Liga o modo |
| `ubermensch off` | Desliga e volta ao fundo e às definições anteriores |
| `ubermensch toggle` | Liga ou desliga (é o que o `SUPER + U` usa) |
| `ubermensch raios` | Tira ou repõe os relâmpagos do Ghostty (é o que o `SUPER + ALT + O` usa) |
| `ubermensch frase` | Mostra uma frase de Nietzsche |
| `ubermensch pomodoro [min]` | Temporizador com aviso no fim (25 minutos por omissão) |
| `ubermensch sessao` | Inicia o Tor, corre o `cktor` e abre um tmux com as janelas recon, notas e shell (pensado para o BonVel) |
| `ubermensch estado` | Estado em JSON, para a waybar |

## Como funciona

O modo não altera as tuas configurações. Tudo o que muda é temporário:

- **Fundo:** o link `~/.config/omarchy/current/background` passa a apontar para o `End.jpg`.
  O destino anterior fica guardado e é reposto ao desligar.
- **Hyprland:** as mudanças são feitas com `hyprctl keyword`. Ao desligar, um `hyprctl reload`
  repõe tudo o que vem dos teus ficheiros.
- **Ghostty:** o modo escreve um ficheiro de configuração extra que o teu config inclui
  (se existir) e manda o sinal `SIGUSR2` para as janelas abertas recarregarem.
- **Estado:** fica em `~/.local/state/bonvel/ubermensch/`:

  | Ficheiro | Significado |
  |---|---|
  | `fundo-anterior` | O modo está ligado; guarda o fundo a repor |
  | `perfil-anterior` | Perfil de energia a repor |
  | `ghostty.conf` | Configuração extra do Ghostty enquanto o modo está ligado |
  | `sem-raios` | Os relâmpagos foram desligados com `SUPER + ALT + O` |

Se um tema do Omarchy tiver o seu próprio `backgrounds/End.jpg`, é esse que o modo usa.

## Quando algo corre mal

Quando o modo é usado por atalho não há terminal para mostrar erros, por isso os erros
aparecem também como **notificação**. Nada falha em silêncio.

**O ecrã ficou preto, sem fundo.** Acontece se o ficheiro do fundo desaparecer enquanto o modo
está ligado (por exemplo, se a pasta de dados for apagada ou movida). O link fica a apontar
para nada e o `swaybg` mostra preto. Carrega em `SUPER + U` (ou corre `ubermensch off`):
o modo deteta o link partido, volta ao primeiro fundo do tema e avisa.

**`SUPER + U` não faz nada e aparece "Não encontrei End.jpg".** Os dados do modo não estão
instalados. Volta a correr `./install.sh` a partir do repositório.

**Os relâmpagos não aparecem no Ghostty.** Confirma que o teu `~/.config/ghostty/config`
tem a linha de [`exemplos/ghostty.conf`](exemplos/ghostty.conf) e que não os desligaste
com `SUPER + ALT + O`.

## Personalizar

Os dados ficam em `~/.local/share/bonvel/ubermensch/` (no BonVel, em `/usr/share/bonvel/ubermensch/`):

| Ficheiro | O que é |
|---|---|
| `frases.txt` | Frases de Nietzsche, uma por linha; acrescenta as tuas |
| `logo.txt` | Logótipo do `fastfetch` |
| `grayscale.glsl` | Shader do Hyprland para preto e branco |
| `relampagos.glsl` | Shader do Ghostty com os relâmpagos |
| `End.jpg` | Fundo do modo |

Se mudares estes ficheiros na pasta instalada, o `install.sh` volta a pô-los como estavam
quando atualizares; para mudanças permanentes, altera-os em `dados/` no repositório.

## Estrutura do repositório

| Caminho | Conteúdo |
|---|---|
| `ubermensch` | O comando (um único script bash) |
| `dados/` | Frases, logótipo, shaders e fundo |
| `install.sh` | Instalação e desinstalação na home |
| `exemplos/` | Trechos de configuração para Hyprland, Ghostty, waybar e hyprlock |

## Licença

[MIT](LICENSE).
