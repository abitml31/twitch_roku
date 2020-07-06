function init()
	m.content_grid=m.top.findNode("content_grid")
	m.header = m.top.FindNode("header")
	m.header.text = "Streams"
	m.content_grid.setFocus(true)
	m.top.observeField("visible", "onVisibleChange")
end function


function updateCategories(params)
	categories = params.data
	contentNode = createObject("roSGNode","ContentNode")
	for each category in categories
			node = createObject("roSGNode","category_node")
			node.title = category.user_name
			node.id = category.id
			node.HDGRIDPOSTERURL = category.thumbnail_url.replace("{width}","200").replace("{height}","100")
			node.SHORTDESCRIPTIONLINE1 = category.user_name
			node.SHORTDESCRIPTIONLINE2 = category.viewer_count.tostr() + " viewers"
			' ? "node.title : ";node.title
			' ? "node.id : ";node.id
			' ? "node.HDGRIDPOSTERURL:  ";node.HDGRIDPOSTERURL
			contentNode.appendChild(node)
	end for
	showpostergrid(contentNode)
end function

sub showpostergrid(content)
  m.content_grid.content=content
  m.content_grid.visible=true
  m.content_grid.setFocus(true)
end sub

sub onVisibleChange()
	if m.top.visible = true then
		m.content_grid.setFocus(true)
	end if
end sub
