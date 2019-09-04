require 'nokogiri'
require 'pry'

def create_project_hash
  html=File.read('fixtures/kickstarter.html')
  kickstarter=Nokogiri::HTML(html)

  projects={}

  kickstarter.css("li.project.grid_4").each do |proj|
    title=proj.css(".bbcard_name a").text
    projects[title.to_sym]={
      :image_link => proj.css("div.project-thumbnail img").attr("src").value,
      :description => proj.css("p.bbcard_blurb").text,
      :location => proj.css("span.location-name").text,
      :percent_funded => proj.css("ul.project-stats li.first").text.gsub("%", "").to_i
    }
  end

  # projects: kickstarter.css("li.project.grid_4")
  # title: .css(".bbcard_name a").text
  # img: .css("div.project-thumbnail img").attr("src").value
  # desc: .css("p.bbcard_blurb").text
  # location: .css("span.location-name").text
  # percent: .css("ul.project-stats li.first").text.gsub("%", "").to_i
  projects

end