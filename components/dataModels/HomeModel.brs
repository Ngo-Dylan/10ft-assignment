' ***************************************************
' *** init()
' ***************************************************
function init() as void
    m.top.functionName = "fetchHomeData"
end function

' ***************************************************
' *** fetchHomeData()
' ***************************************************
function fetchHomeData() as void
    requestData = m.top.request
    requestUrl = requestData.url
    response = makeGetRequest(requestUrl)
    if (requestData.apiType = "Generic")
        m.top.data = parseGenericData(ParseJson(response))
    else if (requestData.apiType = "Ref")
        response = ParseJson(response)
        m.top.data = parseRefData(response, requestData.refType, requestData.title)
    end if
end function

' ***************************************************
' *** makeGetRequest(requestUrl)
' ***************************************************
function makeGetRequest(requestUrl as string) as object
    port = CreateObject("roMessagePort")
    urlTransfer = CreateObject("roUrlTransfer")
    urlTransfer.SetMessagePort(port)
    urlTransfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    urlTransfer.SetUrl(requestUrl)

    if (urlTransfer.AsyncGetToString())
        while (true)
            message = Wait(0, port)
            messageType = Type(message)
            if (messageType = "roUrlEvent")
                httpCode = message.GetResponseCode()
                if (httpCode = 200)
                    return (message.GetString())
                else
                    return invalid
                end if
                exit while
            else if (message = invalid)
                urlTransfer.AsyncCancel()
            end if
        end while
    end if
    return invalid
end function
