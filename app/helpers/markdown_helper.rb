module MarkdownHelper
  class RougeRenderer < Redcarpet::Render::HTML
    def block_code(code, language)
      language ||= "text"
      formatter = Rouge::Formatters::HTML.new
      lexer = Rouge::Lexer.find_fancy(language) || Rouge::Lexers::PlainText.new
      %(<div class="code-block"><div class="code-lang">#{language}</div><pre><code class="highlight">#{formatter.format(lexer.lex(code))}</code></pre></div>)
    end
  end

  def render_markdown(text)
    return "" if text.blank?

    renderer = RougeRenderer.new(hard_wrap: true, link_attributes: { target: "_blank", rel: "noopener" })
    markdown = Redcarpet::Markdown.new(renderer,
      fenced_code_blocks: true,
      tables: true,
      autolink: true,
      strikethrough: true,
      superscript: true,
      highlight: true,
      no_intra_emphasis: true,
      space_after_headers: true
    )

    markdown.render(text).html_safe
  end
end
