Pry.history.instance_eval do
  if ENV['PRY_READLINE_WORKAROUND']
    @saver = ->(line) { save_to_file (line.force_encoding(STDIN.external_encoding))}
  end
end
