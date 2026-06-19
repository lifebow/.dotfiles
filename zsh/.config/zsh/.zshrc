# install zinit
source $ZDOTDIR/zinit.zsh

zinit light zdharma-continuum/zinit-annex-bin-gem-node
zinit light zdharma-continuum/zinit-annex-binary-symlink

zinit wait lucid light-mode id-as depth'1' for \
    wintermi/zsh-brew \
    hlissner/zsh-autopair \
    Aloxaf/fzf-tab \
    atinit'zicompinit; zicdreplay -q' \
        zdharma-continuum/fast-syntax-highlighting \
    atload'_zsh_autosuggest_start' \
        zsh-users/zsh-autosuggestions

zinit id-as from'gh-r' lbin'!' completions for \
    lsd-rs/lsd \
    @sharkdp/fd \
    mv'**/bat.zsh -> _bat' \
        @sharkdp/bat

zinit for \
    id-as \
    from'gh-r' \
    lbin'**/rg -> rg' \
    completions \
    @BurntSushi/ripgrep

zinit for \
    id-as \
    from'gh-r' \
    atclone'
        ./**/uv generate-shell-completion zsh > _uv; \
        ./**/uvx --generate-shell-completion zsh > _uvx;
    ' \
    atpull'%atclone' \
    lbin'**/uv -> uv' \
    lbin'**/uvx -> uvx' \
    @astral-sh/uv

zinit for \
    id-as \
    from'gh-r' \
    mv'**/bin/fastfetch -> fastfetch' \
    atclone'for dir in fastfetch*/; do rm -rf "$dir"; done' \
    atpull'%atclone' \
    sbin'fastfetch' \
    @fastfetch-cli/fastfetch

zinit for \
    id-as \
    from'gh-r' \
    atclone'./zoxide init zsh > init.zsh' \
    atpull'%atclone' \
    lbin'!' \
    @ajeetdsouza/zoxide

if [[ "$OSTYPE" == darwin* ]]; then
    _fnm_asset='fnm-macos.zip'
else
    case "$(uname -m)" in
        aarch64|arm64) _fnm_asset='fnm-arm64.zip' ;;
        *) _fnm_asset='fnm-linux.zip' ;;
    esac
fi
zinit for \
    id-as \
    from'gh-r' \
    bpick"$_fnm_asset" \
    atclone'
        ./fnm env --use-on-cd --shell zsh > init.zsh; \
        ./fnm completions --shell zsh > _fnm;
    ' \
    atpull'%atclone' \
    blockf \
    sbin'fnm' \
    @Schniz/fnm
unset _fnm_asset

zinit for \
    id-as \
    from'gh-r' \
    atclone'
        ./starship init zsh > init.zsh; \
        ./starship completions zsh > _starship;
    ' \
    atpull'%atclone' \
    sbin'starship' \
    @starship/starship

zinit for \
    id-as \
    from'gh-r' \
    atclone'./fzf --zsh > init.zsh' \
    atpull'%atclone' \
    lbin'!fzf' \
    @junegunn/fzf

for script in $ZDOTDIR/config/*.zsh; do
    source "$script"
done
