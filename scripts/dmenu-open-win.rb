#!/usr/bin/env ruby

# get a list of all windows
window_list = `wmctrl -l`.split("\n").map {|l| l.strip.split(' ', 4)}

# write window names to a tmp file
File.open('/tmp/dmenu_goto_windows', 'w') do |f|
  window_list.each {|w| f.puts w[3] }
end

# bring up dmenu prompt, ask user to choose from window names in the tmp file
selected = `dmenu -i -fn Tamzen-12 -l 10 -p 'Goto window: ' < /tmp/dmenu_goto_windows`.strip

# find window data using its name
win = window_list.find {|w| w[3] == selected }

# switch to the window
`bspc window -f #{win[0]}` if win