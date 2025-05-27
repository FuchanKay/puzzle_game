_RELEASE_MODE = false
_DEMO = true

function love.conf(t)
	t.console = not _RELEASE_MODE
	t.title = 'Fuma is you'
	t.window.width = 0
    t.window.height = 0
	t.window.minwidth = 100
	t.window.minheight = 100
end