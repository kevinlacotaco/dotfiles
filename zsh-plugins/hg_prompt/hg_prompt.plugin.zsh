function hg_prompt_info() {
  hg log -l 1 2> /dev/null > /dev/null
  if (( $? != 0 )) return "";
  echo "$ZSH_THEME_HG_PROMPT_PREFIX$(hg prompt "$ZSH_THEME_HG_PROMPT_DATA")$ZSH_THEME_HG_PROMPT_SUFFIX"
}
