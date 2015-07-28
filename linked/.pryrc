Pry.history.instance_eval do
   @saver = ->(line) { save_to_file (line.force_encoding(STDIN.external_encoding))}
end
