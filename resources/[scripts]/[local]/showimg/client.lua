vrp_showimgC = {}
Tunnel.bindInterface("vrp_showimg", vrp_showimgC)
Proxy.addInterface("vrp_showimg", vrp_showimgC)
vRP = Proxy.getInterface("vRP")
vrp_showimgS = Tunnel.getInterface("vrp_showimg", "vrp_showimg")

function vrp_showimgC.showImg(url, time, alpha)
    print(url,time,alpha)
    SendNUIMessage({action = "show", url = url, time = time, alpha = alpha})
end

function vrp_showimgC.hideImg()
    SendNUIMessage({action = "hide"})
end
