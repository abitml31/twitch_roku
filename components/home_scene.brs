function init()
	m.category_screen = m.top.findNode("category_screen")
	m.content_screen = m.top.findNode("content_screen")
	m.videoplayer = m.top.findNode("videoplayer")

	initializeVideoPlayer()
	m.category_screen.observeField("category_selected", "onCategorySelected")
	m.content_screen.observeField("content_selected", "onContentSelected")
	m.category_screen.setFocus(true)
	loadgames("https://api.twitch.tv/helix/games/top")
end function

sub onCategorySelected(obj)
	selected_index = obj.getData()
	m.selected_media = m.category_screen.findNode("category_grid").content.getChild(selected_index)
	? "m.selected_media.id : ",  m.selected_media.id
	loadStreamers(m.selected_media.id)
	m.category_screen.visible = false
	m.content_screen.visible = true
end sub

function loadgames(url)
	m.feed_task = createObject("roSGNode", "http")
	m.feed_task.observeField("response", "onDataResponse")
	m.feed_task.url = url
	m.feed_task.api = "getGames"
	m.feed_task.control = "RUN"
end function

function loadStreamers(id)
	m.feed_task = createObject("roSGNode", "http")
	m.feed_task.observeField("response", "onStreamerDataResponse")
	m.feed_task.url = "https://api.twitch.tv/helix/streams?language=en&game_id={}".replace("{}",id)
	m.feed_task.api = "getStreamers"
	? "m.feed_task.id : ",  id
	m.feed_task.id = id
	m.feed_task.control = "RUN"
end function

function onStreamerDataResponse(obj)
	params = obj.getData()
	m.content_screen.callFunc("updateCategories",params)
end function

function onDataResponse(obj)
	params = obj.getData()
	m.category_screen.callFunc("updateCategories",params)
	' m.content_screen.callFunc("updateCategories",params)
end function

sub initializeVideoPlayer()
	m.videoplayer.EnableCookies()
	m.videoplayer.setCertificatesFile("common:/certs/ca-bundle.crt")
	m.videoplayer.InitClientCertificates()
  ' m.videoplayer.notificationInterval=1
	' m.videoplayer.observeFieldScoped("position", "onPlayerPositionChanged")
	' m.videoplayer.observeFieldScoped("state", "onPlayerStateChanged")
end sub

function onContentSelected(obj)
	selected_index = obj.getData()
	m.selected_media = m.content_screen.findNode("content_grid").content.getChild(selected_index)
	?"Content selected"
	getVideoUrl(m.selected_media.title)
	m.category_screen.visible = false
	m.content_screen.visible = true
end function

function getVideoUrl(name)
	m.feed_task = createObject("roSGNode", "http")
	m.feed_task.observeField("response", "onVideoResponse")
	? "Video url  : ",  "https://urlfinder31.herokuapp.com/{}".replace("{}",name)
	m.feed_task.url = "https://urlfinder31.herokuapp.com/{}".replace("{}",name)
	m.feed_task.api = "getVideo"
	m.feed_task.control = "RUN"
end function

function onVideoResponse(obj)
	response = obj.getData()
	? "response.streamformat : ",  response.streamformat
	node = createObject("roSGNode","ContentNode")
	node.streamformat = response.streamformat
	node.url = response.url
	' play Video
	m.content_screen.visible = false
	m.videoplayer.visible = true
	m.videoplayer.setFocus(true)
	m.videoplayer.content = node
	m.videoplayer.control = "play"
end Function
