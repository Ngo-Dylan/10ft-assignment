' ***************************************************
' *** createHomeViewModel()
' ***************************************************
function createHomeViewModel(viewContext as object) as object
    viewModel = {}
    viewModel.viewContext = viewContext
    viewModel.requestHomeData = requestHomeDataFunc
    viewModel.requestRefData = requestRefDataFunc
    return viewModel
end function

' ***************************************************
' *** requestHomeDataFunc()
' ***************************************************
function requestHomeDataFunc() as void
    homeModel = CreateObject("roSGNode", "HomeModel")
    homeModel.request = {
        "apiType": "Generic",
        "url": "https://cd-static.bamgrid.com/dp-117731241344/home.json"
    }
    homeModel.ObserveFieldScoped("data", "handleHomeResponse")
    homeModel.control = "RUN"
end function

' ***************************************************
' *** handleHomeResponse(event)
' ***************************************************
function handleHomeResponse(event as object) as void
    updateListData(event.GetData())
end function

' ***************************************************
' *** requestRefDataFunc(refData)
' ***************************************************
function requestRefDataFunc(refData) as void
    if (refData = invalid AND refData.IsEmpty()) return

    homeModel = CreateObject("roSGNode", "HomeModel")
    homeModel.request = {
        "apiType": "Ref",
        "refType": refData.refType,
        "title": refData.title
        "url": Substitute("https://cd-static.bamgrid.com/dp-117731241344/sets/{0}.json", refData.refId)
    }
    homeModel.ObserveFieldScoped("data", "handleRefResponse")
    homeModel.control = "RUN"
end function

' ***************************************************
' *** handleRefResponse(event)
' ***************************************************
function handleRefResponse(event as object) as void
    updateRefData(event.GetData())
end function
