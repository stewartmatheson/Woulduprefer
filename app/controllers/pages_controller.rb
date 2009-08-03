class PagesController < ApplicationController
  def feed
    @questions = Question.find(:all, :limit => 10, :order => "created_at DESC")
    render :layout => false
  end
  
  def news
    require 'rss/2.0'
    require 'open-uri'    
    url = 'http://rtmatheson.com/category/woulduprefer/feed/'
    @feed = parse url
  end
  
  def about
  end
  
  private
  
  def parse(url)
    require 'rexml/document'
    xml = REXML::Document.new Net::HTTP.get(URI.parse(url))
    data = {
      :title    => xml.root.elements['channel/title'].text,
      :home_url => xml.root.elements['channel/link'].text,
      :rss_url  => url,
      :items    => []
    }
    xml.elements.each '//item' do |item|
      new_items = {} and item.elements.each do |e| 
        new_items[e.name.gsub(/^dc:(\w)/,"\1").to_sym] = e.text
      end
      data[:items] << new_items
    end
    data
	end

end