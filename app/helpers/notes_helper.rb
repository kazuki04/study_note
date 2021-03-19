module NotesHelper
  require "redcarpet"
  require 'redcarpet/render_strip'
  require "coderay"

  class HTMLwithCoderay < Redcarpet::Render::HTML
    def block_code(code, language)
      language = language.split(':')[0]

      lang = case language.to_s
             when 'rb'
               'ruby'
             when 'yml'
               'yaml'
             when 'css'
               'css'
             when 'html'
               'html'
             when ''
               'md'
             else
               language
             end

      html = CodeRay.scan(code, lang).div
    end
  end

  def markdown(body)
    # render_options = {
    #     filter_html: true,
    #     hard_wrap: true
    # }

    extensions = {
      autolink: true,
      space_after_headers: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      tables: true,
      strikethrough: true,
      lax_spacing: true
    }

    html_renderer = HTMLwithCoderay.new(hard_wrap: true)
    markdown = Redcarpet::Markdown.new(html_renderer, extensions)
    markdown.render(body)
  end
end
