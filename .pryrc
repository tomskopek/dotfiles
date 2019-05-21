# Pry.config.editor = "vim --noplugin"
Pry.commands.alias_command 'ec', 'edit -c'

Pry::Commands.block_command 'cp', "Alias to copy last output to clipboard" do
  `echo #{_pry_.last_result} | pbcopy`
end

require 'rb-readline'

def RbReadline.rl_reverse_search_history(sign, key)
  rl_insert_text  `cat ~/.pry_history | fzf --tac --no-sort |  tr '\n' ' '`
end
