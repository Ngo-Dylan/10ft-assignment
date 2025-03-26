' ***************************************************
' *** init()
' ***************************************************
function init() as void
    m.background = m.top.FindNode("background")
    m.backplate = m.top.FindNode("backplate")
    m.title = m.top.FindNode("title")
    m.detail = m.top.FindNode("detail")
    m.title.font.size = 100
    m.background.ObserveFieldScoped("loadStatus", "onPosterLoadStatusChanged")
end function

' ***************************************************
' *** onViewCreated(data)
' ***************************************************
function onViewCreated(data) as void
    if (data = invalid) return
    m.background.uri = data.images.background.url
    m.title.text = data.title
    setDetail(data)
end function

' ***************************************************
' *** setDetail(data)
' ***************************************************
function setDetail(data as object) as void
    detail = []
    if (data.releaseDate <> "") detail.Push(data.releaseDate)
    if (data.ratings <> "") detail.Push(data.ratings)
    if (detail.IsEmpty()) return
    titleBoundingRect = m.title.BoundingRect()
    m.detail.translation = [120, titleBoundingRect.height + 220]
    m.detail.text = detail.Join("  •  ")
end function

' ***************************************************
' *** onPosterLoadStatusChanged()
' ***************************************************
function onPosterLoadStatusChanged() as void
    loadStatus = m.background.loadStatus
    m.backplate.visible = (loadStatus = "loading" OR loadStatus = "failed")
end function
