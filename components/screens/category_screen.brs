function init()
	m.category_grid=m.top.findNode("category_grid")
	m.header = m.top.FindNode("header")
	m.header.text = "Games"
	m.category_grid.setFocus(true)
	m.top.observeField("visible", "onVisibleChange")
end function


function updateCategories(params)
	categories = params.data
	contentNode = createObject("roSGNode","ContentNode")
	for each category in categories
			node = createObject("roSGNode","category_node")
			node.title = category.name
			node.id = category.id
			node.SHORTDESCRIPTIONLINE1 = category.name
			node.HDGRIDPOSTERURL = category.box_art_url.replace("{width}","300").replace("{height}","280")
			' ? "node.title : ";node.title
			' ? "node.id : ";node.id
			' ? "node.HDGRIDPOSTERURL:  ";node.HDGRIDPOSTERURL
			contentNode.appendChild(node)
	end for
	showpostergrid(contentNode)
end function

sub showpostergrid(content)
  m.category_grid.content=content
  m.category_grid.visible=true
  m.category_grid.setFocus(true)
end sub

sub onVisibleChange()
	if m.top.visible = true then
		m.category_grid.setFocus(true)
	end if
end sub
