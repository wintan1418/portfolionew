import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return

    this.canvas = document.createElement("canvas")
    this.canvas.className = "code-rain-canvas"
    this.canvas.style.cssText = "position:fixed;top:0;left:0;width:100%;height:100%;pointer-events:none;z-index:0;"
    this.element.prepend(this.canvas)
    this.ctx = this.canvas.getContext("2d")

    // Real code fragments — short, punchy, recognizable
    this.fragments = [
      // Ruby / Rails real code
      "def initialize", "end", "class User", "module API", "Rails.application",
      "has_many :posts", "belongs_to :user", "validates :name", "before_action",
      "render json:", "redirect_to", "params.require", "scope :active",
      "ActiveRecord::Base", "ApplicationController", "attr_accessor",
      "rescue => e", "yield self", "lambda { |x|", "Proc.new",
      ".where(status:", ".order(created_at:", ".includes(:user)",
      "config.routes", "resources :projects", "namespace :admin",
      "has_one_attached", "after_commit", "serialize :data",
      "Thread.new {", "Mutex.new", "Queue.new",
      "gem 'rails'", "bundle exec", "rake db:migrate",
      "ENV['SECRET']", "Rails.env.production?", "Rails.cache.fetch",

      // AI / ML code
      "model.predict(x)", "torch.tensor", "np.array([", "loss.backward()",
      "optimizer.step()", "nn.Linear(512,", "attention_mask", "embeddings[i]",
      "transformer.encode", "softmax(logits)", "gradient_descent",
      "batch_size=32", "learning_rate=", "epoch += 1",
      "model.train()", "torch.no_grad()", "F.relu(x)",

      // Operators & symbols (the Matrix vibe)
      "=>", "->", "|>", "::", "&&", "||", "!=", "===", "<=>", "**",
      "<<", ">>", "+=", "-=", "*=", "/=", "%=", "&=", "|=", "^=",
      "{}", "[]", "()", "<>", "//", "##", "@@", "$$", "!!", "??",
      "0x1F", "0b1010", "0xFF", "\\n", "\\t", "#{}", "<%=", "%>",

      // Real code one-liners
      "if true", "else", "elsif", "unless nil?", "while running",
      "loop do", "break if", "next unless", "return false",
      "raise Error", "throw :halt", "catch(:done)",
      "File.read(path)", "JSON.parse(data)", "URI.parse(url)",
      "puts result", "p debug_info", "pp object",
      "require 'json'", "include Module", "extend ClassMethods",
      "self.new", "super(args)", "send(:method)",
      "map { |x| x * 2 }", ".select(&:valid?)", ".reject(&:nil?)",
      ".reduce(:+)", ".flat_map", ".each_with_object",
      "respond_to?(:call)", "method_missing", "const_get",

      // DevOps / terminal
      "git push origin", "docker build .", "ssh deploy@",
      "curl -X POST", "nginx -s reload", "systemctl start",
      "SELECT * FROM", "INSERT INTO", "CREATE INDEX",
      "redis.get(key)", "cache.write(k,v)", "queue.push(job)",

      // Single chars for Matrix density
      "{", "}", "[", "]", "(", ")", "<", ">", "/", "\\",
      "#", "@", "$", "%", "^", "&", "*", "~", "`", "|",
      "0", "1", "0", "1", "0", "1", "0", "1", "0", "1",
      ";", ":", ".", ",", "=", "+", "-", "_", "!", "?",
    ]

    this.columns = []
    this.handleResize()
    this.resizeHandler = this.handleResize.bind(this)
    window.addEventListener("resize", this.resizeHandler, { passive: true })
    this.lastTime = 0
    this.animate(0)
  }

  disconnect() {
    if (this.animFrame) cancelAnimationFrame(this.animFrame)
    if (this.resizeHandler) window.removeEventListener("resize", this.resizeHandler)
    if (this.canvas) this.canvas.remove()
  }

  handleResize() {
    const dpr = Math.min(window.devicePixelRatio || 1, 2)
    const w = window.innerWidth
    const h = window.innerHeight
    this.canvas.width = w * dpr
    this.canvas.height = h * dpr
    this.ctx.scale(dpr, dpr)
    this.w = w
    this.h = h

    // Dense columns — every ~55px
    const colWidth = 55
    const numCols = Math.ceil(w / colWidth)

    this.columns = Array.from({ length: numCols }, (_, i) => this.createColumn(i, numCols))
  }

  createColumn(index, total) {
    const x = (index / total) * this.w + (Math.random() - 0.5) * 20
    return {
      x,
      y: Math.random() * this.h * -1.5,
      speed: 0.4 + Math.random() * 1.2,
      items: this.pickItems(8 + Math.floor(Math.random() * 8)),
      headIndex: 0,
      advanceAccum: 0,
      spacing: 18 + Math.random() * 6,
      trailLen: 6 + Math.floor(Math.random() * 10),
      baseAlpha: 0.06 + Math.random() * 0.1,
      fontSize: 11 + Math.floor(Math.random() * 3),
    }
  }

  pickItems(count) {
    const items = []
    for (let i = 0; i < count; i++) {
      items.push(this.fragments[Math.floor(Math.random() * this.fragments.length)])
    }
    return items
  }

  animate(timestamp) {
    const dt = Math.min(timestamp - this.lastTime, 50)
    this.lastTime = timestamp

    const { ctx, w, h } = this

    // Full clear each frame
    ctx.clearRect(0, 0, w, h)
    ctx.textBaseline = "top"

    for (const col of this.columns) {
      col.y += col.speed * (dt / 16)

      // Advance to next text item periodically
      col.advanceAccum += col.speed * (dt / 16)
      if (col.advanceAccum >= col.spacing) {
        col.advanceAccum -= col.spacing
        col.headIndex = (col.headIndex + 1) % col.items.length
      }

      ctx.font = `500 ${col.fontSize}px "JetBrains Mono", ui-monospace, monospace`

      // Draw trail
      for (let t = 0; t < col.trailLen; t++) {
        const trailY = col.y - t * col.spacing
        if (trailY < -30 || trailY > h + 30) continue

        const itemIdx = (col.headIndex - t + col.items.length * 100) % col.items.length
        const text = col.items[itemIdx]

        // Head is bright, trail fades out
        const progress = t / col.trailLen
        const fade = Math.pow(1 - progress, 1.5)

        if (t === 0) {
          // Lead character — bright primary
          ctx.fillStyle = `rgba(129, 140, 248, ${col.baseAlpha * 3.5})`
        } else if (t === 1) {
          // Second — slightly dimmer primary
          ctx.fillStyle = `rgba(99, 102, 241, ${col.baseAlpha * 2.5 * fade})`
        } else if (t < 3) {
          // Near-head — cyan accent
          ctx.fillStyle = `rgba(34, 211, 238, ${col.baseAlpha * 1.8 * fade})`
        } else {
          // Trail body — slate
          ctx.fillStyle = `rgba(148, 163, 184, ${col.baseAlpha * fade})`
        }

        ctx.fillText(text, col.x, trailY)
      }

      // Reset when off screen
      if (col.y - col.trailLen * col.spacing > h) {
        col.y = -(col.trailLen * col.spacing) - Math.random() * h * 0.4
        col.items = this.pickItems(col.items.length)
        col.headIndex = 0
        col.speed = 0.4 + Math.random() * 1.2
        col.baseAlpha = 0.06 + Math.random() * 0.1
      }
    }

    this.animFrame = requestAnimationFrame((t) => this.animate(t))
  }
}
