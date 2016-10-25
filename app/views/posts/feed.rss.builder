#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Francesca Galluzzi - Master's Student & Aspiring TD"
    xml.author "Francesca Galluzzi"
    xml.description "A website that serve as a blog and portfolio at the same time. Hence, it's my blogfolio!"
    xml.link "http://www.francesca.ga"
    xml.language "en"

    for article in @posts
      xml.item do
        if article.title
          xml.title article.title
        else
          xml.title ""
        end
        xml.author article.author.username
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link "http://www.francesca.ga/posts/" + article.slug
        xml.guid article.id

        xml.description article.body

      end
    end
  end
end