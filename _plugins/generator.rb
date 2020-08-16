module Jekyll
    class ContentPageGenerator < Generator
        safe true

        def generate(site)
            content = site.data['content']
            content.each do |item|
                next if item['date'].nil? && item['currently'].nil?
                site.pages << ContentPage.new(
                    site,
                    site.source,
                    "content/#{Utils.slugify(item['name'])}",
                    item
                )
            end
        end
    end

    class ContentPage < Page
        def initialize(site, base, dir, item)
            @site = site
            @base = base
            @dir  = dir
            @name = 'index.html'

            self.process(@name)
            self.read_yaml(File.join(base, '_layouts'), 'content.html')
            self.data['item'] = item
            self.data['summary'] = item['summary']
            self.data['title'] = item['name']
        end
    end
end