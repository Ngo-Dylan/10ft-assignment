' ***************************************************
' *** init()
' ***************************************************
function init() as void
    m.viewList = m.top.FindNode("viewList")
    setupViewList()
    m.top.ObserveFieldScoped("focusedChild", "onFocusChanged")
    m.viewList.ObserveFieldScoped("itemSelected", "onViewSelected")
end function

' ***************************************************
' *** onFocusChanged()
' ***************************************************
function onFocusChanged() as void
    if (m.top.HasFocus())
        m.viewList.SetFocus(true)
    end if
end function

' ***************************************************
' *** setupViewList()
' ***************************************************
function setupViewList() as void
    viewListArr = [
        {id: "HomeView", title: "Home"}
    ]
    ' Dynamically creating Content Node for view list
    viewListContent = CreateObject("roSGNode", "ContentNode")
    for each item in viewListArr
        view = viewListContent.CreateChild("ContentNode")
        view.id = item.id
        view.title = item.title
    end for
    m.viewList.content = viewListContent
end function

' ***************************************************
' *** onViewSelected(event)
' ***************************************************
function onViewSelected(event as object) as void
    selectedViewIndex = event.GetData()
    selectedView = m.viewList.content.GetChild(selectedViewIndex)
    m.scene.CallFunc("NavigateTo", selectedView.id)
end function
