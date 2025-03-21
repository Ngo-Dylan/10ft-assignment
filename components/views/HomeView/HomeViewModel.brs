' ***************************************************
' *** createHomeViewModel()
' ***************************************************
function createHomeViewModel(viewContext as object) as object
    viewModel = {}
    viewModel.viewContext = viewContext
    viewModel.requestHomeData = requestHomeDataFunc
    return viewModel
end function

' ***************************************************
' *** requestHomeDataFunc()
' ***************************************************
function requestHomeDataFunc() as void
    homeModel = CreateObject("roSGNode", "HomeModel")
    homeModel.request = {
        "type": "Generic",
        "url": "https://cd-static.bamgrid.com/dp-117731241344/home.json"
    }
    homeModel.ObserveFieldScoped("data", "handleHomeResponse")
    homeModel.control = "RUN"
end function

' ***************************************************
' *** handleHomeResponse(event)
' ***************************************************
function handleHomeResponse(event as object) as void
    homeData = event.GetData()
    updateListData(homeData)
end function
