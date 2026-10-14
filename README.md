# Modo Übermensch

Um modo de concentração para Hyprland: escreves `ubermensch` (ou carregas em `SUPER + U`) e o ambiente muda.

- fundo `End.jpg`;
- ecrã a preto e branco (shader `grayscale.glsl`);
- terminal Ghostty preto com relâmpagos brancos sem parar (shader `relampagos.glsl`; as janelas já abertas mudam na hora);
- bordas brancas, mais espaço entre janelas, sem animações nem blur;
- notificações em "não incomodar" (os avisos do `notify-send` continuam a aparecer);
- perfil de energia `performance`, se o `powerprofilesctl` estiver instalado;
- `fastfetch` com logótipo próprio e uma frase de Nietzsche;
- **Ü** na waybar (clicar desliga o modo) e uma frase no ecrã de bloqueio.

`ubermensch off` volta ao fundo e às definições anteriores.

Nasceu no [BonVel OS](https://github.com/BON333/BonVel-linux), onde já vem instalado, e funciona também no [Omarchy](https://omarchy.org).

## Instalar

```bash
git clone https://github.com/BON333/ubermensch
cd ubermensch
./install.sh
```

O comando vai para `~/.local/bin/ubermensch` e os dados para `~/.local/share/bonvel/ubermensch/`.
Para remover: `./install.sh desinstalar`.

### Requisitos

- Hyprland, `swaybg` e a estrutura de temas do Omarchy (`~/.config/omarchy/current/`);
- opcionais: Ghostty, waybar, mako, hyprlock, fastfetch, powerprofilesctl, libnotify (`notify-send`).

### Integrações

O `install.sh` não mexe nas tuas configurações. Copia o que quiseres da pasta [`exemplos/`](exemplos):

| Ficheiro | Para quê |
|---|---|
| `hyprland.conf` | Atalho `SUPER + U` |
| `ghostty.conf` | Relâmpagos no terminal |
| `waybar.jsonc`, `waybar.css` | Indicador **Ü** na barra |
| `hyprlock.conf` | Frase de Nietzsche no ecrã de bloqueio |

## Comandos

| Comando | O que faz |
|---|---|
| `ubermensch` | Liga o modo |
| `ubermensch off` | Volta ao fundo e às definições anteriores |
| `ubermensch toggle` | Liga ou desliga (é o que o `SUPER + U` usa) |
| `ubermensch frase` | Mostra uma frase de Nietzsche |
| `ubermensch pomodoro [min]` | Temporizador com aviso no fim (25 minutos por omissão) |
| `ubermensch sessao` | Inicia o Tor, corre o `cktor` e abre um tmux com as janelas recon, notas e shell (pensado para o BonVel) |
| `ubermensch estado` | Estado em JSON, para a waybar |

Se um tema do Omarchy tiver o seu próprio `backgrounds/End.jpg`, é esse que o modo usa.

## Ficheiros

| Caminho | Conteúdo |
|---|---|
| `ubermensch` | O comando |
| `dados/frases.txt` | Frases de Nietzsche (uma por linha) |
| `dados/logo.txt` | Logótipo do `fastfetch` |
| `dados/grayscale.glsl` | Shader do Hyprland para preto e branco |
| `dados/relampagos.glsl` | Shader do Ghostty com os relâmpagos |
| `dados/End.jpg` | Fundo |
| `install.sh` | Instalação na home |
| `exemplos/` | Trechos de configuração |

## Licença

[MIT](LICENSE).
