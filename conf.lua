-- Configuration

WINDOW_WIDTH = 680
WINDOW_HEIGHT = 480


function love.conf(t)
  t.title         = "My awesome game"
  --t.version       = "0.9.2"
  t.window.width  = WINDOW_WIDTH
  t.window.height = WINDOW_HEIGHT

  t.console = true
end