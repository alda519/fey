# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def bbCode data
    #newline
    data.gsub! "\n", "<br />"

    # bold, italics, underline, code [x] [/x]
    data.gsub! /\[(\/|)(b|u|i|code)\]/, '<\1\2>'   # b u i

    #text color TODO
    # [color=kod][/color]

    #text size TODO
    # [size=procenta][/size]

    #img [img]source[/img]
    x = data.split '[img]'
    x.each_index do |i|
      x[i].gsub! /(.*)\[\/img\]/, '<img src="\1" /><br clear="both" />' 
    end
    data = x.join

    data
  end

end
