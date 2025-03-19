function init() as void
    m.viewStack = []
    m.views = m.top.FindNode("views")
    m.mainView = m.views.CreateChild("MainView")
    m.viewStack.Push(m.mainView)
    m.labelList = m.top.FindNode("LabelList")
    m.trackerUI = m.top.CreateChild("TrackerTask")
end function

function NavigateTo(viewName as string) as boolean
    switchView = m.views.CreateChild(viewName)
    switchView.SetFocus(true)
    m.viewStack.Push(switchView)
    m.mainView.visible = false
    return true
end function

function onKeyEvent(key, press) as Boolean
    isHandled = false
    if press then
        if (key = "back") AND (m.mainView.visible = false)
            m.views.RemoveChild(m.viewStack.Pop())
            m.mainView.visible = true
            m.labelList.SetFocus(true)
        end if
        isHandled = true
    end if
    return isHandled
end function
