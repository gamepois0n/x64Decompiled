Panel_SeasonTexture:SetShow(false)
local effect_Pikapika = UI.getChildControl(Panel_SeasonTexture, "Static_PikaPika")
local effect_Lantern = UI.getChildControl(Panel_SeasonTexture, "Static_Lantern")
local effect_House = UI.getChildControl(Panel_SeasonTexture, "Static_House")
local currentMonth = ToClient_GetThisMonth()
local currentDay = ToClient_GetToday()
local isSpring, isSummer, isAutumn
local isWinter = 1 == currentMonth or 12 == currentMonth or 11 == currentMonth
local contentOpen = ToClient_isEventOn("Aurora")
local textureSize = {
  [0] = 300,
  [1] = 450,
  [2] = 900
}
local panelList = {
  [0] = {
    [0] = Panel_EnableSkill,
    [1] = nil,
    [2] = Panel_ItemMarket_Alarm
  },
  [1] = {
    [0] = Panel_Window_Inventory,
    [1] = Panel_Window_Warehouse,
    [2] = Panel_Window_Option,
    [3] = Panel_Window_Quest_New,
    [4] = Panel_Equipment,
    [5] = Panel_Menu,
    [6] = Panel_ChannelSelect,
    [7] = Panel_Window_PetListNew,
    [8] = Panel_AlchemyFigureHead,
    [9] = Panel_AlchemyStone,
    [10] = Panel_DyePalette,
    [11] = Panel_FriendList,
    [12] = Panel_Mail_Main,
    [13] = Panel_WorkerManager,
    [14] = Panel_GuildWarInfo,
    [15] = Panel_Chatting_Filter,
    [16] = Panel_CompetitionGame_JoinDesc,
    [17] = Panel_Window_ServantInfo,
    [18] = Panel_ShipInfo,
    [19] = Panel_WorkerShipInfo
  },
  [2] = {
    [0] = Panel_Window_Guild,
    [1] = Panel_Window_CharInfo_Status,
    [2] = Panel_WebControl,
    [3] = Panel_KeyboardHelp,
    [4] = Panel_ProductNote,
    [5] = Panel_Window_Skill,
    [6] = Panel_Manufacture,
    [7] = Panel_FishEncyclopedia,
    [8] = Panel_Window_ItemMarket,
    [9] = Panel_GuildRank_Web,
    [10] = Panel_LifeRanking,
    [11] = Panel_EventNotify,
    [12] = Panel_Window_DailyStamp,
    [13] = Panel_Window_BlackSpiritAdventure,
    [14] = Panel_LocalWarInfo,
    [15] = Panel_GameExit,
    [16] = Panel_CustomizingAlbum,
    [17] = Panel_ScreenShotAlbum
  }
}
if isUsedNewOption() then
  panelList[1][2] = Panel_Window_cOption
end
if isUsedNewTradeEventNotice_chk() then
  panelList[0][1] = Panel_TradeEventNotice_Renewal
else
  panelList[0][1] = Panel_TradeMarket_EventInfo
end
local panelInfo = {
  [0] = {
    [0] = {
      posX = 8,
      posY = -14,
      sizeX = 16
    },
    [1] = {
      posX = 8,
      posY = -14,
      sizeX = 16
    },
    [2] = {
      posX = 8,
      posY = -14,
      sizeX = 14
    }
  },
  [1] = {
    [0] = {
      posX = 6,
      posY = -14,
      sizeX = 14
    },
    [1] = {
      posX = 6,
      posY = -14,
      sizeX = 14
    },
    [2] = {
      posX = 20,
      posY = -10,
      sizeX = 40
    },
    [3] = {
      posX = 6,
      posY = -14,
      sizeX = 14
    },
    [4] = {
      posX = 6,
      posY = -14,
      sizeX = 14
    },
    [5] = {
      posX = 6,
      posY = -14,
      sizeX = -50
    },
    [6] = {
      posX = 2,
      posY = -14,
      sizeX = 4
    },
    [7] = {
      posX = 2,
      posY = -22,
      sizeX = 2
    },
    [8] = {
      posX = 11,
      posY = -14,
      sizeX = 22
    },
    [9] = {
      posX = 16,
      posY = -14,
      sizeX = 30
    },
    [10] = {
      posX = 6,
      posY = -14,
      sizeX = 14
    },
    [11] = {
      posX = 8,
      posY = -14,
      sizeX = 16
    },
    [12] = {
      posX = 6,
      posY = -14,
      sizeX = 14
    },
    [13] = {
      posX = 0,
      posY = -24,
      sizeX = 0
    },
    [14] = {
      posX = 6,
      posY = -14,
      sizeX = 14
    },
    [15] = {
      posX = 8,
      posY = -14,
      sizeX = 16
    },
    [16] = {
      posX = 4,
      posY = -20,
      sizeX = 6
    },
    [17] = {
      posX = 4,
      posY = -20,
      sizeX = 6
    },
    [18] = {
      posX = 24,
      posY = -14,
      sizeX = 50
    },
    [19] = {
      posX = 24,
      posY = -10,
      sizeX = 54
    }
  },
  [2] = {
    [0] = {
      posX = 28,
      posY = -10,
      sizeX = 54
    },
    [1] = {
      posX = 8,
      posY = -14,
      sizeX = 15
    },
    [2] = {
      posX = 0,
      posY = -22,
      sizeX = 0
    },
    [3] = {
      posX = 0,
      posY = -22,
      sizeX = 0
    },
    [4] = {
      posX = 8,
      posY = -14,
      sizeX = 16
    },
    [5] = {
      posX = 28,
      posY = -10,
      sizeX = 52
    },
    [6] = {
      posX = 25,
      posY = -10,
      sizeX = 52
    },
    [7] = {
      posX = 28,
      posY = -10,
      sizeX = 54
    },
    [8] = {
      posX = 0,
      posY = -22,
      sizeX = 0
    },
    [9] = {
      posX = 28,
      posY = -10,
      sizeX = 54
    },
    [10] = {
      posX = 26,
      posY = -10,
      sizeX = 52
    },
    [11] = {
      posX = 22,
      posY = -10,
      sizeX = 44
    },
    [12] = {
      posX = 28,
      posY = -10,
      sizeX = 55
    },
    [13] = {
      posX = 0,
      posY = -22,
      sizeX = 0
    },
    [14] = {
      posX = 28,
      posY = -10,
      sizeX = 55
    },
    [15] = {
      posX = 0,
      posY = -24,
      sizeX = 0
    },
    [16] = {
      posX = 8,
      posY = -14,
      sizeX = 15
    },
    [17] = {
      posX = 8,
      posY = -14,
      sizeX = 15
    }
  }
}
if isUsedNewOption() then
  panelInfo[1][2].posX = 0
  panelInfo[1][2].posY = -20
  panelInfo[1][2].sizeX = 0
end
if isGameTypeEnglish() then
  panelInfo[1][5].sizeX = -157
end
if 0 < ToClient_getGameOptionControllerWrapper():getUIFontSizeType() then
  panelInfo[1][5].sizeX = -207
end
local textureLink = {
  spring = "",
  summer = "",
  autumn = "",
  winter = "new_ui_common_forlua/window/winter/WinterUI_00.dds"
}
local ddsLink = ""
if isSpring then
  ddsLink = textureLink.spring
elseif isSummer then
  ddsLink = textureLink.summer
elseif isAutumn then
  ddsLink = textureLink.autumn
elseif isWinter then
  ddsLink = textureLink.winter
end
local windowTopTextureList = {
  [0] = {
    [0] = {
      _x1 = 455,
      _y1 = 316,
      _x2 = 755,
      _y2 = 378
    },
    [1] = {
      _x1 = 455,
      _y1 = 379,
      _x2 = 755,
      _y2 = 441
    },
    [2] = {
      _x1 = 455,
      _y1 = 442,
      _x2 = 755,
      _y2 = 504
    },
    [3] = {
      _x1 = 455,
      _y1 = 505,
      _x2 = 755,
      _y2 = 567
    },
    [4] = {
      _x1 = 455,
      _y1 = 568,
      _x2 = 755,
      _y2 = 630
    }
  },
  [1] = {
    [0] = {
      _x1 = 1,
      _y1 = 316,
      _x2 = 451,
      _y2 = 378
    },
    [1] = {
      _x1 = 1,
      _y1 = 379,
      _x2 = 451,
      _y2 = 441
    },
    [2] = {
      _x1 = 1,
      _y1 = 442,
      _x2 = 451,
      _y2 = 504
    },
    [3] = {
      _x1 = 1,
      _y1 = 505,
      _x2 = 451,
      _y2 = 567
    },
    [4] = {
      _x1 = 1,
      _y1 = 568,
      _x2 = 451,
      _y2 = 630
    }
  },
  [2] = {
    [0] = {
      _x1 = 0,
      _y1 = 1,
      _x2 = 900,
      _y2 = 63
    },
    [1] = {
      _x1 = 0,
      _y1 = 64,
      _x2 = 900,
      _y2 = 126
    },
    [2] = {
      _x1 = 0,
      _y1 = 127,
      _x2 = 900,
      _y2 = 189
    },
    [3] = {
      _x1 = 0,
      _y1 = 190,
      _x2 = 900,
      _y2 = 252
    },
    [4] = {
      _x1 = 0,
      _y1 = 253,
      _x2 = 900,
      _y2 = 315
    }
  }
}
local objectList = {
  public = {
    [0] = {
      sizeX = 72,
      sizeY = 41,
      posX = 130,
      posY = -15,
      _x1 = 758,
      _y1 = 318,
      _x2 = 830,
      _y2 = 359
    },
    [1] = {
      sizeX = 72,
      sizeY = 54,
      posX = 130,
      posY = -30,
      _x1 = 758,
      _y1 = 479,
      _x2 = 830,
      _y2 = 533
    },
    [2] = {
      sizeX = 52,
      sizeY = 41,
      posX = 130,
      posY = -20,
      _x1 = 835,
      _y1 = 316,
      _x2 = 887,
      _y2 = 359
    },
    [3] = {
      sizeX = 93,
      sizeY = 46,
      posX = 130,
      posY = -20,
      _x1 = 758,
      _y1 = 607,
      _x2 = 851,
      _y2 = 653
    },
    [4] = {
      sizeX = 136,
      sizeY = 54,
      posX = 180,
      posY = -30,
      _x1 = 1,
      _y1 = 631,
      _x2 = 137,
      _y2 = 685
    },
    [5] = {
      sizeX = 66,
      sizeY = 43,
      posX = 130,
      posY = -15,
      _x1 = 138,
      _y1 = 631,
      _x2 = 204,
      _y2 = 674
    }
  },
  effect = {
    _effectPikipika = {
      sizeX = 24,
      sizeY = 24,
      posX = 130,
      posY = -20,
      _x1 = 206,
      _y1 = 631,
      _x2 = 230,
      _y2 = 655
    },
    _effectLantern = {
      sizeX = 53,
      sizeY = 65,
      posX = 30,
      posY = -40,
      _x1 = 835,
      _y1 = 468,
      _x2 = 888,
      _y2 = 533
    },
    _effectHouse = {
      sizeX = 93,
      sizeY = 46,
      posX = 130,
      posY = -20,
      _x1 = 758,
      _y1 = 655,
      _x2 = 851,
      _y2 = 701
    }
  },
  private = {
    [0] = {},
    [1] = {
      [0] = {
        sizeX = 72,
        sizeY = 50,
        posX = 30,
        posY = -25,
        _x1 = 758,
        _y1 = 425,
        _x2 = 830,
        _y2 = 475
      },
      [1] = {
        sizeX = 72,
        sizeY = 54,
        posX = 30,
        posY = -25,
        _x1 = 758,
        _y1 = 364,
        _x2 = 830,
        _y2 = 418
      },
      [2] = {
        sizeX = 52,
        sizeY = 30,
        posX = 30,
        posY = -8,
        _x1 = 835,
        _y1 = 364,
        _x2 = 887,
        _y2 = 394
      },
      [3] = {
        sizeX = 53,
        sizeY = 65,
        posX = 30,
        posY = -40,
        _x1 = 835,
        _y1 = 394,
        _x2 = 887,
        _y2 = 463
      }
    },
    [2] = {
      [0] = {
        sizeX = 93,
        sizeY = 65,
        posX = 40,
        posY = -35,
        _x1 = 758,
        _y1 = 539,
        _x2 = 851,
        _y2 = 604
      }
    }
  }
}
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_TextureChange")
local textureControl = {}
local publicOjectControl = {}
function FromClient_luaLoadComplete_TextureChange()
  if not contentOpen then
    return
  end
  if "" == ddsLink then
    return
  end
  for index = 0, 2 do
    textureControl[index] = {}
    publicOjectControl[index] = {}
    for pIndex, panel in pairs(panelList[index]) do
      local temp = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, panel, "textureControl_" .. index .. "_" .. pIndex)
      temp:SetShow(true)
      temp:SetSize(panel:GetSizeX() - panelInfo[index][pIndex].sizeX, 62)
      temp:SetPosX(panelInfo[index][pIndex].posX)
      temp:SetPosY(panelInfo[index][pIndex].posY)
      temp:SetIgnore(true)
      textureControl[index][pIndex] = temp
      if nil ~= objectList.private[index][pIndex] then
        local temp = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, textureControl[index][pIndex], "privateTexture_ObjectControl_" .. index .. "_" .. pIndex)
        temp:SetSize(objectList.private[index][pIndex].sizeX, objectList.private[index][pIndex].sizeY)
        temp:SetPosX(objectList.private[index][pIndex].posX)
        temp:SetPosY(objectList.private[index][pIndex].posY)
        temp:SetShow(true)
        temp:SetIgnore(true)
        temp:ChangeTextureInfoName(ddsLink)
        local x1, y1, x2, y2 = setTextureUV_Func(temp, objectList.private[index][pIndex]._x1, objectList.private[index][pIndex]._y1, objectList.private[index][pIndex]._x2, objectList.private[index][pIndex]._y2)
        temp:getBaseTexture():setUV(x1, y1, x2, y2)
        temp:setRenderTexture(temp:getBaseTexture())
      end
      publicOjectControl[index][pIndex] = {}
      publicOjectControl[index][pIndex].snow = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, textureControl[index][pIndex], "publicTexture_ObjectControlSnow_" .. index .. "_" .. pIndex)
      publicOjectControl[index][pIndex].tree = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, textureControl[index][pIndex], "publicTexture_ObjectControlTree_" .. index .. "_" .. pIndex)
      publicOjectControl[index][pIndex].blackSpirit = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, textureControl[index][pIndex], "publicTexture_ObjectControlSpirit_" .. index .. "_" .. pIndex)
      publicOjectControl[index][pIndex].town = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, textureControl[index][pIndex], "publicTexture_ObjectControlTown_" .. index .. "_" .. pIndex)
      publicOjectControl[index][pIndex].penguin = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, textureControl[index][pIndex], "publicTexture_ObjectControlPenguin_" .. index .. "_" .. pIndex)
      publicOjectControl[index][pIndex].snowman = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, textureControl[index][pIndex], "publicTexture_ObjectControlSnowman_" .. index .. "_" .. pIndex)
      SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].snow, 0, panel:GetSizeX())
      SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].tree, 1, panel:GetSizeX())
      SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].blackSpirit, 2, panel:GetSizeX())
      SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].town, 3, panel:GetSizeX())
      SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].penguin, 4, panel:GetSizeX())
      SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].snowman, 5, panel:GetSizeX())
      publicOjectControl[index][pIndex].pikapikaeffect = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, textureControl[index][pIndex], "publicTexture_ObjectControlEffectPikaPika_" .. index .. "_" .. pIndex)
      CopyBaseProperty(effect_Pikapika, publicOjectControl[index][pIndex].pikapikaeffect)
      publicOjectControl[index][pIndex].questeffect = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, textureControl[index][pIndex], "publicTexture_ObjectControlEffectQuest_" .. index .. "_" .. pIndex)
      CopyBaseProperty(effect_Lantern, publicOjectControl[index][pIndex].questeffect)
      publicOjectControl[index][pIndex].questeffect:SetPosX(objectList.effect._effectLantern.posX)
      publicOjectControl[index][pIndex].questeffect:SetPosY(objectList.effect._effectLantern.posY)
      publicOjectControl[index][pIndex].towneffect = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, textureControl[index][pIndex], "publicTexture_ObjectControlEffectTown_" .. index .. "_" .. pIndex)
      CopyBaseProperty(effect_House, publicOjectControl[index][pIndex].towneffect)
      publicOjectControl[index][pIndex].towneffect:SetPosX(panel:GetSizeX() - objectList.effect._effectHouse.posX)
      publicOjectControl[index][pIndex].towneffect:SetPosY(objectList.effect._effectHouse.posY)
      panel:RegisterShowPreUpdateFunc("seasonTexturChangebyPanelName")
    end
  end
  seasonTexturChangebyPanelName()
end
function SeasonTexture_ObjectCreate(control, index, panelSizeX)
  control:SetSize(objectList.public[index].sizeX, objectList.public[index].sizeY)
  control:SetPosX(panelSizeX - objectList.public[index].posX)
  control:SetPosY(objectList.public[index].posY)
  control:SetShow(false)
  control:SetIgnore(true)
  control:ChangeTextureInfoName(ddsLink)
  local x1, y1, x2, y2 = setTextureUV_Func(control, objectList.public[index]._x1, objectList.public[index]._y1, objectList.public[index]._x2, objectList.public[index]._y2)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function seasonTexturChangebyPanelName(currentPanelName)
  if not contentOpen then
    return
  end
  local randomPosX = math.ceil(math.random(0, 9))
  for index = 0, 2 do
    for pIndex, panel in pairs(panelList[index]) do
      if nil == currentPanelName or panel:GetID() == currentPanelName then
        local temp = textureControl[index][pIndex]
        local rndIndex = math.floor(math.random(0, 4))
        temp:ChangeTextureInfoName(ddsLink)
        local x1, y1, x2, y2 = setTextureUV_Func(temp, windowTopTextureList[index][rndIndex]._x1, windowTopTextureList[index][rndIndex]._y1, windowTopTextureList[index][rndIndex]._x2, windowTopTextureList[index][rndIndex]._y2)
        temp:getBaseTexture():setUV(x1, y1, x2, y2)
        temp:setRenderTexture(temp:getBaseTexture())
        publicOjectControl[index][pIndex].snow:SetShow(false)
        publicOjectControl[index][pIndex].tree:SetShow(false)
        publicOjectControl[index][pIndex].blackSpirit:SetShow(false)
        publicOjectControl[index][pIndex].town:SetShow(false)
        publicOjectControl[index][pIndex].penguin:SetShow(false)
        publicOjectControl[index][pIndex].snowman:SetShow(false)
        publicOjectControl[index][pIndex].questeffect:SetShow(false)
        publicOjectControl[index][pIndex].towneffect:SetShow(false)
        publicOjectControl[index][pIndex].pikapikaeffect:SetShow(false)
        if 1 == index and 6 == pIndex then
          break
        end
        local randomShow = math.floor(math.random(0, 7))
        if 0 == randomShow then
          publicOjectControl[index][pIndex].snow:SetShow(true)
          publicOjectControl[index][pIndex].pikapikaeffect:SetShow(true)
          publicOjectControl[index][pIndex].pikapikaeffect:SetPosX(publicOjectControl[index][pIndex].snow:GetPosX() + publicOjectControl[index][pIndex].snow:GetSizeX() - randomPosX / 10 * publicOjectControl[index][pIndex].snow:GetSizeX())
          publicOjectControl[index][pIndex].pikapikaeffect:SetPosY(publicOjectControl[index][pIndex].snow:GetPosY() - publicOjectControl[index][pIndex].pikapikaeffect:GetSizeY() + 5)
        elseif 1 == randomShow then
          publicOjectControl[index][pIndex].tree:SetShow(true)
        elseif 2 == randomShow then
          publicOjectControl[index][pIndex].blackSpirit:SetShow(true)
          publicOjectControl[index][pIndex].pikapikaeffect:SetShow(true)
          publicOjectControl[index][pIndex].pikapikaeffect:SetPosX(publicOjectControl[index][pIndex].blackSpirit:GetPosX() + publicOjectControl[index][pIndex].blackSpirit:GetSizeX() - randomPosX / 10 * publicOjectControl[index][pIndex].blackSpirit:GetSizeX())
          publicOjectControl[index][pIndex].pikapikaeffect:SetPosY(publicOjectControl[index][pIndex].blackSpirit:GetPosY() - publicOjectControl[index][pIndex].pikapikaeffect:GetSizeY() + 5)
        elseif 3 == randomShow then
          publicOjectControl[index][pIndex].town:SetShow(true)
          publicOjectControl[index][pIndex].towneffect:SetShow(true)
        elseif 4 == randomShow then
          publicOjectControl[index][pIndex].penguin:SetShow(true)
          publicOjectControl[index][pIndex].pikapikaeffect:SetShow(false)
        elseif 5 == randomShow then
          publicOjectControl[index][pIndex].snowman:SetShow(true)
          publicOjectControl[index][pIndex].pikapikaeffect:SetShow(false)
        end
        if 1 == index and 3 == pIndex then
          publicOjectControl[index][pIndex].questeffect:SetShow(true)
        end
        return
      end
    end
  end
end
function FGlobal_SeasonTexture_ChannelSelectPanelSizeCahnge(sizeX)
  if isLuaLoadingComplete and contentOpen then
    textureControl[1][6]:SetSize(sizeX, textureControl[1][6]:GetSizeY())
  end
end
