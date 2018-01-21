function PaGlobal_URL_Check(param1)
  local url
  if CppEnums.CountryType.DEV == getGameServiceType() then
    url = "http://10.32.129.20"
  elseif CppEnums.CountryType.KOR_ALPHA == getGameServiceType() then
    local isAdult = ToClient_isAdultUser()
    if isAdult then
      url = "https://test.contents.black.game.daum.net:8885"
    else
      url = "https://test15.contents.black.game.daum.net:8885"
    end
  elseif CppEnums.CountryType.KOR_REAL == getGameServiceType() then
    local isAdult = ToClient_isAdultUser()
    if isAdult then
      url = "https://live.contents.black.game.daum.net:8885"
    else
      url = "https://live15.contents.black.game.daum.net:8885"
    end
  elseif CppEnums.CountryType.NA_ALPHA == getGameServiceType() then
    if 0 == getServiceNationType() then
      url = "https://gameweb-na980.blackdesertonline.com"
    elseif 1 == getServiceNationType() then
      url = "https://gameweb-eu990.blackdesertonline.com"
    end
  elseif CppEnums.CountryType.NA_REAL == getGameServiceType() then
    if 0 == getServiceNationType() then
      url = "https://gameweb-na" .. param1 .. ".blackdesertonline.com"
    elseif 1 == getServiceNationType() then
      url = "https://gameweb-eu" .. param1 .. ".blackdesertonline.com"
    end
  elseif CppEnums.CountryType.JPN_ALPHA == getGameServiceType() then
    url = "http://web-test.blackdesertonline.jp"
  elseif CppEnums.CountryType.JPN_REAL == getGameServiceType() then
    url = "https://bdoweb.pmang.jp"
  elseif CppEnums.CountryType.RUS_ALPHA == getGameServiceType() then
    url = "https://bdoweb-qa.gamenet.ru"
  elseif CppEnums.CountryType.RUS_REAL == getGameServiceType() then
    if isServerFixedCharge() then
      url = "https://bdoweb-p2p.gamenet.ru"
    else
      url = "https://bdoweb-f2p.gamenet.ru"
    end
  elseif CppEnums.CountryType.TW_ALPHA == getGameServiceType() then
    url = "http://qa-game.blackdesert.com.tw"
  elseif CppEnums.CountryType.TW_REAL == getGameServiceType() then
    url = "https://game.blackdesert.com.tw"
  elseif CppEnums.CountryType.SA_ALPHA == getGameServiceType() then
    url = "http://blackdesert-web-qa.playredfox.com"
  elseif CppEnums.CountryType.SA_REAL == getGameServiceType() then
    url = "https://blackdesert-web.playredfox.com"
  elseif CppEnums.CountryType.KR2_ALPHA == getGameServiceType() then
    url = "http://192.168.0.1"
  elseif CppEnums.CountryType.KR2_REAL == getGameServiceType() then
    url = "http://192.168.0.1"
  elseif CppEnums.CountryType.TR_ALPHA == getGameServiceType() then
    url = "http://game-qa.tr.playblackdesert.com"
  elseif CppEnums.CountryType.TR_REAL == getGameServiceType() then
    url = "https://game.tr.playblackdesert.com"
  elseif CppEnums.CountryType.TH_ALPHA == getGameServiceType() then
    url = "http://game-qa.th.playblackdesert.com"
  elseif CppEnums.CountryType.TH_REAL == getGameServiceType() then
    url = "https://game.th.playblackdesert.com"
  elseif CppEnums.CountryType.ID_ALPHA == getGameServiceType() then
    url = "http://game-qa.sea.playblackdesert.com"
  elseif CppEnums.CountryType.ID_REAL == getGameServiceType() then
    url = "https://game.sea.playblackdesert.com"
  else
    _PA_LOG("\236\160\149\237\131\156\234\179\164", "\236\131\136\235\161\156\236\154\180 \234\181\173\234\176\128 \237\131\128\236\158\133\236\158\133\235\139\136\235\139\164!!!!! global_define_url.lua \236\151\144 \234\188\173 \236\182\148\234\176\128\237\149\180\236\163\188\236\132\184\236\154\148!!!!")
  end
  return url
end
