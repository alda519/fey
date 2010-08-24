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

    #link [url=]jmeno[/url] TODO
    #link [url]http:://url[/url] TODO
    #data.sub! /http:\/\/(.*) /, ""
    data
  end


  def flashRender flash
    fcode = String.new
    fcode += "<div class=\"flashnotice\">#{flash[:notice]}</div>"   if flash[:notice]
    fcode += "<div class=\"flashwarning\">#{flash[:warning]}</div>" if flash[:warning]
    fcode += "<div class=\"flasherror\">#{flash[:error]}</div>"     if flash[:error]
    fcode
  end

end
