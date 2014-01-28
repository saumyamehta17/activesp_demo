#Dir.foreach('/home/sweety/Desktop/ROR_Project') do |item|
#  puts item
#end
#
#Dir.glob("https://aequor1.sharepoint.com/Technologies/SRDS/Project%20Management/Forms/AllItems.aspx/**/*").each do |item|
#  puts item
#end

require 'rubygems'
require 'activesp'

def browse(item, indentation = 0)
  puts "  " * indentation + "- " + item.class.to_s + " : " + item.url
  case item
    when ActiveSP::Site
      puts "  " * indentation + "    Title = #{item.Title}, Description = #{item.Description}"
      item.sites.each { |site| browse(site, indentation + 1) }
      item.lists.each { |list| browse(list, indentation + 1) }
    when ActiveSP::List
      puts "  " * indentation + "    Description = #{item.Description}, Hidden = #{item.Hidden}"
      item.items.each { |item| browse(item, indentation + 1) }
    when ActiveSP::Folder
      item.items.each { |item| browse(item, indentation + 1) }
    when ActiveSP::Item
      item.content_urls.each do |url|
        puts "  " * indentation + "    Content URL = #{url}"
      end
  end
end

c = ActiveSP::Connection.new(:login => "sweety.mehta@hotmail.com", :password => "Helpline8", :root => "https://aequor1.sharepoint.com/Technologies/SRDS/Project%20Management/Forms/AllItems.aspx")
browse(c.root)